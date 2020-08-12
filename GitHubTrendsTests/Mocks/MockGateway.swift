//
//  MockGateway.swift
//  GitHubTrendsTests
//
//  Created by Ana Nogal on 12/08/2020.
//  Copyright © 2020 ananogal. All rights reserved.
//

@testable import GitHubTrends
class MockGateway: GatewayType {
    var repos = [Repository]()
    var loadRepositoriesWasCalled = false
    var loadReadMeWasCalled = false

    func loadRepositories(completion: ([Repository]) -> ()) {
        loadRepositoriesWasCalled = true

        let repoOne = Repository(name: "Name 1", description: "Description 1", stars: 1, avatar: "", author: "author", forks: 1, url: "")
        let repoTwo = Repository(name: "Name 2", description: "Description 2", stars: 2, avatar: "", author: "author", forks: 1, url: "")
        let repoThree = Repository(name: "Name 3", description: "Description 3", stars: 3, avatar: "", author: "author", forks: 1, url: "")
        let repoFour = Repository(name: "Name 4", description: "Description 4", stars: 4, avatar: "", author: "author", forks: 1, url: "")
        repos = [repoOne, repoTwo, repoThree, repoFour]
        completion(repos)
    }

    func loadReadMe(readMeUrl: String, completion: @escaping (String) -> ()) {
        loadReadMeWasCalled = true

        completion("A beutiful text")
    }
}
