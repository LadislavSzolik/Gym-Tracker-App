//
//  NewExerciseForWorkoutTableViewController.swift
//  Gym Tracker App
//
//  Created by Ladislav Szolik on 01.01.18.
//  Copyright © 2018 Ladislav Szolik. All rights reserved.
//

import UIKit



class NewExerciseForWorkoutTableViewController: UITableViewController {
    
    @IBOutlet weak var exerciseNameLabel: UILabel!
    var exercise: Exercise?
    @IBOutlet weak var numberOfSets: UILabel!
    @IBOutlet weak var setStepper: UIStepper!
    @IBOutlet weak var targetRepsTextField: UITextField!
    @IBOutlet weak var withWeightsSwitch: UISwitch!
    @IBOutlet weak var targetWeightsTextField: UITextField!
    @IBOutlet weak var saveButton: UIBarButtonItem!
    
    var newWorkoutExercise :WorkoutExercise?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let setWorkoutExercise = newWorkoutExercise {
            exerciseNameLabel!.text = setWorkoutExercise.name
            exercise = setWorkoutExercise.exercise
            numberOfSets!.text = String(setWorkoutExercise.sets)
            setStepper.value = Double(setWorkoutExercise.sets)
            targetRepsTextField!.text = setWorkoutExercise.targetReps
            withWeightsSwitch.isOn = setWorkoutExercise.withWeights
            targetWeightsTextField!.text = setWorkoutExercise.targetWeights
            
        } else {
            numberOfSets!.text = "\(Int(setStepper.value))"
          
        }
        updateSaveButton()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
      
    }
    
    func updateSaveButton() {
        saveButton.isEnabled  = (exercise != nil) ? true : false
    }

    @IBAction
    func unwindToNewExerciseForWorkout(segue :UIStoryboardSegue ) {
        if segue.identifier == "UnwindToNewExerciseForWorkout" {
            let exercisesForWorkout = segue.source as! ExercisesForWorkoutTableViewController
            exerciseNameLabel!.text = exercisesForWorkout.chosenExercise!.name
            exercise =  exercisesForWorkout.chosenExercise
            updateSaveButton()
        }
    }

    @IBAction func setValueChanged(_ sender: Any) {
         numberOfSets!.text = "\(Int(setStepper.value))"
    }
    
    @IBAction func doneButtonForTargetRepsPressed(_ sender: UITextField) {
        sender.resignFirstResponder()
    }
    
    @IBAction func changeWithWeights(_ sender: Any) {
        tableView.beginUpdates()
        tableView.endUpdates()
    }
    
    @IBAction func doneButtonForWeightsPressed(_ sender: UITextField) {
        sender.resignFirstResponder()
    }
    
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 3 && indexPath.row == 1 {
            if withWeightsSwitch.isOn {
                return 44.0
            } else {
                return 0.0
            }
        } else {
            return 44.0
        }
        
      
    }
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ShowExercisesForWorkout" {
            if let exercise = exercise {
                let exercisesForWorkout = segue.destination as! ExercisesForWorkoutTableViewController
                exercisesForWorkout.chosenExercise = exercise
                
            }
        } else if segue.identifier == "SaveNewExerciseForWorkout" {
            newWorkoutExercise = WorkoutExercise(name: exerciseNameLabel!.text! , exercise: exercise!, sets: Int(setStepper.value), targetReps: targetRepsTextField!.text!, withWeights: withWeightsSwitch.isOn, targetWeights: targetWeightsTextField!.text!)
        }
    }
    

}
