//
//  ListResponse.swift
//  FetchList
//
//  Created by Dane Thomas on 11/6/20.
//

import Foundation

/**
 [
 {"id": 755, "listId": 2, "name": ""},
 {"id": 203, "listId": 2, "name": ""},
 {"id": 684, "listId": 1, "name": "Item 684"},
 {"id": 276, "listId": 1, "name": "Item 276"},
 {"id": 736, "listId": 3, "name": null}
 ]
 */

typealias ListResponse = [ListResponseItem]

struct ListResponseItem: Codable, Equatable {
    let id: Int
    let listId: Int
    let name: String?
}
