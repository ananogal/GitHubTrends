//
//  DetailsViewController.swift
//  GitHubTrends
//
//  Created by Ana Nogal on 12/08/2020.
//  Copyright © 2020 ananogal. All rights reserved.
//

import UIKit
import MarkdownView
import AlamofireImage

class DetailsViewController: UIViewController {
    @IBOutlet var avatarImageView: UIImageView!
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var descriptionLabel: UILabel!
    @IBOutlet var starForksContainer: UIView!
    @IBOutlet var readMeView: MarkdownView!
    @IBOutlet var starsButton: UIButton!
    @IBOutlet var forksButton: UIButton!

    var viewModel: DetailsViewModelType!

    override func viewDidLoad() {
        super.viewDidLoad()
        setUpUI()
    }

    private func setUpUI() {
        setUpNavigationBar()
        setContainerBorder()
        loadAvatarWithStyle()
    }

    private func setUpNavigationBar() {
        title = viewModel.title
        let backButton = UIBarButtonItem()
        backButton.title = "Back"
        backButton.tintColor = UIColor.tintColor
        navigationController?.navigationBar.topItem?.backBarButtonItem = backButton
    }

    private func setContainerBorder() {
        starForksContainer.layer.borderColor = UIColor.lightGray.cgColor
        starForksContainer.layer.borderWidth = 0.5
        starForksContainer.layer.cornerRadius = 10
    }

    private func loadAvatarWithStyle() {
        loadAvatarImage()
        avatarImageView.circleImageWithBorder(color: .lightGray, width: 0.5)
    }

    private func loadAvatarImage() {
        let placeholderImage = UIImage(systemName: "person.fill")
        placeholderImage?.withTintColor(.lightGray)

        guard let url = viewModel.avatarURL  else {
            avatarImageView.image = placeholderImage
            return
        }

        let transition = UIImageView.ImageTransition.crossDissolve(0.3)
        avatarImageView.af.setImage(withURL: url, placeholderImage: placeholderImage, imageTransition: transition)
    }
}
