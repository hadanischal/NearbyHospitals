//
//  CustomHeaderFooterView.swift
//  NearbyHospitals
//
//  Created by Nischal Hada on 21/6/20.
//  Copyright © 2020 Nischal Hada. All rights reserved.
//

import UIKit

class CustomHeaderFooterView: UITableViewHeaderFooterView {
    let titleLable = UILabel()
    let imageView = UIImageView()

    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)

        configureContents()
    }

    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func configureContents() {
        titleLable.font = .heading1
        imageView.translatesAutoresizingMaskIntoConstraints = false
        titleLable.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(titleLable)
        NSLayoutConstraint.activate([
            titleLable.leadingAnchor.constraint(equalTo: contentView.layoutMarginsGuide.leadingAnchor),
            titleLable.heightAnchor.constraint(equalToConstant: 30),
            titleLable.trailingAnchor.constraint(equalTo:
                contentView.layoutMarginsGuide.trailingAnchor),
            titleLable.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
        ])
    }

    func configure(_ title: String, image: UIImage? = nil) {
        titleLable.text = title
        imageView.image = image
    }
}
