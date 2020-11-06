//
//  ListPresenter.swift
//  FetchList
//
//  Created by Dane Thomas on 11/6/20.
//

import Foundation

protocol ListPresentable {
    func getList(completion: @escaping (Result<[ListSection], Error>) -> Void)
}

final class ListPresenter: ListPresentable {
    let listService: ListServiceable
    
    init(listService: ListServiceable) {
        self.listService = listService
    }
    
    /**
     Retrieves the list items asynchronously and arranges them into a collection of `ListSection`
     - parameters:
        - completion: An escaping closure for handling the `Result` containing the collection of `ListSection`
     */
    
    func getList(completion: @escaping (Result<[ListSection], Error>) -> Void) {
        self.listService.fetchList { (result) in
            let sectionResult: Result<[ListSection], Error>
            switch result {
            case .success(let response):
                let sections = self.createSections(from: response)
                sectionResult = .success(sections)
            case .failure(let error):
                sectionResult = .failure(error)
            }
            
            DispatchQueue.main.async {
                completion(sectionResult)
            }
        }
    }
    
    private func createSections(from list: ListResponse) -> [ListSection] {
        var sectionDict: [Int: [ListResponseItem]] = [:]
        for item in list {
            let name = item.name ?? ""
            guard !name.isEmpty else { continue }
            
            if var sectionItems = sectionDict[item.listId] {
                sectionItems.append(item)
                sectionDict[item.listId] = sectionItems
            } else {
                sectionDict[item.listId] = [item]
            }
        }
        
        var sections: [ListSection] = []
        for (name, items) in sectionDict {
            let section = ListSection(title: "\(name)",
                                      items: items.sorted(by: { $0.name ?? "" < $1.name ?? "" }))
            sections.append(section)
        }
        
        return sections.sorted(by: { $0.title < $1.title })
    }
}
