//
//  Array+NullableIndex.swift
//  FetchList
//
//  Created by Dane Thomas on 11/6/20.
//

import Foundation

extension Array {
    func getItem(at index: Int) -> Element? {
        guard index >= 0 && index < self.count else { return nil }
        return self[index]
    }
}
