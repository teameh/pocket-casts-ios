import MountebankSwift
import XCTest

enum Server: String, CaseIterable {
    case refresh
    case api
    case cache
    case `static`

    var host: String { "\(rawValue).pocketcasts.com" }
    var url: String { "https://\(host)/" }
    var launchEnvironmentKey: String { "uitesting.server.\(rawValue)" }
}

@MainActor
final class UITests: XCTestCase {
    private var mountebank: Mountebank! = Mountebank(host: .localhost)
    private var imposters: [Imposter] = []

    override func setUp() async throws {
        continueAfterFailure = false
        try await mountebank.testConnection()
    }

    func setupImposters() async throws -> [String: String] {
        try await mountebank.deleteAllImposters()

        var launchEnvironment = [String: String]()

        for server in Server.allCases {
            let proxy = Stub(
                response: Proxy(
                    to: server.url,
                    networkProtocolParameters: .https(injectHeaders: [
                        "Host": server.host,
                        "Accept-Encoding": "identity"
                    ]),
                    mode: .proxyAlways,
                    predicateGenerators: [
                        PredicateGenerator.matches(
                            fields: ["path": true, "method": true]
                        )
                    ],
                    addWaitBehavior: true
                )
            )

            let imposter = Imposter(
                networkProtocol: .http(allowCORS: true),
                name: server.rawValue,
                stubs: [proxy],
                recordRequests: true
            )

            let createdImposter = try await mountebank.postImposter(imposter: imposter)
            launchEnvironment[server.launchEnvironmentKey] = mountebank
                .makeImposterUrl(port: createdImposter.port!)
                .absoluteString + "/"
        }

        return launchEnvironment
    }

    func setupImpostersWithStubs() async throws -> [String: String] {
        let servers = [
            Server.refresh: stubsForRefreshServer,
            Server.api: stubsForApiServer,
            Server.cache: stubsForCacheServer,
            Server.static: stubsForStaticServer
        ]

        var launchEnvironment = [String: String]()

        for (serverName, stubs) in servers {
            let imposter = Imposter(
                networkProtocol: .http(),
                name: serverName.rawValue,
                stubs: stubs,
                recordRequests: true
            )

            let createdImposter = try await mountebank.postImposter(imposter: imposter)
            launchEnvironment[serverName.launchEnvironmentKey] = mountebank
                .makeImposterUrl(port: createdImposter.port!)
                .absoluteString + "/"
        }

        return launchEnvironment
    }

    func testRecordWithProxy() async throws {
        print(#function)
        let app = XCUIApplication()
        app.launchArguments = ["-UITesting"]
        app.launchEnvironment = try await setupImposters()
        app.launch()
        app.buttons["Does-not-exist"].waitForThenTap(timeout: 20000) // this will never stop
    }

    func testRegisterFlow() async throws {
        let imposters = try await mountebank.getAllImposters(replayable: true, removeProxies: true)
        for imposter in imposters {
            imposter.writeStubsToDisk()
        }
    }
}
