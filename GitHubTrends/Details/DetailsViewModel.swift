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
    var readMePublisher: PublishSubject<String> { get }
    func loadData()
    func loadReadMe()
}

class DetailsViewModel: DetailsViewModelType {
    private let item: Repository
    private let gateway: GatewayType

    var itemPublisher = PublishSubject<Repository>()
    var readMePublisher = PublishSubject<String>()

    init(item: Repository, gateway: GatewayType) {
        self.item = item
        self.gateway = gateway
    }

    var avatarURL: URL? {
        return URL(string: item.avatar)
    }

    func loadData() {
        itemPublisher.onNext(item)
        itemPublisher.onCompleted()
    }

    func loadReadMe() {
        gateway.loadReadMe(readMeUrl: item.readmeUrl) {[weak self] (text) in
            self?.readMePublisher.onNext(text)
            self?.readMePublisher.onCompleted()
        }
    }
}
