//
//  WorkoutLogDetailTableViewController.swift
//  Gym Tracker with Logs
//
//  Created by Ladislav Szolik on 22.10.17.
//  Copyright © 2017 Ladislav Szolik. All rights reserved.
//

import UIKit

class WorkoutRecordTableViewController: UITableViewController, WorkoutSetCellDelegate {
    
    var workout: Workout?
    var exercises = [Exercise]()
    
    var workoutLog: WorkoutLog?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let workout = workout {
            navigationItem.title = workout.name
            exercises = workout.exercises
        }
       
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return exercises.count
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return exercises[section].workoutSets.count + 1
    }

    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
            return exercises[section].name        
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == exercises[indexPath.section].workoutSets.count {
            let cell = tableView.dequeueReusableCell(withIdentifier: "AddNewWorkoutSetCell", for: indexPath)
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "WorkoutSetCell", for: indexPath) as! WorkoutSetTableViewCell
            let set = exercises[indexPath.section].workoutSets[indexPath.row]
            cell.indexLabel.text = "\(indexPath.row + 1)."
            cell.repetition = set.repetition
            cell.weights = set.weight
            cell.indexPath = indexPath
            
            if set.weight != 0.0 {
                cell.WeightsTextField.text = "\(String(describing: set.weight))"
            }
            if set.repetition != 0 {
                cell.repetitionTextField.text = "\(set.repetition)"
            }
            
            cell.delegate = self
            return cell
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        if indexPath.row == exercises[indexPath.section].workoutSets.count {
            exercises[indexPath.section].workoutSets.append(WorkoutSet(index: indexPath.row, repetition: 0, weight: 0.0 ))
            tableView.insertRows(at: [indexPath], with: .automatic)
            tableView.beginUpdates()
            tableView.endUpdates()
  
        }
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 44.0
    }
    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            exercises[indexPath.section].workoutSets.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    
    // MARK: - Set Cell Delegate
    
    func didWeightChanged(for indexPath: IndexPath, weights: Double) {
         exercises[indexPath.section].workoutSets[indexPath.row].weight = weights
    }
    
    func didRepetitionChanged(for indexPath: IndexPath, repetition: Int) {
         exercises[indexPath.section].workoutSets[indexPath.row].repetition = repetition
    }
    
    // MARK: - Private functions


    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
       super.prepare(for: segue, sender: sender)
        
        guard segue.identifier == "SaveWorkoutLogSegue" else {return}
        
        workout!.exercises = exercises
        
        if let allWorkouts = Workout.loadWorkouts() {
            var workouts = allWorkouts
            if let index = allWorkouts.index(of: workout!) {
                workouts[index] = workout!
            } else {
                workouts.append(workout!)
            }
            Workout.saveWorkout(workouts)
        }
        
        workoutLog = WorkoutLog(workout: workout!, dateOfRecord: Date())
    }
    

}
