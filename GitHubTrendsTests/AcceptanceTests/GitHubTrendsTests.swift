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
        let repoOne = Repository(name: "Name 1", description: "Description 1", stars: 1, avatar: "", author: "author", forks: 1, url: "")
        let repoTwo = Repository(name: "Name 2", description: "Description 2", stars: 2, avatar: "", author: "author", forks: 1, url: "")
        mockGateway.repos = [repoOne, repoTwo]

        let textToSearch = "1"
        repositoriesVC.navigationItem.searchController?.searchBar.text = textToSearch

        XCTAssertEqual(repositoriesVC.tableView.numberOfRows(inSection: 0), numberOfSearchedItems)
    }

    //Given I can see the list of trending repositories
    //When I select one
    //I want to see the details of that repository including: the author avatar and name;
    //the repository description, stars and forks; the repository readme.
    func test_whenSelectingOneRepository_iCanSeeTheDetailsOfThatRepo() throws {
        let navigationController = createRepositoriesControllerWithNavigation(gateway: Gateway())
        startScheduler()
        repositoriesVC.loadViewIfNeeded()

        try receiveEvent()

        let item = Repository(name: "Name", description: "Description", stars: 1, avatar: "", author: "author", forks: 1, url: "")
        repositoriesVC.showDetails(item)

        XCTAssertNotNil(navigationController.pushedViewController as? DetailsViewController)

        let detailsVC = navigationController.pushedViewController as! DetailsViewController
        detailsVC.loadViewIfNeeded()

        XCTAssertNotNil(detailsVC.avatarImageView.image)
        XCTAssertFalse(detailsVC.nameLabel.text!.isEmpty)
        XCTAssertFalse(detailsVC.descriptionLabel.text!.isEmpty)
        XCTAssertNotNil(detailsVC.starsButton.title(for: .normal))
        XCTAssertFalse(detailsVC.starsButton.title(for: .normal)!.isEmpty)
        XCTAssertNotNil(detailsVC.forksButton.title(for: .normal))
    }

    //MARK - Test helpers

    private func createRepositoriesControllerWithNavigation(gateway: GatewayType) -> MockNavigationController {
        createRepositoriesController(gateway: gateway)
        return MockNavigationController(rootViewController: repositoriesVC)
    }

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

    private func receiveEvent() throws {
        let _ = try viewModel.items.toBlocking().first()
    }
}

