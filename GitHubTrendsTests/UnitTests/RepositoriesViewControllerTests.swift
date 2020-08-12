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

    func test_whenloadingIsDone_setsTitleToGitHubTrends() {
        let title = "GitHub Trends"
        reposViewController.loadViewIfNeeded()

        XCTAssertEqual(reposViewController.title, title)
    }

    func ttest_whenloadingIsDone_setsTitleTextColorToTintColor() {
        let textAttributesToCompare = [NSAttributedString.Key.foregroundColor: UIColor.tintColor]
        let _ = UINavigationController(rootViewController: reposViewController)

        reposViewController.loadViewIfNeeded()

        let navController = reposViewController.navigationController

        let navTextAttributes = navController!.navigationBar.titleTextAttributes as! [NSAttributedString.Key : UIColor]

        XCTAssertEqual(navTextAttributes, textAttributesToCompare)
    }

    func test_whenloadingIsDone_setsSearchController() {
        let _ = UINavigationController(rootViewController: reposViewController)

        reposViewController.loadViewIfNeeded()

        XCTAssertNotNil(reposViewController.navigationItem.searchController)
    }

    func test_whenloadingIsDone_hasATableView() {
        reposViewController.loadViewIfNeeded()

        XCTAssertNotNil(reposViewController.tableView)
    }

    func test_whenloadingIsDone_hasACellRegisterInTheTableView() {
        reposViewController.loadViewIfNeeded()

        XCTAssertNotNil(reposViewController.tableView.dequeueReusableCell(withIdentifier: "RepositoryCell"))
    }

    func test_whenloadingIsDone_loadsData() {
        reposViewController.loadViewIfNeeded()

        XCTAssertTrue(mockViewModel.loadDataWasCalled)
    }

    func test_whenlodingIsDone_itSetsTableViewData() {
        reposViewController.loadViewIfNeeded()

        XCTAssertTrue(reposViewController.tableView.numberOfRows(inSection: 0) == mockViewModel.repos.count)
    }
}


class MockRepositoriesViewModel: RepositoriesViewModelType {
    var items: PublishSubject<[Repository]> = PublishSubject<[Repository]>()
    var loadDataWasCalled = false
    var repos = [Repository]()

    func loadData() {
        loadDataWasCalled = true

        let repoOne = Repository(name: "Name 1", description: "Description 1", stars: 1)
        let repoTwo = Repository(name: "Name 2", description: "Description 2", stars: 2)
        repos = [repoOne, repoTwo]

        items.onNext(repos)
    }
}
