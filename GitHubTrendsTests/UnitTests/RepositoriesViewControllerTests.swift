//
//  RepositoriesViewControllerTests.swift
//  GitHubTrendsTests
//
//  Created by Ana Nogal on 11/08/2020.
//  Copyright © 2020 ananogal. All rights reserved.
//

import XCTest
import RxSwift
import RxTest

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
        mockViewModel = nil
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

    func test_whenSearchForAText_itSearchesForTheItems() {
        let _ = UINavigationController(rootViewController: reposViewController)
        reposViewController.loadViewIfNeeded()

        reposViewController.navigationItem.searchController?.searchBar.text = ""

        XCTAssertTrue(mockViewModel.searchRepositoriesWasCalled)
    }

    func test_whenSearchForAText_itSetsTableViewWithResults() {
        let _ = UINavigationController(rootViewController: reposViewController)
        reposViewController.loadViewIfNeeded()
        let allItemsCount = mockViewModel.repos.count

        reposViewController.navigationItem.searchController?.searchBar.text = "1"
        let filteredItemsCount = mockViewModel.repos.count

        XCTAssertTrue(allItemsCount > filteredItemsCount)
        XCTAssertEqual(reposViewController.tableView.numberOfRows(inSection: 0), filteredItemsCount)
    }

    func test_whenSearchingAndCancelButtonIsTapped_IWantToSeeAllItems() {
        let _ = UINavigationController(rootViewController: reposViewController)
        reposViewController.loadViewIfNeeded()
        let allItemsCount = mockViewModel.repos.count

        reposViewController.navigationItem.searchController?.searchBar.text = "1"

        reposViewController.resetSearch()

        XCTAssertEqual(reposViewController.tableView.numberOfRows(inSection: 0), allItemsCount)
    }

    func test_whenSelectingRepository_itPushesDetailsViewControllerToNavigationController() throws {
        let mockNavigationViewController = MockNavigationController(rootViewController: reposViewController)
        reposViewController.loadViewIfNeeded()

        let item = Repository(name: "Name", description: "Description", stars: 1, avatar: "", author: "author", forks: 1)
        reposViewController.showDetails(item)

        XCTAssertNotNil(mockNavigationViewController.pushedViewController as? DetailsViewController)
    }
}

