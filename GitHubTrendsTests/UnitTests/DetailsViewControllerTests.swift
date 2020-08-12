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
    var viewModel: DetailsViewModel!

    override func setUpWithError() throws {
        detailsVC = UIStoryboard.detailsViewController()
        let item = Repository(name: "name", description: "description", stars: 1)
        viewModel = DetailsViewModel(item: item)
        detailsVC.viewModel = viewModel
    }

    func test_whenInitialize_setsTheTitleOfTheNavigationBatToTheNameOfTheProject() {


        detailsVC.loadViewIfNeeded()

        XCTAssertEqual(detailsVC.title, viewModel.title)
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
}

class MockDetailsViewModel: DetailsViewModelType {
    private let item: Repository

    init(item:Repository) {
        self.item = item
    }

    var title: String {
        return item.name
    }
}
