//
//  ViewController.swift
//  GitHubTrends
//
//  Created by Ana Nogal on 11/08/2020.
//  Copyright © 2020 ananogal. All rights reserved.
//

import UIKit

class RepositoriesViewController: UIViewController {
    var viewModel: RepositoriesViewModelType!

    override func viewDidLoad() {
        super.viewDidLoad()
        setUpUI()
    }

    private func setUpUI() {
        setTitle()
    }

    private func setTitle() {
        title = "GitHub Trends"
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.tintColor]
    }

}

extension RepositoriesViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {

    }
}
