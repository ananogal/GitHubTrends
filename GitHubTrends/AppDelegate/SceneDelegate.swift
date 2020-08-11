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
        let reposViewController = createRepositoriesViewController()
        let window = UIWindow(windowScene: scene as! UIWindowScene)
        window.rootViewController = UINavigationController(rootViewController: reposViewController)
        window.makeKeyAndVisible()

        self.window = window
    }

    private func createRepositoriesViewController() -> RepositoriesViewController {
        let reposViewController = UIStoryboard.repositoriesViewController()

        let viewModel = RepositoriesViewModel()
        reposViewController.viewModel = viewModel

        return reposViewController
    }
}

