//
//  SaveAndEditWorkoutTableViewController.swift
//  Gym Tracker with Logs
//
//  Created by Ladislav Szolik on 28.10.17.
//  Copyright © 2017 Ladislav Szolik. All rights reserved.
//

import UIKit

class SaveAndEditWorkoutTableViewController: UITableViewController, ExerciseCountDelegate{
    var workout: Workout?
    var listOfMuscleGroupExercises = [MuscleGroupExercises]()
    @IBOutlet weak var leftBarButton: UIBarButtonItem!
    var workoutName: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let loadedData = MuscleGroupExercises.loadMuscleGroupExercises() {
            listOfMuscleGroupExercises = loadedData
        }
        
        let alertController = UIAlertController(title: "New Workout", message: "Enter a name", preferredStyle: .alert)
        alertController.addTextField { (textField: UITextField) in
            textField.placeholder = "Enter name"
        }
        var thisTableView = self
        let cancelButton = UIAlertAction(title: "Cancel", style: .cancel, handler: { action in
           thisTableView.performSegue(withIdentifier: "CancelWorkout", sender: thisTableView )
        })
        alertController.addAction(cancelButton)
        let saveButton = UIAlertAction(title: "Ok", style: .default, handler: {action in
            thisTableView.workoutName = alertController.textFields![0].text!
        })
        alertController.addAction(saveButton)
        present(alertController, animated: true, completion: nil)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
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
        let cell = tableView.dequeueReusableCell(withIdentifier: "ExerciseCountCell", for: indexPath) as! ExerciseCountCell
        let exercise = listOfMuscleGroupExercises[indexPath.section].listOfExercises[indexPath.row]
        if exercise.count > 0 {
            cell.nameLabel!.text = "\(exercise.count)x \(exercise.name)"
        } else {
            cell.nameLabel!.text = exercise.name            
        }
        cell.delegate = self
        return cell
    }
   
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return false
    }
    
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        return false
    }

    func didExerciseCountIncreased(cell: ExerciseCountCell) {
        if let indexPath = tableView.indexPath(for: cell) {
            var exercise =  listOfMuscleGroupExercises[indexPath.section].listOfExercises[indexPath.row]
            exercise.count = Int(cell.stepper.value)
            if exercise.count > 0 {
                cell.nameLabel!.text = "\(exercise.count)x \(exercise.name)"
                exercise.selected = true
            } else {
                cell.nameLabel!.text = exercise.name
                exercise.selected = false
            }
            listOfMuscleGroupExercises[indexPath.section].listOfExercises[indexPath.row] = exercise           
        }
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
         if segue.identifier == "SaveWorkout" {
            var listOfExercisesToSave = [MuscleGroupExercises]()
            
            for muscleGroupExercise in listOfMuscleGroupExercises {
                let filteredList = muscleGroupExercise.listOfExercises.filter({ (exercise) -> Bool in
                    return exercise.selected
                })
                
                if !filteredList.isEmpty {
                    let newMuscleGroup = MuscleGroupExercises(muscleGroup: muscleGroupExercise.muscleGroup, listOfExercises: filteredList)
                    listOfExercisesToSave.append(newMuscleGroup)
                }
            }
            
            workout = Workout(name: "Test", muscleGroupExercises: listOfExercisesToSave)
        } 
    }
    

}
