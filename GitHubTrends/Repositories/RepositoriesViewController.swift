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

        navigationItem.searchController?
            .searchBar.rx.cancelButtonClicked
            .subscribe(onNext: { [weak self]  in
                self?.resetSearch()
            })
        .disposed(by: bag)
    }

    private func setUpTableView() {
        tableView.register(UINib(nibName: cellIdentifier, bundle: nil), forCellReuseIdentifier: cellIdentifier)
        viewModel.items
            .bind(to: tableView.rx.items(cellIdentifier: cellIdentifier, cellType: RepositoryCell.self))
            { (row,item,cell) in
                cell.configure(item: item)
            }
        .disposed(by: bag)

        tableView.rx.modelSelected(Repository.self).subscribe(onNext: { [weak self] item in
            self?.showDetails(item)
        }).disposed(by: bag)
    }

    func resetSearch() {
        viewModel.resetSearch()
    }

    func showDetails(_ item: Repository) {
        let vc = UIStoryboard.detailsViewController()
        let gateway = Gateway()
        let detailsViewModel = DetailsViewModel(item: item, gateway: gateway)
        vc.viewModel = detailsViewModel
        navigationController?.pushViewController(vc, animated: true)
    }
}

extension RepositoriesViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        guard let textToSearch = searchController.searchBar.text else {
            return
        }
        viewModel.searchRepositories(textToSearch: textToSearch)
    }
}
