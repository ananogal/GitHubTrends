//
//  RepositoriesViewControllerTests.swift
//  GitHubTrendsTests
//
//  Created by Ana Nogal on 11/08/2020.
//  Copyright © 2020 ananogal. All rights reserved.
//

import XCTest
import RxSwift

@testable import GitHubTrends

class RepositoriesViewControllerTests: XCTestCase {
    var reposViewController: RepositoriesViewController!
    var mockViewModel: MockRepositoriesViewModel!

    override func setUpWithError() throws {
        reposViewController = UIStoryboard.repositoriesViewController()
        mockViewModel = MockRepositoriesViewModel()
        reposViewController.viewModel = mockViewModel
    }

    override func tearDownWithError() throws {
        reposViewController = nil
    }

    func test_whenInitialized_setsTitleToGitHubTrends() {
        let title = "GitHub Trends"
        reposViewController.loadViewIfNeeded()

        XCTAssertEqual(reposViewController.title, title)
    }

    func test_whenInitialized_setsTitleTextColorToTintColor() {
        let textAttributesToCompare = [NSAttributedString.Key.foregroundColor: UIColor.tintColor]
        let _ = UINavigationController(rootViewController: reposViewController)

        reposViewController.loadViewIfNeeded()

        let navController = reposViewController.navigationController

        let navTextAttributes = navController!.navigationBar.titleTextAttributes as! [NSAttributedString.Key : UIColor]

        XCTAssertEqual(navTextAttributes, textAttributesToCompare)
    }

    func test_whenInitialized_setsSearchController() {
        let _ = UINavigationController(rootViewController: reposViewController)

        reposViewController.loadViewIfNeeded()

        XCTAssertNotNil(reposViewController.navigationItem.searchController)
    }
}


class MockRepositoriesViewModel: RepositoriesViewModelType {
    var items: PublishSubject<[Repository]> = PublishSubject<[Repository]>()
}
