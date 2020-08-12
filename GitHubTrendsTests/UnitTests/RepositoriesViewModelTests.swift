//
//  RepositoriesViewModelTests.swift
//  GitHubTrendsTests
//
//  Created by Ana Nogal on 11/08/2020.
//  Copyright © 2020 ananogal. All rights reserved.
//

import XCTest
import RxSwift
import RxTest
@testable import GitHubTrends

class RepositoriesViewModelTests: XCTestCase {
    var viewModel: RepositoriesViewModel!
    var gateway: MockGateway!

    override func setUpWithError() throws {
        gateway = MockGateway()
        viewModel = RepositoriesViewModel(with: gateway)

    }

    override func tearDownWithError() throws {
        viewModel = nil
    }

    func test_whenLoadingData_itCallsGetway() {

        viewModel.loadData()

        XCTAssertTrue(gateway.loadRepositoriesWasCalled)
    }

    func test_whenLoadingData_onSuccess_generatesANewEvent() {
        let disposeBag = DisposeBag()
        let scheduler = TestScheduler(initialClock: 0)
        var itemsObserver: TestableObserver<[Repository]>!
        itemsObserver = scheduler.createObserver([Repository].self)
        viewModel.items.asObservable().bind(to: itemsObserver).disposed(by: disposeBag)

        viewModel.loadData()

        XCTAssertEqual(itemsObserver.events.count, 1)
    }
}


