//
//  CityForecastTableViewCell.swift
//  Parent
//
//  Created by Ahmed Aly on 7/2/17.
//  Copyright © 2017 Ahmed Aly. All rights reserved.
//

import UIKit

class CityForecastTableViewCell: UITableViewCell {

    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var maxTempLabel: UILabel!
    @IBOutlet weak var minTempLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
