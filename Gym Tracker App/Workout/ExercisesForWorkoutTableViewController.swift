//
//  ExercisesForWorkoutTableViewController.swift
//  Gym Tracker App
//
//  Created by Ladislav Szolik on 01.01.18.
//  Copyright © 2018 Ladislav Szolik. All rights reserved.
//

import UIKit

class ExercisesForWorkoutTableViewController: UITableViewController {
    
    var listOfExercises = [Exercise]()
    
    var chosenExercise: Exercise?

    override func viewDidLoad() {
        super.viewDidLoad()
        if let loadedData = Exercise.loadExercises() {
            listOfExercises = loadedData
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
        
        if let chosenExercise = chosenExercise {
            if chosenExercise.name == exercise.name {
                cell.accessoryType = .checkmark
            } else
            {
                cell.accessoryType = .none
            }
        }
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        chosenExercise = listOfExercises[indexPath.row]
        performSegue(withIdentifier: "UnwindToNewExerciseForWorkout", sender: self)
    }


}
