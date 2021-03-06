//
//  WorkoutDetailTableViewController.swift
//  Gym Tracker with Logs
//
//  Created by Ladislav Szolik on 28.10.17.
//  Copyright © 2017 Ladislav Szolik. All rights reserved.
//

import UIKit

class WorkoutDetailTableViewController: UITableViewController, WorkoutMuscleGroupDelegate {
    
    var selectedExercises = [Exercise]()
    var selectedMuscleGroups = [MuscleGroup]()
    var selectedMusclesDescription: String {
        var finalString: String = ""
        for muslceGroup in selectedMuscleGroups {
            var comma: String = ", "
            if finalString.isEmpty {
                comma = ""
            }
            finalString =  finalString + comma + "\(muslceGroup.rawValue)"
        }
        return finalString
    }
    var allExercises = [Exercise]()
    
    var workout: Workout?
    var recordingWorkout:Bool = false
    
    @IBOutlet weak var leftBarButton: UIBarButtonItem!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let savedExercises = Exercise.loadExercises() {
            allExercises = savedExercises
        }
        
        if let selectedWorkout = workout {
            recordingWorkout = true
            
            selectedExercises = selectedWorkout.exercises
            selectedMuscleGroups = selectedWorkout.muscleGroups
            
            navigationItem.title = selectedMusclesDescription
            navigationItem.rightBarButtonItem = editButtonItem
            navigationItem.hidesBackButton = false
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        
        switch section {
        case 0:
            if recordingWorkout {
                return ""
            }
            else {
                return "Target Muscle Groups"
            }
        default:
            return "Exercises"
        }
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        } else {
            return selectedExercises.count
        }
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 && !recordingWorkout {
            let cell = tableView.dequeueReusableCell(withIdentifier: "MuscleGroupChooserCell", for: indexPath)
            if selectedMuscleGroups.count == 0 {
                cell.textLabel?.text = "Select Muscles"
            } else {
                cell.textLabel?.text = selectedMusclesDescription
            }
            return cell
        } else if indexPath.section == 0 && recordingWorkout {
            let cell = tableView.dequeueReusableCell(withIdentifier: "RecordWorkoutCell", for: indexPath)
            return cell
        } else {
            if selectedMuscleGroups.isEmpty {
                let cell = tableView.dequeueReusableCell(withIdentifier: "NoExerciseCell", for: indexPath)
                cell.textLabel!.text = "Select Muscle Groups first"
                return cell
            } else {
                let cell = tableView.dequeueReusableCell(withIdentifier: "ExerciseCell", for: indexPath)
                let exercise = selectedExercises[indexPath.row]
                cell.textLabel!.text = exercise.name
                cell.detailTextLabel!.text = exercise.muscleGroup.rawValue
                return cell
            }
        }
    }
 
    func didSelectedMuscleGroup(muscleGroup: [MuscleGroup]) {
        selectedMuscleGroups = muscleGroup
        selectedExercises = allExercises.filter({ (exercise) -> Bool in
            return selectedMuscleGroups.contains(exercise.muscleGroup)
        })
        tableView.reloadData()
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        if indexPath.section == 1 {
            return true
        } else {
            return false
        }
    }
 
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            selectedExercises.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }


    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "SelectMuscleGroups" {
            let muscleGroupController = segue.destination as! WorkoutMuscleGroupTableViewController
            muscleGroupController.delegate = self
            muscleGroupController.chosenMuscleGroups = selectedMuscleGroups
        } else if segue.identifier == "SaveWorkout" {
            workout = Workout(name: selectedMusclesDescription, exercises: selectedExercises, muscleGroups: selectedMuscleGroups)
        } else if segue.identifier == "RecordWorkout" {
            let workoutRecordController = segue.destination as! WorkoutRecordTableViewController
            workoutRecordController.workout = workout
        }
    }
    

}
