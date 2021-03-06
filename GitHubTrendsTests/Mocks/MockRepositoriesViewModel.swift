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
    var loadedRepos = [Repository]()

    func loadData() {
        loadDataWasCalled = true
        createReposData()
        loadedRepos = repos
        items.onNext(repos)
    }

    func searchRepositories(textToSearch: String) {
        searchRepositoriesWasCalled = true
        createSearchedReposData()
        items.onNext(repos)
    }

    func createReposData() {
        let repoOne = Repository(name: "Name 1", description: "Description 1", stars: 1, avatar: "", author: "author", forks: 1, url: "")
        let repoTwo = Repository(name: "Name 2", description: "Description 2", stars: 2, avatar: "", author: "author", forks: 1, url: "")
        repos = [repoOne, repoTwo]
    }

    func createSearchedReposData() {
        let repoOne = Repository(name: "Name 1", description: "Description 1", stars: 1, avatar: "", author: "author", forks: 1, url: "")
        repos = [repoOne]
    }

    func resetSearch() {
        items.onNext(loadedRepos)
    }
}
