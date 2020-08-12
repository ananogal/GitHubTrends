//
//  DetailsViewModel.swift
//  GitHubTrends
//
//  Created by Ana Nogal on 12/08/2020.
//  Copyright © 2020 ananogal. All rights reserved.
//

import Foundation

protocol DetailsViewModelType {
    var title: String { get }
    var avatarURL: URL? { get }
}

class DetailsViewModel: DetailsViewModelType {
    private let item: Repository

    init(item: Repository) {
        self.item = item
    }

    var title: String {
        return item.name
    }

    var avatarURL: URL? {
        return URL(string: item.avatar)
    }
}
