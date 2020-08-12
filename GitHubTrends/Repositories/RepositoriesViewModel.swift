//
//  RepositoriesViewModelType.swift
//  GitHubTrends
//
//  Created by Ana Nogal on 11/08/2020.
//  Copyright © 2020 ananogal. All rights reserved.
//

import Foundation
import RxSwift

protocol RepositoriesViewModelType {
    var items: PublishSubject<[Repository]> { get }
    func loadData()
    func searchRepositories(textToSearch: String)
    func resetSearch()
}

class RepositoriesViewModel: RepositoriesViewModelType {
    private var originalItems = [Repository]()
    var items: PublishSubject<[Repository]> = PublishSubject<[Repository]>()

    private let gateway: GatewayType

    init(with gateway: GatewayType) {
        self.gateway = gateway
    }

    func loadData() {
        gateway.loadRepositories { [weak self] (repositories) in
            self?.originalItems = repositories
            self?.items.onNext(repositories)
        }
    }

    func searchRepositories(textToSearch: String) {
        guard !textToSearch.isEmpty else { return }
        let fitered = originalItems.filter { item in
            return item.name.lowercased().contains(textToSearch.lowercased())
        }

        items.onNext(fitered)
    }

    func resetSearch() {
        items.onNext(originalItems)
    }
}
