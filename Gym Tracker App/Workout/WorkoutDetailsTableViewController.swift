//
//  WorkoutDetailsTableViewController.swift
//  Gym Tracker App
//
//  Created by Ladislav Szolik on 01.01.18.
//  Copyright © 2018 Ladislav Szolik. All rights reserved.
//

import UIKit

struct Workout: Codable, Equatable {
    var name: String
    var listOfWorkoutExercises: [WorkoutExercise]
    
    static let DocumentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
    static let SavedWorkoutURL = DocumentsDirectory.appendingPathComponent("workout").appendingPathExtension("plist")
    
    static func loadWorkouts() -> [Workout]? {
        guard let codedWorkouts = try? Data(contentsOf: SavedWorkoutURL) else {return nil}
        let propertyListDecoder = PropertyListDecoder()
        return try? propertyListDecoder.decode(Array<Workout>.self, from: codedWorkouts)
    }
    
    static func saveWorkout(_ workouts:[Workout]) {
        let propertyListEncoder = PropertyListEncoder()
        let codedWorkouts = try? propertyListEncoder.encode(workouts)
        try? codedWorkouts?.write(to: SavedWorkoutURL, options: .noFileProtection)
    }
    static func ==(lhs: Workout, rhs: Workout) -> Bool {
        return lhs.name == rhs.name
    }
}

class WorkoutDetailsTableViewController: UITableViewController, WorkoutExercisesDelegate {
    
    @IBOutlet weak var numberOfExercises: UILabel!
    @IBOutlet weak var workoutNameTextField: UITextField!
    @IBOutlet weak var recordButton: UIBarButtonItem!
    @IBOutlet weak var saveButton: UIBarButtonItem!
    var workout: Workout?
    var workoutExercises = [WorkoutExercise]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        recordButton.isEnabled = false
        if workout != nil {
            workoutNameTextField!.text = workout!.name
            recordButton.isEnabled = true
            workoutExercises = workout!.listOfWorkoutExercises
        }
        
        updateSaveButton()
        updateNumberOfExercises()
    }
    
    func updateSaveButton() {
        saveButton.isEnabled = false
        if let text = workoutNameTextField!.text {
            if !text.isEmpty && workoutExercises.count > 0 {
                saveButton.isEnabled = true
            }
        }
    }
    
    func updateNumberOfExercises() {
        numberOfExercises!.text = "\(workoutExercises.count)"
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    @IBAction func nameValueChanged(_ sender: UITextField) {
        updateSaveButton()
    }
    

    @IBAction func donePressedForName(_ sender: UITextField) {
        sender.resignFirstResponder()
    }
    
    func didWorkoutExercisesChanged(newWorkoutExercises: [WorkoutExercise]) {
        workoutExercises = newWorkoutExercises
        updateSaveButton()
        updateNumberOfExercises()
    }

    
    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ShowWorkoutExercises" {
            let workoutExercisesController = segue.destination as! WorkoutExercisesTableViewController
            workoutExercisesController.delgate = self
            workoutExercisesController.workoutExercises = workoutExercises
        } else if segue.identifier == "SaveWorkout" {
            workout = Workout(name: workoutNameTextField!.text!, listOfWorkoutExercises: workoutExercises)
        }
    }
 

}
