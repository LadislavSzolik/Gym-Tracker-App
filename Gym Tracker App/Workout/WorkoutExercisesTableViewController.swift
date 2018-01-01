//
//  WorkoutExercisesTableViewController.swift
//  Gym Tracker App
//
//  Created by Ladislav Szolik on 01.01.18.
//  Copyright © 2018 Ladislav Szolik. All rights reserved.
//

import UIKit

struct WorkoutExercise: Codable{
    var name: String
    var exercise: Exercise
    var sets: Int
    var targetReps: String
    var withWeights: Bool
    var targetWeights: String
    
}

protocol WorkoutExercisesDelegate {
    func didWorkoutExercisesChanged(newWorkoutExercises: [WorkoutExercise])
}

class WorkoutExercisesTableViewController: UITableViewController {

    var workoutExercises = [WorkoutExercise]()
    var delgate :WorkoutExercisesDelegate?
    override func viewDidLoad() {
        super.viewDidLoad()

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return workoutExercises.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "WorkoutExerciseCell", for: indexPath)
        let workoutExercise = workoutExercises[indexPath.row]
        cell.textLabel!.text = workoutExercise.name
        
        var targetReps = ""
        if !workoutExercise.targetReps.isEmpty {
            targetReps = ", "+workoutExercise.targetReps + " Reps"
        }
        
        var targetWeight = ""
        if workoutExercise.withWeights && !workoutExercise.targetWeights.isEmpty {
            targetWeight = " with "+workoutExercise.targetWeights+" kg"
        }
        cell.detailTextLabel!.text = "\(workoutExercise.sets) Sets"+targetReps+targetWeight
        return cell
    }
    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            workoutExercises.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
             delgate?.didWorkoutExercisesChanged(newWorkoutExercises: workoutExercises)
        }
    }
    
    @IBAction
    func unwindToWorkoutExercises( segue:UIStoryboardSegue) {
        if segue.identifier == "SaveNewExerciseForWorkout" {
            let newWorkoutExerciseController = segue.source as! NewExerciseForWorkoutTableViewController
            if let newWorkoutExercise = newWorkoutExerciseController.newWorkoutExercise {
                if let selectedIndexPath = tableView.indexPathForSelectedRow {
                    workoutExercises[selectedIndexPath.row] = newWorkoutExercise
                    tableView.reloadRows(at: [selectedIndexPath], with: .automatic)
                } else {
                    workoutExercises.append(newWorkoutExercise)
                    tableView.reloadData()
                }
                delgate?.didWorkoutExercisesChanged(newWorkoutExercises: workoutExercises)
            }
        }
    }

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        return true
    }
 

    
    // MARK: - Navigation

    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ShowWorkoutExercise" {
            if let selectedIndexPath = tableView.indexPathForSelectedRow {
                let navigation = segue.destination as! UINavigationController
                let newExerciseForWorkoutController = navigation.topViewController as! NewExerciseForWorkoutTableViewController
                newExerciseForWorkoutController.newWorkoutExercise = workoutExercises[selectedIndexPath.row]
            }
        }
    }
    

}
