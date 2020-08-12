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
    func loadRepositories(completion: ([Repository]) -> ()) {
        loadRepositoriesWasCalled = true

        let repoOne = Repository(name: "Name 1", description: "Description 1", stars: 1)
        let repoTwo = Repository(name: "Name 2", description: "Description 2", stars: 2)
        let repoThree = Repository(name: "Name 3", description: "Description 3", stars: 3)
        let repoFour = Repository(name: "Name 4", description: "Description 4", stars: 4)
        repos = [repoOne, repoTwo, repoThree, repoFour]
        completion(repos)
    }
}
