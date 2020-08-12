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
    var viewModel: MockDetailsViewModel!
    var item: Repository!
    var gateway: MockGateway!

    override func setUpWithError() throws {
        detailsVC = UIStoryboard.detailsViewController()
        gateway = MockGateway()
        item = Repository(name: "name", description: "description", stars: 1, avatar: "", author: "author", forks: 1, url: "")
        viewModel = MockDetailsViewModel(item: item, gateway: gateway)
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
        let item = Repository(name: "name", description: "description", stars: 1, avatar: "https://github.com/ananogal.png", author: "author", forks: 1, url: "")
        viewModel = MockDetailsViewModel(item: item, gateway: MockGateway())
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

    func test_whenLoading_setsTitleOfForksButoonToNumberOfStars() {
        detailsVC.loadViewIfNeeded()

        XCTAssertEqual(detailsVC.forksButton.title(for: .normal), "\(item.forks) Forks")
    }

    func test_whenLoading_loadsReameFile() {
        detailsVC.loadViewIfNeeded()

        XCTAssertTrue(viewModel.loadReadMeWasCalled)
    }
}

class MockDetailsViewModel: DetailsViewModelType {
    var item: Repository

    var itemPublisher = PublishSubject<Repository>()
    var readMePublisher = PublishSubject<String>()
    var gateway: MockGateway
    var avatarURL: URL? {
        return URL(string: "https://github.com/ananogal.png")
    }

    var loadReadMeWasCalled = false

    init(item: Repository, gateway: MockGateway) {
        self.item = item
        self.gateway = gateway
    }

    func loadData() {
        itemPublisher.onNext(item)
    }

    func loadReadMe() {
        loadReadMeWasCalled = true
    }
}
