//
//  HospitaListTableViewCell.swift
//  NearbyHospitals
//
//  Created by Nischal Hada on 22/6/20.
//  Copyright © 2020 Nischal Hada. All rights reserved.
//

import UIKit

class HospitaListTableViewCell: UITableViewCell {
    override func awakeFromNib() {
        super.awakeFromNib()

        contentView.backgroundColor = .viewBackgroundColor
        textLabel?.font = .textButton
        textLabel?.textColor = .titleColor

        detailTextLabel?.font = .detailBody
        detailTextLabel?.textColor = .descriptionColor
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
