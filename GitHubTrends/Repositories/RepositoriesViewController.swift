//
//  ViewController.swift
//  GitHubTrends
//
//  Created by Ana Nogal on 11/08/2020.
//  Copyright © 2020 ananogal. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class RepositoriesViewController: UIViewController {
    @IBOutlet var tableView: UITableView!
    var viewModel: RepositoriesViewModelType!
    private let cellIdentifier = "RepositoryCell"
    private let bag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()
        setUpUI()
    }

    private func setUpUI() {
        setTitle()
        setUpSearchController()
        setUpTableView()
        viewModel.loadData()
    }

    private func setTitle() {
        title = "GitHub Trends"
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.tintColor]
    }

    private func setUpSearchController() {
        let search = UISearchController(searchResultsController: nil)
        search.searchResultsUpdater = self
        search.searchBar.placeholder = "Search"
        search.obscuresBackgroundDuringPresentation = false
        navigationItem.hidesSearchBarWhenScrolling = false
        navigationItem.searchController = search
    }

    private func setUpTableView() {
        tableView.register(UINib(nibName: cellIdentifier, bundle: nil), forCellReuseIdentifier: cellIdentifier)
    }

}

extension RepositoriesViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {

    }
}
