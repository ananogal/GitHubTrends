//
//  Gateway.swift
//  GitHubTrends
//
//  Created by Ana Nogal on 12/08/2020.
//  Copyright © 2020 ananogal. All rights reserved.
//

import Alamofire

protocol GatewayType {
    func loadRepositories(completion: @escaping ([Repository]) -> ())
}

class Gateway: GatewayType {
    let baseURL = "https://ghapi.huchen.dev/"
    enum endPoint: String {
        case repositories
    }


    func loadRepositories(completion: @escaping ([Repository]) -> ()) {
        AF.request("\(baseURL)\(endPoint.repositories.rawValue)")
            .validate()
            .responseDecodable(of: [Repository].self) {(response) in
                guard let repos = response.value else { return }
                completion(repos)
        }
    }

}
