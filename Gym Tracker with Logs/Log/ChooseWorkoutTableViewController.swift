//
//  ChooseWorkoutTableViewController.swift
//  Gym Tracker with Logs
//
//  Created by Ladislav Szolik on 22.10.17.
//  Copyright © 2017 Ladislav Szolik. All rights reserved.
//

import UIKit

class ChooseWorkoutTableViewController: UITableViewController {
    
    var workouts = [Workout]()
    
    var selectedWorkout: Workout?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let loadedWorkouts = Workout.loadWorkouts() {
            workouts = loadedWorkouts
        } else {
            workouts = Workout.loadSampleWorkouts()
            Workout.saveWorkout(workouts)
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
        
        return cell
    }
 

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
       
    }

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let navigation = segue.destination as? UINavigationController, let workoutLogController = navigation.topViewController as? WorkoutLogDetailTableViewController  else {return}
        
        if let selectedIndex = tableView.indexPathForSelectedRow {
            selectedWorkout = workouts[selectedIndex.row]
            workoutLogController.workout = selectedWorkout
        }
        
        
    }
    

}
