//
//  ShopListViewController.swift
//  LesHabituesTest
//
//  Created by Frederic Mallet on 04/02/2019.
//  Copyright © 2019 Frederic Mallet. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import RxDataSources
import SwifterSwift
import RxAlertController

final class ShopListViewController: UIViewController {

    // MARK: IBOutlet
    @IBOutlet private weak var tableView: UITableView! {
        didSet {
            tableView.estimatedRowHeight = 100
            tableView.rowHeight = UITableView.automaticDimension
            tableView.estimatedSectionHeaderHeight = UITableView.automaticDimension
            tableView.register(nibWithCellClass: ShopCell.self)
            tableView.rx.setDelegate(self).disposed(by: disposeBag)
        }
    }
    
    @IBOutlet private weak var activityIndicator: UIActivityIndicatorView!

    // MARK: Injected
    var viewModel: ShopListViewModel!

    // MARK: Private
    private var dataSource: RxTableViewSectionedReloadDataSource<ShopListViewModel.ShopSectionModel>!

    // MARK: Navigation
    static func instantiate() -> ShopListViewController {
        return UIStoryboard.shop.viewController(type: ShopListViewController.self)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }

}

// MARK: Setup & Binding
private extension ShopListViewController {
    func setup() {
        setupDataSource()
        bindViewModel()
    }

    func setupDataSource() {
        //swiftlint:disable:next line_length
        dataSource = RxTableViewSectionedReloadDataSource(configureCell: { [weak self] (_, tableView, indexPath, data) -> UITableViewCell in
            guard let self = self else { return UITableViewCell() }
            return self.cellShop(tableView: tableView,
                                 indexPath: indexPath,
                                 shop: data)
        })
    }

    func cellShop(tableView: UITableView, indexPath: IndexPath, shop: SignShopModel) -> UITableViewCell {
        var shop = shop
        let cell = tableView.dequeueReusableCell(withClass: ShopCell.self, for: indexPath)
        cell.configure(logo: shop.logo, name: shop.name,
                       category: shop.category)
        return cell
    }

    func bindViewModel() {
        viewModel.output.sections
            .bind(to: tableView.rx.items(dataSource: dataSource))
            .disposed(by: disposeBag)

        viewModel.output.state
            .map { $0 == .loading  }
            .drive(tableView.rx.isHidden)
            .disposed(by: disposeBag)

        viewModel.output.state
            .map { $0 != .loading }
            .drive(activityIndicator.rx.isHidden)
            .disposed(by: disposeBag)

        viewModel.output.state
            .map { $0 == .loading }
            .drive(activityIndicator.rx.isAnimating)
            .disposed(by: disposeBag)


        viewModel.output.state
            .filter { $0 == .error }
            .asObservable()
            .flatMap { [weak self] _ -> Single<Int> in
                guard let self = self else { return .never() }
                let title = NSLocalizedString("alert_failure_title", comment: "")
                let message = NSLocalizedString("alert_failure_description", comment: "")
                let buttonTitle = NSLocalizedString("alert_failure_button", comment: "")
                return UIAlertController.rx
                    .show(in: self, title: title,
                          message: message,
                          buttons: [.default(buttonTitle)])
            }.map { _ in () }
            .bind(to: viewModel.input.refresh)
            .disposed(by: disposeBag)
    }
}

// MARK: UITableViewDelegate
extension ShopListViewController: UITableViewDelegate { }
