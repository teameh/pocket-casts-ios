import Foundation
import MountebankSwift

let stubsForCacheServer: [Stub] = [
    Stub(
        response: Is(
            statusCode: 302,
            headers: [
                "Connection": "keep-alive",
                "Content-Length": "0",
                "Date": "Sat, 30 Mar 2024 10:52:55 GMT",
                "Location": "https://podcasts.pocketcasts.com/852a66f0-bdf4-013c-5160-0acc26574db2/episodes_full_1711513027.json",
                "vary": "origin"
            ],
            body: .text(""),
            parameters: ResponseParameters(behaviors: [.wait(miliseconds: 335)])
        ),
        predicates: [
            .deepEquals(Request(method: .get)),
            .deepEquals(Request(path: "/mobile/podcast/full/852a66f0-bdf4-013c-5160-0acc26574db2"))
        ]
    ),
    Stub(
        response: Is(
            statusCode: 200,
            headers: [
                "Cache-Control": "max-age=86400",
                "Connection": "keep-alive",
                "Content-Length": "27",
                "Content-Type": "application/json",
                "Date": "Sat, 30 Mar 2024 10:52:55 GMT",
                "vary": "origin"
            ],
            body: .json([
                "average": 4.08,
                "total": 13.0
            ]),
            parameters: ResponseParameters(behaviors: [.wait(miliseconds: 411)])
        ),
        predicates: [
            .deepEquals(Request(method: .get)),
            .deepEquals(Request(path: "/podcast/rating/852a66f0-bdf4-013c-5160-0acc26574db2"))
        ]
    )
]
