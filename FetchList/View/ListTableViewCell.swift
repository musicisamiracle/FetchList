//
//  ListTableViewCell.swift
//  FetchList
//
//  Created by Dane Thomas on 11/6/20.
//

import UIKit

class ListTableViewCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var detailLabel: UILabel!
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.titleLabel.text = ""
        self.detailLabel.text = ""
    }
}
