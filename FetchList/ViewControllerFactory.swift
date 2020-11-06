//
//  ViewControllerFactory.swift
//  FetchList
//
//  Created by Dane Thomas on 11/5/20.
//

import UIKit

struct ViewControllerFactory {
    private static let storyboard = UIStoryboard(name: "Main", bundle: nil)
    static func makeMainNav() -> MainNavigationController {
        let mainNav = storyboard.instantiateViewController(withIdentifier: "MainNavigation") as! MainNavigationController
        return mainNav
    }
    
    static func makeViewController() -> ViewController {
        let vc = storyboard.instantiateViewController(identifier: "ViewController") { (coder) -> ViewController? in
            let presenter = ListPresenter(listService: ListService(session: .shared))
            return ViewController(coder: coder, presenter: presenter)
        }
        return vc
    }
}
