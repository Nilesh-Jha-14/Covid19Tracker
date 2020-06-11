//
//  OverAllInfoTableViewCell.swift
//  Covid_break_Out
//
//  Created by JHA Nilesh Kumar on 25/03/20.
//  Copyright © 2020 JHA Nilesh Kumar. All rights reserved.
//

import UIKit

class OverAllInfoTableViewCell: UITableViewCell {
    
    @IBOutlet weak var confirmedDeltaLabel: UILabel!
    @IBOutlet weak var confirmedCountLabel: UILabel!

    @IBOutlet weak var activeDeltaLabel: UILabel!
    @IBOutlet weak var activeCountLabel: UILabel!

    @IBOutlet weak var recoveredDeltaLabel: UILabel!
    @IBOutlet weak var recoveredCountLabel: UILabel!

    @IBOutlet weak var deceasedDeltaLabel: UILabel!
    @IBOutlet weak var deceasedCountLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    func configureData(model : DashBoardModel) {
        if let stateTotal = model.statewise?.first {
            if let active = stateTotal.active {
                self.activeCountLabel.text = active
            }
            if let confirmed = stateTotal.confirmed {
                self.confirmedCountLabel.text = confirmed
            }
            if let recovered = stateTotal.recovered {
                self.recoveredCountLabel.text = recovered
            }
            if let deaths = stateTotal.deaths {
                self.deceasedCountLabel.text = deaths
            }

            if let keyValue = model.keyValues?.first {
                var activeDelta = 0
                if let confirmedDelta = keyValue.confirmeddelta {
                    self.confirmedDeltaLabel.text = "+\(confirmedDelta)"
                    activeDelta = Int(confirmedDelta)!
                }
                if let recovereddelta = keyValue.recovereddelta {
                    self.recoveredDeltaLabel.text = "+\(recovereddelta)"
                    activeDelta = activeDelta - Int(recovereddelta)!
                }
                if let deceaseddelta = keyValue.deceaseddelta {
                    self.deceasedDeltaLabel.text = "+\(deceaseddelta)"
                     activeDelta = activeDelta - Int(deceaseddelta)!
                }
                activeDeltaLabel.text = "+\(activeDelta)"
            }
        }
    }

}
