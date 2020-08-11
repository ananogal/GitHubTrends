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
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        reposViewController = (storyboard.instantiateViewController(identifier: "RepositoriesViewController") as! RepositoriesViewController)
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




}


class MockRepositoriesViewModel: RepositoriesViewModelType {
    var items: PublishSubject<[Repository]> = PublishSubject<[Repository]>()
}
