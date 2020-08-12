//
//  RepositoryCell.swift
//  GitHubTrends
//
//  Created by Ana Nogal on 11/08/2020.
//  Copyright © 2020 ananogal. All rights reserved.
//

import UIKit

class RepositoryCell: UITableViewCell {

    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var starsLabel: UILabel!
    @IBOutlet var descriptionLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = .none
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

    func configure(item: Repository) {
        nameLabel.text = item.name
        starsLabel.text = "\(item.stars) Stars"
        descriptionLabel.text = item.description
    }
}
