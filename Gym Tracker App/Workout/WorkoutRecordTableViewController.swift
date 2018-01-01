//
//  WorkoutLogDetailTableViewController.swift
//  Gym Tracker with Logs
//
//  Created by Ladislav Szolik on 22.10.17.
//  Copyright © 2017 Ladislav Szolik. All rights reserved.
//

import UIKit

class WorkoutRecordTableViewController: UITableViewController, WorkoutSetCellDelegate {
    func didWeightChanged(for indexPath: IndexPath, weights: Double) {
        
    }
    
    func didRepetitionChanged(for indexPath: IndexPath, repetition: Int) {
    
    }
    
    
    var workout: Workout?
    var exercises = [Exercise]()
    
    var workoutLog: WorkoutLog?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let workout = workout {
            navigationItem.title = workout.name
        }
       
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return exercises.count
    }


    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
            return exercises[section].name        
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
      
            let cell = tableView.dequeueReusableCell(withIdentifier: "AddNewWorkoutSetCell", for: indexPath)
   
            return cell
      
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
     
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 44.0
    }
    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    

    // MARK: - Private functions


    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
       super.prepare(for: segue, sender: sender)
        
        guard segue.identifier == "SaveWorkoutLogSegue" else {return}
        
        
        
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
