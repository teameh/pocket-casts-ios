import Foundation
import MountebankSwift

let stubsForRefreshServer: [Stub] = [Stub(
    responses: [
        Is(
            statusCode: 200,
            headers: [
                "Cache-Control": "max-age=0, private, must-revalidate",
                "Connection": "keep-alive",
                "Content-Length": "120",
                "Content-Type": "application/json; charset=utf-8",
                "Date": "Sat, 30 Mar 2024 10:49:11 GMT",
                "ETag": "W/\"1981b401083c4fdd383a959504f774d8\"",
                "Referrer-Policy": "strict-origin-when-cross-origin",
                "Server": "nginx/1.18.0",
                "Set-Cookie": "_podcast_central_session=NWp2RnRhKzF4ZkpDd29PTXRvL0ZIS3ZVU3JITmphT2ZaYWFSNzhLTzRSMFpFVTh3bEpRSVdUcHJ4R1ZsaTBTay8vNy96TmxoZ2hhRWczSjl5dkJBZ3hyVDEzUlgxdSs3bFBxMlJjb1ZTbnM9LS1wZnpYSGpHSGhtcnkzY3hYLytnUHVnPT0%3D--d63c6901551f9169bd3131a0eb0e5bdeeead18a2; path=/; HttpOnly",
                "X-Content-Type-Options": "nosniff",
                "X-Download-Options": "noopen",
                "X-Frame-Options": "SAMEORIGIN",
                "X-Permitted-Cross-Domain-Policies": "none",
                "X-Request-Id": "94151e01-f0fa-4032-9e58-40ddb49aeeb0",
                "X-Runtime": "0.006624",
                "X-XSS-Protection": "1; mode=block",
                "vary": "Origin"
            ],
            body: .json([
                "message": .null,
                "result": [
                    "news": [
                        "app_version_code": "51",
                        "app_version_name": "3.9"
                    ],
                    "podcast_updates": [:]
                ],
                "status": "ok"
            ]),
            parameters: ResponseParameters(behaviors: [.wait(miliseconds: 418)])
        ),
        Is(
            statusCode: 200,
            headers: [
                "Cache-Control": "max-age=0, private, must-revalidate",
                "Connection": "keep-alive",
                "Content-Type": "application/json; charset=utf-8",
                "Date": "Sat, 30 Mar 2024 10:53:18 GMT",
                "ETag": "W/\"1981b401083c4fdd383a959504f774d8\"",
                "Referrer-Policy": "strict-origin-when-cross-origin",
                "Server": "nginx/1.18.0",
                "Set-Cookie": "_podcast_central_session=QWZOVTRzdExoWXVTYmphZGNPMDRIUXNJbkhOcWJzWnBVQUdHaWxmdHFVMDUza0VvNkJoYXAyTzRpSEFhVHl3SWVvNFhBMlpnNlUyZjBVaW5pTWRQVXdhTm9PamU3M3dHYXBwelNJWEd3WkE9LS1sSHpRQjlBY2tvd1ZLQnRoeUFSKzZBPT0%3D--702ef5223783ccefc1442748531880cdef86110d; path=/; HttpOnly",
                "X-Content-Type-Options": "nosniff",
                "X-Download-Options": "noopen",
                "X-Frame-Options": "SAMEORIGIN",
                "X-Permitted-Cross-Domain-Policies": "none",
                "X-Request-Id": "dbee8297-c2a2-4461-8bc9-a4c52daf5ae4",
                "X-Runtime": "0.004113",
                "X-XSS-Protection": "1; mode=block",
                "vary": "Origin"
            ],
            body: .json([
                "message": .null,
                "result": [
                    "news": [
                        "app_version_code": "51",
                        "app_version_name": "3.9"
                    ],
                    "podcast_updates": [:]
                ],
                "status": "ok"
            ]),
            parameters: ResponseParameters(behaviors: [.wait(miliseconds: 512)])
        )
    ],
    predicates: [
        .deepEquals(Request(method: .post)),
        .deepEquals(Request(path: "/user/update"))
    ]
)]
