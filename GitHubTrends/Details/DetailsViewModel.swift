//
//  DetailsViewModel.swift
//  GitHubTrends
//
//  Created by Ana Nogal on 12/08/2020.
//  Copyright © 2020 ananogal. All rights reserved.
//

import RxSwift

protocol DetailsViewModelType {
    var avatarURL: URL? { get }
    var itemPublisher: PublishSubject<Repository> { get }
    func loadData()
}

class DetailsViewModel: DetailsViewModelType {
    private let item: Repository

    var itemPublisher = PublishSubject<Repository>()

    init(item: Repository) {
        self.item = item
    }

    var avatarURL: URL? {
        return URL(string: item.avatar)
    }

    func loadData() {
        itemPublisher.onNext(item)
        itemPublisher.onCompleted()
    }
}
