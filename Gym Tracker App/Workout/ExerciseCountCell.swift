//
//  ExerciseCountCell.swift
//  Gym Tracker App
//
//  Created by Ladislav Szolik on 03.12.17.
//  Copyright © 2017 Ladislav Szolik. All rights reserved.
//

import UIKit

protocol ExerciseCountDelegate {
    func didExerciseCountIncreased( cell: ExerciseCountCell)
}

class ExerciseCountCell: UITableViewCell {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var stepper: UIStepper!
    var delegate: ExerciseCountDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    
    @IBAction func stepperValueChanged(_ sender: UIStepper) {
        delegate?.didExerciseCountIncreased(cell: self)
    }
    
}
