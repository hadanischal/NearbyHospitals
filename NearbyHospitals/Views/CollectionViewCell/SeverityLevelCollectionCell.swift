//
//  SeverityLevelCollectionCell.swift
//  NearbyHospitals
//
//  Created by Nischal Hada on 23/6/20.
//  Copyright © 2020 Nischal Hada. All rights reserved.
//

import UIKit

class SeverityLevelCollectionCell: UICollectionViewCell {
    @IBOutlet var card: UIView!
    @IBOutlet var imageIcon: UIImageView!

    override var isSelected: Bool {
        didSet {
            if self.isSelected {
                self.layer.borderColor = UIColor.coral.cgColor
                self.layer.borderWidth = 1
            } else {
                self.layer.borderColor = UIColor.clear.cgColor
                self.layer.borderWidth = 1
            }
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        contentView.backgroundColor = .viewBackgroundColor

        // Set cell cornerRadius and shadow
        self.card.layer.cornerRadius = 10
        self.card.layer.masksToBounds = true

        // Draw showdow to cell
        self.backgroundColor = UIColor.clear
        self.drawShadow(offset: CGSize(width: 0, height: 2), radius: 4.0, opacity: 0.2)
    }

    func configureCell(with levelOfPain: LevelOfPain) {
        imageIcon.image = levelOfPain.icnImage.image
    }
}
