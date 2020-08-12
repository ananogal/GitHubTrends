//
//  UIStoryboardExtension.swift
//  GitHubTrends
//
//  Created by Ana Nogal on 11/08/2020.
//  Copyright © 2020 ananogal. All rights reserved.
//

import UIKit

extension UIStoryboard {
    static func main() -> UIStoryboard {
        return UIStoryboard(name: "Main", bundle: nil)
    }

    static func repositoriesViewController() -> RepositoriesViewController {
        let storyBoard = UIStoryboard.main()
        return storyBoard.instantiateViewController(withIdentifier: "RepositoriesViewController") as! RepositoriesViewController
    }

    static func detailsViewController() -> DetailsViewController {
        let storyBoard = UIStoryboard.main()
        return storyBoard.instantiateViewController(withIdentifier: "DetailsViewController") as! DetailsViewController
    }
}
