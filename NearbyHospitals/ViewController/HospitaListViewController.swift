//
//  HospitaListViewController.swift
//  NearbyHospitals
//
//  Created by Nischal Hada on 21/6/20.
//  Copyright © 2020 Nischal Hada. All rights reserved.
//

import RxCocoa
import RxSwift
import SwiftRichString
import UIKit

private struct Theme {
    static var description = Style {
        $0.color = UIColor.coral
        $0.font = UIFont.detailBody
    }

    static var time = Style {
        $0.color = UIColor.descriptionColor
        $0.font = UIFont.floatingLabelTitle
    }
}

final class HospitaListViewController: UITableViewController, BaseViewProtocol {
    private var viewModel: HospitaListDataSource!
    private let disposeBag = DisposeBag()

    convenience init(withDataSource dataSource: HospitaListDataSource) {
        self.init()
        self.viewModel = dataSource
    }

    static func hospitaListVC(withLevelOfPain levelOfPain: LevelOfPain) -> HospitaListViewController {
        let viewController = StoryboardScene.Main.hospitaListViewController.instantiate()
        viewController.viewModel = HospitaListViewModel(withLevelOfPain: levelOfPain)
        return viewController
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setUpUI()
        configureTableView()
        setupViewModel()
    }

    private func setUpUI() {
        viewModel.navigationTitle.bind(to: navigationItem.rx.title).disposed(by: disposeBag)
        navigationItem.backBarButtonItem = navigationController?.backBarButtton
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: Asset.Icons.iconsAppleMaps.image, style: .plain, target: self, action: #selector(actionMap))
    }

    private func configureTableView() {
        tableView?.backgroundColor = UIColor.viewBackgroundColor
        view.backgroundColor = UIColor.viewBackgroundColor
        tableView.tableFooterView = UIView(frame: CGRect.zero)
        tableView.register(HospitaListTableViewCell.self)
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
                self?.showAlertView(withTitle: error.localizedDescription, andMessage: error.localizedDescription)
            }).disposed(by: disposeBag)

        viewModel.isLoading.bind(to: isAnimating).disposed(by: disposeBag)

        viewModel.viewDidLoad()
    }

    @objc func actionMap() {
        handellNavigation()
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numbersOfHospital
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(forIndexPath: indexPath) as HospitaListTableViewCell
        let data = viewModel.hospitals(forIndex: indexPath.row)
        cell.textLabel?.text = data.name
        cell.detailTextLabel?.attributedText = detailText(data.waitingTime)
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

    private func handellNavigation(_ indexPath: IndexPath? = nil) {
        let location: Location? = indexPath != nil ? viewModel.hospitals(forIndex: indexPath!.row).location : nil
        let mapViewModel = MapViewModel(withHospitaModel: viewModel.hospitalList, initialLocation: location)
        let viewController = MapViewController.presentMapVC(withDataSource: mapViewModel)
        navigationController?.pushViewController(viewController, animated: true)
    }

    private func detailText(_ time: String) -> AttributedString {
        AttributedString.composing { () -> AttributedString in
            viewModel.waitingTimeDescription.set(style: Theme.description)
            time.set(style: Theme.time)
        }
    }
}
