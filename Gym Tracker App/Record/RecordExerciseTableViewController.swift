//
//  RecordExerciseTableViewController.swift
//  Gym Tracker App
//
//  Created by Ladislav Szolik on 01.01.18.
//  Copyright © 2018 Ladislav Szolik. All rights reserved.
//

import UIKit

class RecordExerciseTableViewController: UITableViewController {
    
    var exerciseSets = [ExerciseSet]()
    var exerciseName: String?

    override func viewDidLoad() {
        super.viewDidLoad()
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
        return exerciseSets.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ExerciseSetCell", for: indexPath)

        let exerciseSet = exerciseSets[indexPath.row]
        
        var setText = "\(indexPath.row). "
        if exerciseSet.reps.isEmpty {
            setText = setText + "Not done yet"
        } else {
            setText = exerciseSet.reps+" reps  "
        }

        if !exerciseSet.weights.isEmpty {
            setText = setText + exerciseSet.weights+" kg  "
        }

        cell.textLabel!.text = setText
        return cell
    }


    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }


    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let selectedIndexPath = tableView.indexPathForSelectedRow!
            exerciseSets.remove(at: selectedIndexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    
    @IBAction
    func unwindToRecordExercise( segue: UIStoryboardSegue) {
        if segue.identifier == "DoneExeciseSet" {
        let setController = segue.source as! RecordSetTableViewController
        
        if let newExerciseSet = setController.exerciseSet {
            if let selectedRow = tableView.indexPathForSelectedRow {
                exerciseSets[selectedRow.row] = newExerciseSet
                tableView.reloadRows(at: [selectedRow], with: .automatic)
            } else {
                exerciseSets.append(newExerciseSet)
                tableView.reloadData()
            }
        }
        }
    }
    

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ShowExerciseSet" {
            if let selectedRow = tableView.indexPathForSelectedRow {
                let navigation = segue.destination as! UINavigationController
                let recordSetController = navigation.topViewController as! RecordSetTableViewController
                recordSetController.exerciseSet = exerciseSets[selectedRow.row]
            }
        }
    }
    

}
