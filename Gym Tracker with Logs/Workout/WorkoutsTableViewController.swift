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
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
    
    
    @IBAction
    func unwindToWorkouts( segue:UIStoryboardSegue){
        if segue.identifier == "SaveWorkout" {
            let workoutDetailController = segue.source as! WorkoutDetailTableViewController
            if let newWorkout = workoutDetailController.workout {
                if let selectedIndexPath = tableView.indexPathForSelectedRow {
                    workouts[selectedIndexPath.row] = newWorkout
                    tableView.reloadRows(at: [selectedIndexPath], with: .automatic)
                } else {
                    let newIndexPath = IndexPath(row: workouts.count, section: 0)
                    workouts.append(newWorkout)
                    tableView.insertRows(at: [newIndexPath], with: .automatic)
                }
                Workout.saveWorkout(workouts)
            }
        }
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

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
        if segue.identifier == "ShowWorkoutDetail" {
            let navigation = segue.destination as! UINavigationController
            let workoutDetailController = navigation.topViewController as! WorkoutDetailTableViewController
            if let selectedIndex = tableView.indexPathForSelectedRow {
                let selectedWorkout = workouts[selectedIndex.row]
                workoutDetailController.workout = selectedWorkout
            }
        }
    }
    

}
