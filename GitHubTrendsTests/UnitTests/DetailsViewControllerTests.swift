//
//  DetailsViewControllerTests.swift
//  GitHubTrendsTests
//
//  Created by Ana Nogal on 12/08/2020.
//  Copyright © 2020 ananogal. All rights reserved.
//

import XCTest
import RxSwift
import RxTest

@testable import GitHubTrends

class DetailsViewControllerTests: XCTestCase {
    var detailsVC: DetailsViewController!
    var viewModel: DetailsViewModelType!
    var item: Repository!

    override func setUpWithError() throws {
        detailsVC = UIStoryboard.detailsViewController()
        item = Repository(name: "name", description: "description", stars: 1, avatar: "", author: "author")
        viewModel = DetailsViewModel(item: item)
        detailsVC.viewModel = viewModel
    }

    func test_whenInitialize_setsTheTitleOfTheNavigationBatToTheNameOfTheProject() {


        detailsVC.loadViewIfNeeded()

        XCTAssertEqual(detailsVC.title, item.name)
    }

    func test_whenloading_setsTheBackButtonTextToBack() {
        let _ = UINavigationController(rootViewController: detailsVC)
        detailsVC.loadViewIfNeeded()

        XCTAssertEqual(detailsVC.navigationController?.navigationBar.topItem?.backBarButtonItem?.title, "Back")
    }

    func test_whenLoading_setsBackButtonColorToTintColor() {
        let _ = UINavigationController(rootViewController: detailsVC)
        detailsVC.loadViewIfNeeded()

        XCTAssertEqual(detailsVC.navigationController?.navigationBar.topItem?.backBarButtonItem?.tintColor, UIColor.tintColor)
    }

    func test_whenLoading_setsBorderStyleToStarForksContainer() {
        detailsVC.loadViewIfNeeded()

        XCTAssertEqual(detailsVC.starForksContainer.layer.borderWidth, 0.5)
        XCTAssertEqual(detailsVC.starForksContainer.layer.borderColor, UIColor.lightGray.cgColor)
        XCTAssertEqual(detailsVC.starForksContainer.layer.cornerRadius, 10)
    }

    func test_whenLoadingImage_setsTheAvatarImageToPlaceHolderForInvalidUrl() {
        detailsVC.loadViewIfNeeded()

        let image = UIImage(systemName: "person.fill")
        image?.withTintColor(.lightGray)

        XCTAssertEqual(detailsVC.avatarImageView.image, image)
    }

    func test_whenLoadingImage_setsTheAvatarImageUrl() {
        let item = Repository(name: "name", description: "description", stars: 1, avatar: "https://github.com/ananogal.png", author: "author")
        viewModel = DetailsViewModel(item: item)
        detailsVC.viewModel = viewModel
        detailsVC.loadViewIfNeeded()

        XCTAssertNotNil(detailsVC.avatarImageView.image)
    }

    func test_whenLoading_setsTheUserNameToAuthor() {
        detailsVC.loadViewIfNeeded()

        XCTAssertEqual(detailsVC.nameLabel.text, item.author)
    }

    func test_whenLoading_setsTheDescription() {
        detailsVC.loadViewIfNeeded()

        XCTAssertEqual(detailsVC.descriptionLabel.text, item.description)
    }

    func test_whenLoading_setsTitleOfStarsButoonToNumberOfStars() {
        detailsVC.loadViewIfNeeded()

        XCTAssertEqual(detailsVC.starsButton.title(for: .normal), "\(item.stars) Stars")
    }
}
