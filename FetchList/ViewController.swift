//
//  ViewController.swift
//  FetchList
//
//  Created by Dane Thomas on 11/5/20.
//

import UIKit

class ViewController: UIViewController {
    let presenter: ListPresentable
    var listSections: [ListSection] = []

    @IBOutlet weak var tableView: UITableView!
    
    init?(coder: NSCoder, presenter: ListPresentable) {
        self.presenter = presenter
        super.init(coder: coder)
    }
    
    required init?(coder: NSCoder) {
        fatalError("Please use init(coder:presenter:) to instantiate")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.dataSource = self
        self.presenter.getList { result in
            switch result {
            case .success(let list):
                self.setList(list)
            case .failure(_):
                // handle error
                break
            }
        }

    }
    
    func setList(_ list: [ListSection]) {
        self.listSections = list
        self.tableView.reloadData()
    }

}

extension ViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return self.listSections.count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return self.listSections.getItem(at: section)?.title
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        return self.listSections.getItem(at: section)?.items.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ListCell", for: indexPath) as! ListTableViewCell

        guard let section = self.listSections.getItem(at: indexPath.section),
              let item = section.items.getItem(at: indexPath.row) else {
            return cell
        }
        cell.titleLabel.text = item.name
        cell.detailLabel.text = "\(item.id)"
        
        return cell
    }
    
    
}

