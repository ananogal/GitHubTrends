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
        let viewController = storyBoard.instantiateViewController(withIdentifier: "RepositoriesViewController") as! RepositoriesViewController

        return viewController
    }
}
