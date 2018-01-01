//
//  ShowWorkoutTableViewController.swift
//  Gym Tracker App
//
//  Created by Ladislav Szolik on 03.12.17.
//  Copyright © 2017 Ladislav Szolik. All rights reserved.
//

import UIKit

class ShowWorkoutTableViewController: UITableViewController {

    var workout: Workout?
    var listOfMuscleGroupExercises = [Exercise]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if let workout = workout {
            listOfMuscleGroupExercises = workout.muscleGroupExercises
        }

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
        //let exercise = listOfMuscleGroupExercises[indexPath.section].listOfExercises[indexPath.row]
      //  cell.textLabel!.text = "\(exercise.count)x \(exercise.name)"
        return cell
    }
    

    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return false
    }
   

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
