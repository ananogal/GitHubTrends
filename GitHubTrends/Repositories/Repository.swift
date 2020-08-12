//
//  Repository.swift
//  
//
//  Created by Ana Nogal on 12/08/2020.
//

struct Repository: Decodable {
    let name: String
    let description: String
    let stars: Int
    let avatar: String
    let author: String
    let forks: Int
    let url: String
}

extension Repository {
    var readmeUrl: String {
        let readme = "/master/README.md"
        let textToFind = "https://github.com"
        let textToReplace = "https://raw.githubusercontent.com"
        let newUrl = url.replacingOccurrences(of: textToFind, with: textToReplace)
        return "\(newUrl)\(readme)"
    }
}
