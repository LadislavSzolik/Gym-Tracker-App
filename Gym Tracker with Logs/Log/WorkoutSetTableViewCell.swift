//
//  WorkoutSetTableViewCell.swift
//  Gym Tracker with Logs
//
//  Created by Ladislav Szolik on 22.10.17.
//  Copyright © 2017 Ladislav Szolik. All rights reserved.
//

import UIKit

protocol WorkoutSetCellDelegate {
    func didWeightChanged(for indexPath: IndexPath, weights: Double)
    func didRepetitionChanged(for indexPath: IndexPath, repetition: Int)
}

class WorkoutSetTableViewCell: UITableViewCell {

    @IBOutlet weak var indexLabel: UILabel!
    @IBOutlet weak var repetitionTextField: UITextField!
    @IBOutlet weak var repetitionLabel: UILabel!
    @IBOutlet weak var WeightsTextField: UITextField!
    @IBOutlet weak var WeightsLabel: UILabel!
    
    var indexPath: IndexPath?
    var repetition: Int?
    var weights: Double?
    
    var delegate:WorkoutSetCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    @IBAction func RepetitionDoneButtonPressed(_ sender: Any) {
        repetitionTextField.resignFirstResponder()
    }
    
    @IBAction func WeightsDoneButtonPressed(_ sender: Any) {
        WeightsTextField.resignFirstResponder()
    }
    
    @IBAction func editedRepetition(_ sender: Any) {
        if let repsText = repetitionTextField.text, let reps = Int(repsText), let indexPath = indexPath {
            delegate?.didRepetitionChanged(for:indexPath , repetition: reps)
        }
    }
    
    
    @IBAction func editedWeights(_ sender: Any) {
        if let weightsText = WeightsTextField.text, let weights = Double(weightsText), let indexPath = indexPath {
            delegate?.didWeightChanged(for: indexPath, weights: weights)
        }
    }
    
}
