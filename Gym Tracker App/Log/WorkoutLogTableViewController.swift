//
//  WorkoutLogTableViewController.swift
//  Gym Tracker with Logs
//
//  Created by Ladislav Szolik on 22.10.17.
//  Copyright © 2017 Ladislav Szolik. All rights reserved.
//

import UIKit

class WorkoutLogTableViewController: UITableViewController {
    
    var workoutLogs = [WorkoutLog] ()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let loadedWorkoutLogs = WorkoutLog.loadWorkoutLogs() {
            workoutLogs = loadedWorkoutLogs
        }
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
        return workoutLogs.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "WorkoutLogCell", for: indexPath)

        let workoutLog = workoutLogs[indexPath.row]

        cell.textLabel!.text = workoutLog.workout.name
        cell.detailTextLabel!.text = WorkoutLog.dateOfRecordFormatter.string(from: workoutLog.dateOfRecord)
        return cell
    }
    
    @IBAction
    func unwindToWorkoutLog(segue: UIStoryboardSegue) {        
        guard segue.identifier == "SaveWorkoutLogSegue" else { return}
        
        let workoutRecordController = segue.source as! WorkoutRecordTableViewController
        
        if let newWorkoutLog = workoutRecordController.workoutLog {
            if let selectedRow = tableView.indexPathForSelectedRow {
                workoutLogs[selectedRow.row] = newWorkoutLog
                tableView.reloadRows(at: [selectedRow], with: .none)
            } else {
                let newIndexPath = IndexPath(row: workoutLogs.count, section: 0)
                workoutLogs.append(newWorkoutLog)
                tableView.insertRows(at: [newIndexPath], with: .automatic)
            }
            WorkoutLog.saveWorkoutLogs(workoutLogs)
        }
        
    }

   
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }

    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            workoutLogs.remove(at: indexPath.row)
            WorkoutLog.saveWorkoutLogs(workoutLogs)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ShowWorkoutLog"{
            let workoutLogDetial = segue.destination as! WorkoutLogDetailTableViewController
            let selectedIndex = tableView.indexPathForSelectedRow!
            let selectedWorkoutLog = workoutLogs[selectedIndex.row]
            workoutLogDetial.workout = selectedWorkoutLog.workout
            
        }
    }
    

}
