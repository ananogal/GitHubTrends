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
    var repositoriesVC: RepositoriesViewController!
    var viewModel: RepositoriesViewModel!

    var itemsObserver: TestableObserver<[Repository]>!
    var scheduler: TestScheduler!
    var disposeBag: DisposeBag!

    override func setUpWithError() throws {
        continueAfterFailure = false
    }

    //Given the app is not running
    //When I start the app
    //Then I see a list of trending repositories with project name, stars and description
    func test_whenIStartTheApp_thenIWillSeeAListOfTrendingRepositories() throws {
        createRepositoriesController(gateway: Gateway())
        startScheduler()
        repositoriesVC.loadViewIfNeeded()

        XCTAssertNotNil(try viewModel.items.toBlocking().first())

        let cell = repositoriesVC.tableView.cellForRow(at: IndexPath(row: 0, section: 0)) as! RepositoryCell
        XCTAssertTrue(!cell.descriptionLabel.text!.isEmpty)
        XCTAssertTrue(!cell.nameLabel.text!.isEmpty)
        XCTAssertTrue(!cell.starsLabel.text!.isEmpty)
    }

    //Given I can see the list of trending repositories
    //When I enter a text in the search bar
    //Then I will see the repositories filtered by the entered text
    func test_whenSearchingForARepository_IWillSeeTheRepositoriesFiltered() {
        let mockGateway = MockGateway()
        createRepositoriesController(gateway: mockGateway)
        startScheduler()

        let _ = UINavigationController(rootViewController: repositoriesVC)
        repositoriesVC.loadViewIfNeeded()

        let numberOfSearchedItems = 1
        let repoOne = Repository(name: "Name 1", description: "Description 1", stars: 1)
        let repoTwo = Repository(name: "Name 2", description: "Description 2", stars: 2)
        mockGateway.repos = [repoOne, repoTwo]

        let textToSearch = "1"
        repositoriesVC.navigationItem.searchController?.searchBar.text = textToSearch

        XCTAssertEqual(repositoriesVC.tableView.numberOfRows(inSection: 0), numberOfSearchedItems)
    }

    //MARK - Test helpers

    private func createRepositoriesController(gateway: GatewayType) {
        repositoriesVC = UIStoryboard.repositoriesViewController()
        viewModel = RepositoriesViewModel(with: gateway)
        repositoriesVC.viewModel = viewModel
    }

    private func startScheduler() {
        scheduler = TestScheduler(initialClock: 0)
        disposeBag = DisposeBag()
        itemsObserver = scheduler.createObserver([Repository].self)
        viewModel.items.asObservable().bind(to: itemsObserver).disposed(by: disposeBag)
        scheduler.start()
    }
}

