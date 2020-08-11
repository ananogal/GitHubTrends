//
//  SceneDelegate.swift
//  GitHubTrends
//
//  Created by Ana Nogal on 11/08/2020.
//  Copyright © 2020 ananogal. All rights reserved.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let repositoriesVC = storyboard.instantiateViewController(identifier: "RepositoriesViewController")
            as! RepositoriesViewController

        let viewModel = RepositoriesViewModel()
        repositoriesVC.viewModel = viewModel

        let window = UIWindow(windowScene: scene as! UIWindowScene)
        window.rootViewController = UINavigationController(rootViewController: repositoriesVC)
        window.makeKeyAndVisible()

        self.window = window
    }
}

