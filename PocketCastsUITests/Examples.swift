import Foundation
import UIKit

enum PodcastError: Error {
    case invalidURL
    case invalidResponse
}
struct Podcast {

}

class AppDelegate: UIResponder, UIApplicationDelegate {
    func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
    ) -> Bool {

        if ProcessInfo.processInfo.arguments.contains("-UITesting") {
            // Swizzle
        }
        
        return true
    }
}


func validate(response: URLResponse) throws {

}

func makeRequest() -> URLRequest {

}

func decode(response: URLResponse) throws -> [Podcast] {
    []
}

func testPlayPodcast() async throws {
    MyNetworkStack.session = MyStubSession()

    let app = XCUIApplication()

    app.launch()

    // perform
}



protocol Session {
    func data(
        for request: URLRequest
    ) async throws -> (Data, URLResponse)
}

struct StubSession: Session {
    static var shared = StubSession()

    var responses: [URLRequest: (Data, URLResponse)] = [:]

    func data(for request: URLRequest, delegate: URLSessionTaskDelegate?) async throws -> (Data, URLResponse) {
        if let (data, response) = responses[request] {
            return (data, response)
        }

        return (Data(), HTTPURLResponse(url: request.url!, statusCode: 404, httpVersion: nil, headerFields: nil)!)
    }
}


extension URLSession: Session {}

func makeSession() -> Session {
    ProcessInfo.processInfo.arguments.contains("-UITesting")
        ? StubSession.shared
        : URLSession.shared
}

enum StubYourOwnCode1 {

    func fetchPodcasts(request: URLRequest) async throws -> [Podcast] {
        let (data, response) = try await URLSession.shared.data(for: request)

        // handle result
    }

}

enum StubYourOwnCode2 {

    func fetchPodcasts(request: URLRequest) async throws -> [Podcast] {
        var session: Session = ProcessInfo.processInfo.arguments.contains("-UITesting")
            ? StubSession.shared
            : URLSession.shared

        let (data, response) = try await session.data(for: request)

        // handle result
    }

}




