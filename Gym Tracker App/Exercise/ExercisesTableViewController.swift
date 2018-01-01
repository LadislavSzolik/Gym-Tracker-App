//
//  ExercisesTableViewController.swift
//  Gym Tracker with Logs
//
//  Created by Ladislav Szolik on 26.10.17.
//  Copyright © 2017 Ladislav Szolik. All rights reserved.
//

import UIKit

class ExercisesTableViewController: UITableViewController {
    
    var listOfMuscleGroupExercises = [MuscleGroupExercises]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let loadedData = MuscleGroupExercises.loadMuscleGroupExercises() {
            listOfMuscleGroupExercises = loadedData
        } else {
            // Temporary test data
            let exercise1 = Exercise(name: "Pushups", muscleGroup: .Chest, workoutSets: [], selected: false, count: 0)
            let exercise2 = Exercise(name: "Curl Row", muscleGroup: .Hammstrings, workoutSets: [], selected: false, count: 0)
            let exercise3 = Exercise(name: "Seated Shoulder Press", muscleGroup: .Shoulder, workoutSets: [], selected: false, count: 0)
            let exercise4 = Exercise(name: "Arnold Press", muscleGroup: .Shoulder, workoutSets: [], selected: false, count: 0)
            
            let muscleGroupExercises1 = MuscleGroupExercises(muscleGroup: .Chest, listOfExercises: [exercise1])
            let muscleGroupExercises2 = MuscleGroupExercises(muscleGroup: .Hammstrings, listOfExercises: [exercise2])
            let muscleGroupExercises3 = MuscleGroupExercises(muscleGroup: .Shoulder, listOfExercises: [exercise3, exercise4])
            listOfMuscleGroupExercises.append(muscleGroupExercises1)
            listOfMuscleGroupExercises.append(muscleGroupExercises2)
            listOfMuscleGroupExercises.append(muscleGroupExercises3)
            listOfMuscleGroupExercises.sort(by: <)
            MuscleGroupExercises.saveMuscleGroupExercises(listOfMuscleGroupExercises)
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
        return listOfMuscleGroupExercises.count
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return listOfMuscleGroupExercises[section].muscleGroup.rawValue
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listOfMuscleGroupExercises[section].listOfExercises.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ExerciseCell", for: indexPath)
        let exercise = listOfMuscleGroupExercises[indexPath.section].listOfExercises[indexPath.row]
        cell.textLabel!.text = exercise.name        
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
            
            if listOfMuscleGroupExercises.isEmpty {
                let newMuscleGroupExercises = MuscleGroupExercises(muscleGroup: newExercise.muscleGroup, listOfExercises: [newExercise])
                listOfMuscleGroupExercises.append(newMuscleGroupExercises)
            } else {
            
                // TODO: Add update exercise
                var foundMuscleGroup = false
                for i in 0...listOfMuscleGroupExercises.count-1 {
                    if listOfMuscleGroupExercises[i].muscleGroup == newExercise.muscleGroup {
                        listOfMuscleGroupExercises[i].listOfExercises.append(newExercise)
                        listOfMuscleGroupExercises[i].listOfExercises.sort(by: <)
                        foundMuscleGroup = true
                        break
                    }
                }
                
                if !foundMuscleGroup {
                    let newMuscleGroupExercises = MuscleGroupExercises(muscleGroup: newExercise.muscleGroup, listOfExercises: [newExercise])
                    listOfMuscleGroupExercises.append(newMuscleGroupExercises)
                    listOfMuscleGroupExercises.sort(by: <)
                }
            }
            MuscleGroupExercises.saveMuscleGroupExercises(listOfMuscleGroupExercises)
            tableView.reloadData()
        }
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ShowExerciseDetails" {
            if let selectedIndex = tableView.indexPathForSelectedRow {
                let selectedExercise = listOfMuscleGroupExercises[selectedIndex.section].listOfExercises[selectedIndex.row]
                let navigationController = segue.destination as! UINavigationController
                let exerciseDetailController = navigationController.topViewController as! ExerciseDetailTableViewController
                exerciseDetailController.exercise = selectedExercise
                
            }
        }
    }
    

}
