//
//  DiseaseListViewController.swift
//  NearbyHospitals
//
//  Created by Nischal Hada on 21/6/20.
//  Copyright © 2020 Nischal Hada. All rights reserved.
//

import RxCocoa
import RxSwift
import UIKit

final class DiseaseListViewController: UITableViewController, BaseViewProtocol {
    private var viewModel: DiseaseListDataSource = DiseaseListViewModel()
    private let disposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()
        setUpUI()
        configureTableView()
        setupViewModel()
    }

    private func setUpUI() {
        viewModel.navigationTitle.bind(to: navigationItem.rx.title).disposed(by: disposeBag)
        navigationItem.backBarButtonItem = navigationController?.backBarButtton
        navigationController?.setCustomStyle()
    }

    private func configureTableView() {
        tableView?.backgroundColor = UIColor.viewBackgroundColor
        view.backgroundColor = UIColor.viewBackgroundColor
        tableView.tableFooterView = UIView(frame: CGRect.zero)
        tableView.register(DiseaseListTableViewCell.self)
        tableView.register(CustomHeaderFooterView.self, forHeaderFooterViewReuseIdentifier: "CustomHeaderFooterView")
        tableView.estimatedRowHeight = 160
        tableView.rowHeight = UITableView.automaticDimension
    }

    private func setupViewModel() {
        viewModel.updateInfo
            .filter { $0 }
            .asDriver(onErrorJustReturn: false)
            .drive(onNext: { [weak self] _ in
                self?.tableView.reloadData()
            }).disposed(by: disposeBag)

        viewModel.errorResult
            .observeOn(MainScheduler.instance)
            .subscribe(onNext: { [weak self] error in
                self?.removeSpinnerView()
                self?.showAlertView(withTitle: error.localizedDescription, andMessage: error.localizedDescription)
            }).disposed(by: disposeBag)

        viewModel.isLoading
            .observeOn(MainScheduler.instance)
            .subscribe(onNext: { [weak self] status in
                if status {
                    self?.createSpinnerView()
                } else {
                    self?.removeSpinnerView()
                }
            }).disposed(by: disposeBag)

        viewModel.viewDidLoad()
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numbersOfIllness
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(forIndexPath: indexPath) as DiseaseListTableViewCell
        let data = viewModel.diseaseInfo(forIndex: indexPath.row)
        cell.configure(data.name, description: nil)
        return cell
    }

    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = tableView.dequeueReusableHeaderFooterView(withIdentifier: String(describing: CustomHeaderFooterView.self))
        view?.textLabel?.text = viewModel.tableViewHeader
        view?.textLabel?.font = .detailTitle
        return view
    }

    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 38
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        handellNavigation(indexPath)
    }

    private func handellNavigation(_ indexPath: IndexPath) {
        let viewController = SeverityLevelViewController.severityLevelVC()
        navigationController?.pushViewController(viewController, animated: true)
    }
}
