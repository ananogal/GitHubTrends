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
}

class RepositoriesViewModel: RepositoriesViewModelType {
    var items: PublishSubject<[Repository]> = PublishSubject<[Repository]>()

    func loadData() {
        
    }
}

struct Repository {
    let name: String
    let description: String
    let stars: Int
}
