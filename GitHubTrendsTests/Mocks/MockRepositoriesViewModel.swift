//
//  MockRepositoriesViewModel.swift
//  GitHubTrendsTests
//
//  Created by Ana Nogal on 12/08/2020.
//  Copyright © 2020 ananogal. All rights reserved.
//

import RxSwift
@testable import GitHubTrends

class MockRepositoriesViewModel: RepositoriesViewModelType {
    var items: PublishSubject<[Repository]> = PublishSubject<[Repository]>()
    var loadDataWasCalled = false
    var searchRepositoriesWasCalled = false
    var repos = [Repository]()

    func loadData() {
        loadDataWasCalled = true
        createReposData()
        items.onNext(repos)
    }

    func searchRepositories(textToSearch: String) {
        searchRepositoriesWasCalled = true
        createSearchedReposData()
        items.onNext(repos)
    }

    func createReposData() {
        let repoOne = Repository(name: "Name 1", description: "Description 1", stars: 1)
        let repoTwo = Repository(name: "Name 2", description: "Description 2", stars: 2)
        repos = [repoOne, repoTwo]
    }

    func createSearchedReposData() {
        let repoOne = Repository(name: "Name 1", description: "Description 1", stars: 1)
        repos = [repoOne]
    }
}
