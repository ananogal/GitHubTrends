//
//  DetailsViewController.swift
//  GitHubTrends
//
//  Created by Ana Nogal on 12/08/2020.
//  Copyright © 2020 ananogal. All rights reserved.
//

import UIKit
import MarkdownView

class DetailsViewController: UIViewController {
    @IBOutlet var avatarImageView: UIImageView!
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var descriptionLabel: UILabel!
    @IBOutlet var starForksContainer: UIView!
    @IBOutlet var readMeView: MarkdownView!
    @IBOutlet var starsButton: UIButton!
    @IBOutlet var forksButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
    }

}
