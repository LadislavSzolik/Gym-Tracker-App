//
//  ExercisesTableViewController.swift
//  Gym Tracker with Logs
//
//  Created by Ladislav Szolik on 26.10.17.
//  Copyright © 2017 Ladislav Szolik. All rights reserved.
//

import UIKit

class ExercisesTableViewController: UITableViewController {
    
    var exercises = [Exercise]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let savedExercises = Exercise.loadExercises() {
            exercises = savedExercises
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
        return exercises.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ExerciseCell", for: indexPath)
        let exercise = exercises[indexPath.row]
        cell.textLabel!.text = exercise.name
        cell.detailTextLabel!.text = exercise.muscleGroup.rawValue
        return cell
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

    @IBAction
    func unwindToExerciseList(segue: UIStoryboardSegue) {
        guard segue.identifier == "SaveExerciseSegue" else {return}
        
        let exerciseDetailController = segue.source as! ExerciseDetailTableViewController
        
        if let newExercise = exerciseDetailController.exercise {
            
            if let selectedIndexPath = tableView.indexPathForSelectedRow {
                exercises[selectedIndexPath.row] = newExercise
                tableView.reloadRows(at: [selectedIndexPath], with: .automatic)
            } else {
                let newIndexPath = IndexPath(row: exercises.count, section: 0)
                exercises.append(newExercise)
                tableView.insertRows(at: [newIndexPath], with: .automatic)
            }
            Exercise.saveExercises(exercises)
        }
        
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ShowExerciseDetails" {
        
            if let selectedIndex = tableView.indexPathForSelectedRow {
                let selectedExercise = exercises[selectedIndex.row]
                let navigationController = segue.destination as! UINavigationController
                let exerciseDetailController = navigationController.topViewController as! ExerciseDetailTableViewController
                exerciseDetailController.exercise = selectedExercise
                
            }
        }
    }
    

}
