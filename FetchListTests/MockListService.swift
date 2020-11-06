//
//  MockListService.swift
//  FetchListTests
//
//  Created by Dane Thomas on 11/6/20.
//

import Foundation
@testable import FetchList

struct MockListService: ListServiceable {
    let mockResponse: ListResponse = [
        ListResponseItem(id: 6, listId: 3, name: "Item 6"),
        ListResponseItem(id: 1, listId: 2, name: "Item 1"),
        ListResponseItem(id: 3, listId: 1, name: "Item 3"),
        ListResponseItem(id: 4, listId: 1, name: ""),
        ListResponseItem(id: 2, listId: 3, name: "Item 2"),
        ListResponseItem(id: 5, listId: 2, name: nil),
        ListResponseItem(id: 8, listId: 1, name: "Item 8"),
        ListResponseItem(id: 7, listId: 3, name: "Item 7"),
        ListResponseItem(id: 29, listId: 1, name: "Item 29")
    ]

    func fetchList(completion: @escaping (Result<ListResponse, Error>) -> Void) {
        completion(.success(self.mockResponse))
    }
}
