//
//  SignShopDetailViewController.swift
//  LesHabituesTest
//
//  Created by Frédéric Mallet on 30/03/2020.
//  Copyright © 2020 Frederic Mallet. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import RxDataSources
import SwifterSwift
import RxAlertController

final class SignShopDetailViewController: UIViewController {

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

    // MARK: Injected
    var viewModel: SignShopDetailViewModel!

    // MARK: Private
    private var dataSource: RxTableViewSectionedReloadDataSource<SignShopDetailViewModel.DetailSectionModel>!

    // MARK: Navigation
    static func instantiate() -> SignShopDetailViewController {
        return UIStoryboard.shop.viewController(type: SignShopDetailViewController.self)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }

}

// MARK: Setup & Binding
private extension SignShopDetailViewController {
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

    func cellShop(tableView: UITableView, indexPath: IndexPath, shop: ShopModel) -> UITableViewCell {
        var shop = shop
        let cell = tableView.dequeueReusableCell(withClass: ShopCell.self, for: indexPath)
        cell.configure(name: shop.name,
                       adress: shop.adress)
        return cell
    }

    func bindViewModel() {
        viewModel.output.title
            .drive(rx.title)
            .disposed(by: disposeBag)
        
        viewModel.output.sections
            .bind(to: tableView.rx.items(dataSource: dataSource))
            .disposed(by: disposeBag)
    }
}

// MARK: UITableViewDelegate
extension SignShopDetailViewController: UITableViewDelegate { }

