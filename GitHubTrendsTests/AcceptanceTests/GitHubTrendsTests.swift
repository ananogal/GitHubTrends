//
//  GitHubTrendsTests.swift
//  GitHubTrendsTests
//
//  Created by Ana Nogal on 11/08/2020.
//  Copyright © 2020 ananogal. All rights reserved.
//

import XCTest
import RxSwift
import RxCocoa
import RxTest
import RxBlocking

@testable import GitHubTrends

class GitHubTrendsTests: XCTestCase {

    override func setUpWithError() throws {
         continueAfterFailure = false
    }

    //Given the app is not running
    //When I start the app
    //Then I see a list of trending repositories with project name, stars and description
    func test_whenIStartTheApp_thenIWillSeeAListOfTrendingRepositories() throws {
        let repositoriesVC = UIStoryboard.repositoriesViewController()

        let gateway = Gateway()
        let viewModel = RepositoriesViewModel(with: gateway)
        repositoriesVC.viewModel = viewModel

        let disposeBag = DisposeBag()
        let scheduler = TestScheduler(initialClock: 0)
        var itemsObserver: TestableObserver<[Repository]>!
        itemsObserver = scheduler.createObserver([Repository].self)
        viewModel.items.asObservable().bind(to: itemsObserver).disposed(by: disposeBag)
        scheduler.start()

        repositoriesVC.loadViewIfNeeded()

        XCTAssertNotNil(try viewModel.items.toBlocking().first())

        let cell = repositoriesVC.tableView.cellForRow(at: IndexPath(row: 0, section: 0)) as! RepositoryCell
        XCTAssertTrue(!cell.descriptionLabel.text!.isEmpty)
        XCTAssertTrue(!cell.nameLabel.text!.isEmpty)
        XCTAssertTrue(!cell.starsLabel.text!.isEmpty)
    }
}
