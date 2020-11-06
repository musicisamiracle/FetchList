//
//  FetchListTests.swift
//  FetchListTests
//
//  Created by Dane Thomas on 11/5/20.
//

import XCTest
@testable import FetchList

class FetchListTests: XCTestCase {

    var presenter: ListPresenter!

    override func setUpWithError() throws {
        self.presenter = ListPresenter(listService: MockListService())
    }

    override func tearDownWithError() throws {
        self.presenter = nil
    }
    
    func testFetchList() {
        // Arrange
        let expectation = XCTestExpectation(description: "fetching list items")
        let expectedFirstSection = [
            ListResponseItem(id: 29, listId: 1, name: "Item 29"),
            ListResponseItem(id: 3, listId: 1, name: "Item 3"),
            ListResponseItem(id: 8, listId: 1, name: "Item 8")
        ]
        
        let expectedSecondSection = [
            ListResponseItem(id: 1, listId: 2, name: "Item 1")
        ]
        
        let expectedThirdSection = [
            ListResponseItem(id: 2, listId: 3, name: "Item 2"),
            ListResponseItem(id: 6, listId: 3, name: "Item 6"),
            ListResponseItem(id: 7, listId: 3, name: "Item 7")
        ]
        
        // Act
        self.presenter.getList { (result) in
            switch result {
            case .success(let sections):
                
                // Assert
                XCTAssertEqual(sections.count, 3)
                let first = sections[0]
                let second = sections[1]
                let third = sections[2]
                
                XCTAssertEqual(first.items, expectedFirstSection)
                XCTAssertEqual(second.items, expectedSecondSection)
                XCTAssertEqual(third.items, expectedThirdSection)

            case .failure(_):
                XCTFail("Mock should not return an error")
            }
            expectation.fulfill()
        }
        
        
        self.wait(for: [expectation], timeout: 5)
    }

}
