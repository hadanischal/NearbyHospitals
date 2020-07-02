//
//  DiseaseListTableViewCell.swift
//  NearbyHospitals
//
//  Created by Nischal Hada on 21/6/20.
//  Copyright © 2020 Nischal Hada. All rights reserved.
//

import UIKit

class DiseaseListTableViewCell: UITableViewCell {
    override func awakeFromNib() {
        super.awakeFromNib()

        contentView.backgroundColor = .viewBackgroundColor
        textLabel?.font = .body1
        detailTextLabel?.font = .detailBody
        textLabel?.textColor = .titleColor
        detailTextLabel?.textColor = .descriptionColor
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

    func configure(_ title: String, description: String?) {
        textLabel?.text = title
        detailTextLabel?.text = description
        accessoryType = .disclosureIndicator
        contentView.superview?.backgroundColor = .viewBackgroundColor
    }
}
