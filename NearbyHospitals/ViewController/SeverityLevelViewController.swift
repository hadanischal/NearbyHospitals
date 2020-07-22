//
//  SeverityLevelViewController.swift
//  NearbyHospitals
//
//  Created by Nischal Hada on 21/6/20.
//  Copyright © 2020 Nischal Hada. All rights reserved.
//

import RxCocoa
import RxSwift
import UIKit

final class SeverityLevelViewController: UIViewController, BaseViewProtocol {
    @IBOutlet var collectionView: UICollectionView!
    private var viewModel: SeverityLevelDataSource!
    private let disposeBag = DisposeBag()

    convenience init(withDataSource dataSource: SeverityLevelDataSource) {
        self.init()
        self.viewModel = dataSource
    }

    static func severityLevelVC() -> SeverityLevelViewController {
        let viewController = StoryboardScene.Main.severityLevelViewController.instantiate()
        viewController.viewModel = SeverityLevelViewModel()
        return viewController
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setUpUI()
        configureTableView()
    }

    private func setUpUI() {
        viewModel.navigationTitle.bind(to: navigationItem.rx.title).disposed(by: disposeBag)
        navigationItem.backBarButtonItem = navigationController?.backBarButtton
        navigationController?.setCustomStyle()
    }

    private func configureTableView() {
        collectionView.register(SeverityLevelCollectionCell.self)
        collectionView.delegate = self
        collectionView.dataSource = self
        view.backgroundColor = UIColor.viewBackgroundColor
        collectionView.backgroundColor = UIColor.viewBackgroundColor
    }
}

// MARK: - CollectionView DataSource and Delegate

extension SeverityLevelViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.numberOfRowsInSection
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 165, height: 90)
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(for: indexPath) as SeverityLevelCollectionCell
        let levelOfPain = viewModel.severity(forIndex: indexPath.row)
        cell.configureCell(with: levelOfPain)
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        handellNavigation(indexPath)
    }

    private func handellNavigation(_ indexPath: IndexPath) {
        let levelOfPain = viewModel.severity(forIndex: indexPath.row)
        let viewController = HospitaListViewController.hospitaListVC(withLevelOfPain: levelOfPain)
        navigationController?.pushViewController(viewController, animated: true)
    }
}
