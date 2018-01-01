//
//  RecordSetTableViewController.swift
//  Gym Tracker App
//
//  Created by Ladislav Szolik on 01.01.18.
//  Copyright © 2018 Ladislav Szolik. All rights reserved.
//

import UIKit

struct ExerciseSet {
    var reps: String
    var withWeights: Bool
    var weights: String
}

class RecordSetTableViewController: UITableViewController {
    
    var exerciseSet: ExerciseSet?
    var targetReps: String?
    var targetWeight: String?
    @IBOutlet weak var repsTextField: UITextField!
    @IBOutlet weak var withWeightsSwitch: UISwitch!
    @IBOutlet weak var weightsTextField: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let givenExerciseSet = exerciseSet {
            repsTextField!.text = givenExerciseSet.reps
            withWeightsSwitch.isOn = givenExerciseSet.withWeights
            weightsTextField.text = givenExerciseSet.weights
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }

    override func tableView(_ tableView: UITableView, titleForFooterInSection section: Int) -> String? {
        if section == 0 {
            if let targetReps = targetReps {
                return "Target "+targetReps+" Reps"
            } else {
                return "No Target set"
            }
        } else if section == 1 {
            if let targetWeight = targetWeight {
                return "Target "+targetWeight+" kg"
            } else {
                return "No Target set"
            }
        } else {
            return ""
        }
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
