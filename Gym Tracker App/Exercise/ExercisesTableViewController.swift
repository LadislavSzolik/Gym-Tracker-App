//
//  ExercisesTableViewController.swift
//  Gym Tracker with Logs
//
//  Created by Ladislav Szolik on 26.10.17.
//  Copyright © 2017 Ladislav Szolik. All rights reserved.
//

import UIKit

struct Exercise: Codable, Equatable  {
    var name: String
    var muscleGroup: MuscleGroup
    
    static func ==(lhs: Exercise, rhs: Exercise) -> Bool {
        return lhs.name == rhs.name
    }
    
    static func <(lhs: Exercise, rhs: Exercise) -> Bool {
        return ComparisonResult.orderedAscending == lhs.name.localizedStandardCompare(rhs.name) 
    }
    
    static let DocumentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
    static let SavedExerciseURL = DocumentsDirectory.appendingPathComponent("exercise").appendingPathExtension("plist")
    
    static func loadExercises() -> [Exercise]? {
        guard let codedExercise = try? Data(contentsOf: SavedExerciseURL) else {return nil}
        let propertyListDecoder = PropertyListDecoder()
        return try? propertyListDecoder.decode(Array<Exercise>.self, from: codedExercise)
    }
    
    static func saveExercises(_ exercises :[Exercise]) {
        let propertyListEncoder = PropertyListEncoder()
        let codedExercise = try? propertyListEncoder.encode(exercises)
        try? codedExercise?.write(to: SavedExerciseURL, options: .noFileProtection)
    }
}


class ExercisesTableViewController: UITableViewController {
    
    var listOfExercises = [Exercise]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let loadedData = Exercise.loadExercises() {
            listOfExercises = loadedData
        } else {
            // Temporary test data
            let exercise1 = Exercise(name: "Pushups", muscleGroup: .Chest )
            let exercise2 = Exercise(name: "Curl Row", muscleGroup: .Hammstrings)
            let exercise3 = Exercise(name: "Seated Shoulder Press", muscleGroup: .Shoulder)
            let exercise4 = Exercise(name: "Arnold Press", muscleGroup: .Shoulder)
            
            listOfExercises.append(exercise1)
            listOfExercises.append(exercise2)
            listOfExercises.append(exercise3)
            listOfExercises.append(exercise4)
            listOfExercises.sort(by: <)
            Exercise.saveExercises(listOfExercises)
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
        return listOfExercises.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ExerciseCell", for: indexPath)
        let exercise = listOfExercises[indexPath.row]
        cell.textLabel!.text = exercise.name
        cell.detailTextLabel!.text = exercise.muscleGroup.rawValue
        return cell
    }
    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
 
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            listOfExercises.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
            Exercise.saveExercises(listOfExercises)
        }
    }
    
    @IBAction
    func unwindToExerciseList(segue: UIStoryboardSegue) {
        guard segue.identifier == "SaveExerciseSegue" else {return}
        
        let exerciseDetailController = segue.source as! ExerciseDetailTableViewController
        
        if let newExercise = exerciseDetailController.exercise {
            if let selectedRow = tableView.indexPathForSelectedRow {
                listOfExercises[selectedRow.row] = newExercise
                tableView.reloadRows(at: [selectedRow], with: .automatic)
            } else {
                listOfExercises.append(newExercise)
                listOfExercises.sort(by: <)
                tableView.reloadData()
            }
        }
        Exercise.saveExercises(listOfExercises)
       
    }
    
    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ShowExerciseDetails" {
            if let selectedIndex = tableView.indexPathForSelectedRow {
                let selectedExercise = listOfExercises[selectedIndex.row]
                let navigationController = segue.destination as! UINavigationController
                let exerciseDetailController = navigationController.topViewController as! ExerciseDetailTableViewController
                exerciseDetailController.exercise = selectedExercise
            }
        }
    }
    

}
