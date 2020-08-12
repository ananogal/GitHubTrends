//
//  DetailsViewModelTests.swift
//  GitHubTrendsTests
//
//  Created by Ana Nogal on 13/08/2020.
//  Copyright © 2020 ananogal. All rights reserved.
//

import XCTest
import RxSwift
import RxTest
@testable import GitHubTrends

class DetailsViewModelTests: XCTestCase {
    var viewModel: DetailsViewModel!
    var gateway: MockGateway!

    override func setUpWithError() throws {
        gateway = MockGateway()
        let item = Repository(name: "name", description: "description", stars: 1, avatar: "https://github.com/ananogal.png", author: "author", forks: 1, url: "")
        viewModel = DetailsViewModel(item: item, gateway: gateway)

    }

    override func tearDownWithError() throws {
        viewModel = nil
        gateway = nil
    }

    func test_whenLoadingReadMe_itCallsGeteway() {

        viewModel.loadReadMe()

        XCTAssertTrue(gateway.loadReadMeWasCalled)
    }

    func test_whenLoadingReadMeFile_onSuccess_generatesANewEvent() {
        let disposeBag = DisposeBag()
        let scheduler = TestScheduler(initialClock: 0)
        var readMeObserver: TestableObserver<String>!
        readMeObserver = scheduler.createObserver(String.self)
        viewModel.readMePublisher.asObservable().bind(to: readMeObserver).disposed(by: disposeBag)

        viewModel.loadReadMe()

        XCTAssertEqual(readMeObserver.events.count, 2)
    }
}
