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

@testable import GitHubTrends

class GitHubTrendsTests: XCTestCase {

//Given the app is not running
//When I start the app
//Then I see a list of trending repositories with project name, stars and description
//And I can filter then by name

    func test_whenIStartTheApp_thenIWillSeeAListOfTrendingRepositories() {
        let repositoriesVC = UIStoryboard.repositoriesViewController()

        let viewModel = RepositoriesViewModel()
        repositoriesVC.viewModel = viewModel

        let disposeBag = DisposeBag()
        let scheduler = TestScheduler(initialClock: 0)
        var itemsObserver: TestableObserver<[Repository]>!
        itemsObserver = scheduler.createObserver([Repository].self)
        repositoriesVC.viewModel.items.asObservable().bind(to: itemsObserver).disposed(by: disposeBag)

        scheduler.start()

        repositoriesVC.loadViewIfNeeded()

        XCTAssertEqual(itemsObserver.events.count, 1)
    }

}


