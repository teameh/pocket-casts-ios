import Foundation
import MountebankSwift

let stubsForApiServer: [Stub] = [
    Stub(
        responses: [
            Is(
                statusCode: 200,
                headers: [
                    "content-length": "621",
                    "content-type": "application/octet-stream",
                    "vary": "origin"
                ],
                body: .data(Data(base64Encoded: "CqAEZXlKMGVYQWlPaUpLVjFRaUxDSmhiR2NpT2lKSVV6STFOaUo5LmV5SndZenAwYjJ0bGJsUjVjR1VpT2lKSlJDSXNJbkJqT25CeWIzWnBaR1Z5SWpvaVVFOURTMFZVWDBOQlUxUlRJaXdpY0dNNmRYVnBaQ0k2SWpjeU16VXdaVEEwTFRFM1pUVXRORFV4TUMxaU5tSTJMVGhsWTJaaU16SmlOV0l6WmlJc0ltVnRZV2xzSWpvaWRHbGxiV1YyWVc1MlpXVnVLM0J2WTJ0bGRHTmhjM1J6UUdkdFlXbHNMbU52YlNJc0ltVnRZV2xzWDNabGNtbG1hV1ZrSWpwbVlXeHpaU3dpYzJOdmNHVnpJanBiSW0xdlltbHNaU0pkTENKcWRHa2lPaUptWkRNMllUQXpNeTA1WWpOa0xUUXdOMk10WVRjd1lTMHlZVEV5WkROak4ySTVPVGNpTENKcFlYUWlPakUzTVRFM01qUTROVElzSW1WNGNDSTZNVGN5TnpJM05qZzFNaXdpYVhOeklqb2lhSFIwY0hNNkx5OWhjR2t1Y0c5amEyVjBZMkZ6ZEhNdVkyOXRJaXdpYzNWaUlqb2lOVGN4T0RjNU5qY3ROVEk0T1MwMFptWTJMV0k0WVRrdFpXVTRNbUZpTnpaak9UWTFJbjAuZWhjMl9UdTZGZUc1eDBZaW80cW5wbU5mV3d3R3RrWlB6Z2tOVV93UXhMaxIkNzIzNTBlMDQtMTdlNS00NTEwLWI2YjYtOGVjZmIzMmI1YjNmGiJ0aWVtZXZhbnZlZW4rcG9ja2V0Y2FzdHNAZ21haWwuY29t")!),
                parameters: ResponseParameters(behaviors: [.wait(miliseconds: 452)])
            ),
            Is(
                statusCode: 200,
                headers: [
                    "Connection": "close",
                    "content-type": "application/octet-stream",
                    "vary": "origin"
                ],
                body: .data(Data(base64Encoded: "CqAEZXlKMGVYQWlPaUpLVjFRaUxDSmhiR2NpT2lKSVV6STFOaUo5LmV5SndZenAwYjJ0bGJsUjVjR1VpT2lKSlJDSXNJbkJqT25CeWIzWnBaR1Z5SWpvaVVFOURTMFZVWDBOQlUxUlRJaXdpY0dNNmRYVnBaQ0k2SWpjeU16VXdaVEEwTFRFM1pUVXRORFV4TUMxaU5tSTJMVGhsWTJaaU16SmlOV0l6WmlJc0ltVnRZV2xzSWpvaWRHbGxiV1YyWVc1MlpXVnVLM0J2WTJ0bGRHTmhjM1J6UUdkdFlXbHNMbU52YlNJc0ltVnRZV2xzWDNabGNtbG1hV1ZrSWpwbVlXeHpaU3dpYzJOdmNHVnpJanBiSW0xdlltbHNaU0pkTENKcWRHa2lPaUptWkRNMllUQXpNeTA1WWpOa0xUUXdOMk10WVRjd1lTMHlZVEV5WkROak4ySTVPVGNpTENKcFlYUWlPakUzTVRFM01qUTROVElzSW1WNGNDSTZNVGN5TnpJM05qZzFNaXdpYVhOeklqb2lhSFIwY0hNNkx5OWhjR2t1Y0c5amEyVjBZMkZ6ZEhNdVkyOXRJaXdpYzNWaUlqb2lOVGN4T0RjNU5qY3ROVEk0T1MwMFptWTJMV0k0WVRrdFpXVTRNbUZpTnpaak9UWTFJbjAuZWhjMl9UdTZGZUc1eDBZaW80cW5wbU5mV3d3R3RrWlB6Z2tOVV93UXhMaxIkNzIzNTBlMDQtMTdlNS00NTEwLWI2YjYtOGVjZmIzMmI1YjNmGiJ0aWVtZXZhbnZlZW4rcG9ja2V0Y2FzdHNAZ21haWwuY29t")!),
                parameters: ResponseParameters(behaviors: [.wait(miliseconds: 406)])
            )
        ],
        predicates: [
            .deepEquals(Request(path: "/user/login")),
            .deepEquals(Request(method: .post))
        ]
    ),
    Stub(
        response: Is(
            statusCode: 500,
            headers: [
                "Content-Type": "application/json",
                "content-length": "43",
                "content-type": "application/json",
                "vary": "origin"
            ],
            body: .json([
                "errorMessage": .null,
                "errorMessageId": .null
            ]),
            parameters: ResponseParameters(behaviors: [.wait(miliseconds: 289)])
        ),
        predicates: [
            .deepEquals(Request(path: "/up_next/sync")),
            .deepEquals(Request(method: .post))
        ]
    ),
    Stub(
        response: Is(
            statusCode: 200,
            headers: [
                "content-length": "2",
                "content-type": "application/octet-stream",
                "vary": "origin"
            ],
            body: .data(Data(base64Encoded: "MgA=")!),
            parameters: ResponseParameters(behaviors: [.wait(miliseconds: 285)])
        ),
        predicates: [
            .deepEquals(Request(path: "/user/stats/summary")),
            .deepEquals(Request(method: .post))
        ]
    ),
    Stub(
        response: Is(
            statusCode: 200,
            headers: [
                "content-length": "33",
                "content-type": "application/octet-stream",
                "vary": "origin"
            ],
            body: .data(Data(base64Encoded: "ChgyMDI0LTAzLTI5VDE1OjA3OjMzLjg2M1oQ5/SB1ugx")!),
            parameters: ResponseParameters(behaviors: [.wait(miliseconds: 372)])
        ),
        predicates: [
            .deepEquals(Request(path: "/user/last_sync_at")),
            .deepEquals(Request(method: .post))
        ]
    ),
    Stub(
        response: Is(
            statusCode: 200,
            headers: [
                "content-length": "0",
                "content-type": "application/octet-stream",
                "vary": "origin"
            ],
            body: .data(Data(base64Encoded: "")!),
            parameters: ResponseParameters(behaviors: [.wait(miliseconds: 299)])
        ),
        predicates: [
            .deepEquals(Request(path: "/user/podcast/list")),
            .deepEquals(Request(method: .post))
        ]
    ),
    Stub(
        response: Is(
            statusCode: 200,
            headers: [
                "content-length": "0",
                "content-type": "application/octet-stream",
                "vary": "origin"
            ],
            body: .data(Data(base64Encoded: "")!),
            parameters: ResponseParameters(behaviors: [.wait(miliseconds: 323)])
        ),
        predicates: [
            .deepEquals(Request(path: "/user/playlist/list")),
            .deepEquals(Request(method: .post))
        ]
    ),
    Stub(
        response: Is(
            statusCode: 200,
            headers: [
                "content-length": "0",
                "content-type": "application/octet-stream",
                "vary": "origin"
            ],
            body: .data(Data(base64Encoded: "")!),
            parameters: ResponseParameters(behaviors: [.wait(miliseconds: 286)])
        ),
        predicates: [
            .deepEquals(Request(path: "/user/bookmark/list")),
            .deepEquals(Request(method: .post))
        ]
    ),
    Stub(
        response: Is(
            statusCode: 500,
            headers: [
                "Content-Type": "application/json",
                "content-length": "43",
                "content-type": "application/json",
                "vary": "origin"
            ],
            body: .json([
                "errorMessage": .null,
                "errorMessageId": .null
            ]),
            parameters: ResponseParameters(behaviors: [.wait(miliseconds: 377)])
        ),
        predicates: [
            .deepEquals(Request(path: "/history/sync")),
            .deepEquals(Request(method: .post))
        ]
    ),
    Stub(
        response: Is(
            statusCode: 200,
            headers: [
                "content-length": "714",
                "content-type": "application/octet-stream",
                "vary": "origin"
            ],
            body: .data(Data(base64Encoded: "CgQKABIAEhMKABICCAEaCwih3p+wBhCA8YwnGgYKAggBEgAiBAoAEgAqBgoCCC0SADIGCgIIChIAOgQKABIAQggKBAoCZW4SAEoGCgIIARIAWgQKABIAYg0KCQkAAAAAAADwPxIAcgQKABIAegQKABIAggEECgASAIoBBAoAEgCSAQYKAggBEgCaAQQKABIAogEMCggKBmdsb2JhbBIAqgEECgASALIBBAoAEgC6AQQKABIAwgEECgASAMoBBAoAEgDSAQQKABIA2gEECgASAOIBBAoAEgDqAQQKABIA8gEGCgIIARIA+gEECgASAIICBAoAEgCKAgQKABIAkgIECgASAJoCBgoCCAESAKICBgoCCAESAKoCBAoAEgCyAgQKABIAugIECgASAMICBAoAEgDKAgQKABIA0gIECgASANoCBgoCCAESAOICBAoAEgDqAgYKAghkEgDyAgYKAggBEgD6AgQKABIAggMECgASAIoDBAoAEgCSAwQKABIAmgMGCgIIARIAogMGCgIIARIAqgMECgASALIDBAoAEgC6AwYKAggBEgDCAwQKABIAygMECgASANIDBAoAEgDaAwQKABIA4gMGCgIIARIA6gMGCgIIAhIA8gMGCgIIARIA+gMGCgIIARIAggQGCgIIARIAigQECgASAJIEBgoCCAESAJoEBAoAEgCiBAQKABIAqgQECgASALIEBgoCCAESALoEBgoCCAESAMIEBAoAEgDKBAQKABIA0gQGCgIIARIA2gQECgASAOIEBAoAEgDqBAQKABIA8gQECgASAPoEBgoCCAESAIIFBgoCCAESAIoFBAoAEgCSBQYKAggBEgCaBQQKABIAogUECgASAKoFBAoAEgCyBQQKABIAugUECgASAMIFBAoAEgDKBQQKABIA0gUGCgIIARIA2gUECgASAOIFBAoAEgDqBQQKABIA")!),
            parameters: ResponseParameters(behaviors: [.wait(miliseconds: 318)])
        ),
        predicates: [
            .deepEquals(Request(path: "/user/named_settings/update")),
            .deepEquals(Request(method: .post))
        ]
    ),
    Stub(
        response: Is(
            statusCode: 200,
            headers: [
                "content-length": "53",
                "content-type": "application/octet-stream",
                "vary": "origin"
            ],
            body: .data(Data(base64Encoded: "SiAI19oyENjaMhgeKgoI19oyENjaMhgeMggIpM0yEKPNMlgBYP///////////wFyBFBsdXM=")!),
            parameters: ResponseParameters(behaviors: [.wait(miliseconds: 287)])
        ),
        predicates: [
            .deepEquals(Request(path: "/subscription/status")),
            .deepEquals(Request(method: .get))
        ]
    )
]
