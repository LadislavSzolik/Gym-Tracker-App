//
//  WorkoutsTableViewController.swift
//  Gym Tracker with Logs
//
//  Created by Ladislav Szolik on 28.10.17.
//  Copyright © 2017 Ladislav Szolik. All rights reserved.
//

import UIKit

class WorkoutsTableViewController: UITableViewController {
    
    var workouts = [Workout]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let savedWorkouts = Workout.loadWorkouts() {
            workouts = savedWorkouts
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()      
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return workouts.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "WorkoutCell", for: indexPath)
        let workout = workouts[indexPath.row]
        cell.textLabel?.text = workout.name
        
        var exercisesText = ""
        for exercise in workout.listOfWorkoutExercises {
            exercisesText = exercisesText + exercise.name+","
        }
        exercisesText.removeLast()
        cell.detailTextLabel!.text = exercisesText
        return cell
        
    }
    
    @IBAction
    func unwindToWorkouts( segue:UIStoryboardSegue){
        if segue.identifier == "SaveWorkout" {
            let workoutDetailController = segue.source as! WorkoutDetailsTableViewController
            if let newWorkout = workoutDetailController.workout {
                if let selectedIndexPath = tableView.indexPathForSelectedRow {
                    workouts[selectedIndexPath.row] = newWorkout
                    tableView.reloadRows(at: [selectedIndexPath], with: .automatic)
                } else {
                    workouts.append(newWorkout)
                    tableView.reloadData()
                }
                Workout.saveWorkout(workouts)
            }
        }
    }

    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
 
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            workouts.remove(at: indexPath.row)           
            tableView.deleteRows(at: [indexPath], with: .fade)
            Workout.saveWorkout(workouts)
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

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ShowWorkout" {
            if let selectedIndexPath = tableView.indexPathForSelectedRow {
                let navigation = segue.destination as! UINavigationController
                let workoutDetailController = navigation.topViewController as! WorkoutDetailsTableViewController
                workoutDetailController.workout =  workouts[selectedIndexPath.row]
            }
        }
    }
}
