//
//  WorkoutLogCellTableViewCell.swift
//  Gym Tracker with Logs
//
//  Created by Ladislav Szolik on 28.10.17.
//  Copyright © 2017 Ladislav Szolik. All rights reserved.
//

import UIKit

class WorkoutLogCellTableViewCell: UITableViewCell {

    @IBOutlet weak var indexTextLabel: UILabel!
    @IBOutlet weak var repetitionValueLabel: UILabel!
    @IBOutlet weak var repetitionLabel: UILabel!
    @IBOutlet weak var weightsValueLabel: UILabel!
    @IBOutlet weak var weightsLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
