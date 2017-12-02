//
//  ExerciseDetailTableViewController.swift
//  Gym Tracker with Logs
//
//  Created by Ladislav Szolik on 22.10.17.
//  Copyright © 2017 Ladislav Szolik. All rights reserved.
//

import UIKit

class ExerciseDetailTableViewController: UITableViewController {
    
    
    @IBOutlet weak var exerciseNameTextField: UITextField!
    @IBOutlet weak var muscleGroupTextField: UILabel!
    @IBOutlet weak var saveButton: UIBarButtonItem!
    
    var exercise: Exercise?
    var chosenMuscleGroup: MuscleGroup?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let selectedExercise = exercise {
            exerciseNameTextField.text = selectedExercise.name
            
            chosenMuscleGroup = selectedExercise.muscleGroup
            muscleGroupTextField.text = selectedExercise.muscleGroup.rawValue
        }
        updateSaveButton()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 44.0
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    @IBAction func nameChanged(_ sender: Any) {
        updateSaveButton()
    }
    

    // MARK: - Private functions
    /*
    func updateMeasurementType() {
        if (measurementSegment.selectedSegmentIndex == 0 && withWeightsSwitch.isOn ) {
            typeOfMeasurement = .RepetitionAndWeight
        } else if (measurementSegment.selectedSegmentIndex == 0 && !withWeightsSwitch.isOn ) {
            typeOfMeasurement = .Repetition
        } else if (measurementSegment.selectedSegmentIndex == 1 && withWeightsSwitch.isOn ) {
            typeOfMeasurement = .TimeAndWeight
        } else {
            typeOfMeasurement = .Time
        }
    }
 */
    
    @IBAction
    func unwindToExerciseDetailFromMuscleGroup(segue:UIStoryboardSegue) {
        guard segue.identifier == "UnwindToExerciseDetails" else {
            fatalError("Wrong segue got called")
        }
        let muscleGroupController = segue.source as! MuscleGroupTableViewController
        
        if let selectedMuscleGroup = muscleGroupController.chosenMuscleGroup {
            chosenMuscleGroup = selectedMuscleGroup
            muscleGroupTextField.text = selectedMuscleGroup.rawValue
            updateSaveButton()
        }
    }
    
    func updateSaveButton() {
        if let exerciseName = exerciseNameTextField.text, !exerciseName.isEmpty ,  let _ = chosenMuscleGroup {
            saveButton.isEnabled = true
        } else {
            saveButton.isEnabled = false
        }
    }
    
    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "SaveExerciseSegue" {
            exercise = Exercise(name: exerciseNameTextField.text!, muscleGroup: chosenMuscleGroup!, workoutSets: [])            
        } else if segue.identifier == "showMuscleGroups" {
            if let selectedchosenMuscleGroup = chosenMuscleGroup {
                let muscleGroupController = segue.destination as! MuscleGroupTableViewController
                muscleGroupController.chosenMuscleGroup = selectedchosenMuscleGroup
            }
        }
    }
    

}
