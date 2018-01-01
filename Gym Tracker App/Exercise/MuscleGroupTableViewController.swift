//
//  MuscleGroupTableViewController.swift
//  Gym Tracker with Logs
//
//  Created by Ladislav Szolik on 26.10.17.
//  Copyright © 2017 Ladislav Szolik. All rights reserved.
//

import UIKit


enum MuscleGroup: String, Codable {
    case Shoulder = "Shoulder"
    case Triceps = "Triceps"
    case Biceps = "Biceps"
    case Chest = "Chest"
    case Abs = "Abs"
    case Back = "Back"
    case Legs = "Legs"
    case Hammstrings = "Hammstrings"
    case Calves = "Calves"
    case Forearm = "Forearm"
    
    static var count: Int { return MuscleGroup.Calves.hashValue+1 }
    static var indexList = [Shoulder, Triceps, Biceps, Chest, Abs, Back, Legs, Hammstrings, Calves, Forearm].sorted { (group1, group2) -> Bool in
        return ComparisonResult.orderedAscending == group1.rawValue.localizedStandardCompare(group2.rawValue)
    }
}

class MuscleGroupTableViewController: UITableViewController {

    var chosenMuscleGroup: MuscleGroup?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return MuscleGroup.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MuscleGroupCell", for: indexPath)
        let muscleGroup = MuscleGroup.indexList[indexPath.row]
        cell.textLabel?.text = muscleGroup.rawValue
        
        if let chosenMuscleGroup = chosenMuscleGroup {
            if chosenMuscleGroup == muscleGroup {
                cell.accessoryType = .checkmark
            }
        }
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        chosenMuscleGroup = MuscleGroup.indexList[indexPath.row]
        performSegue(withIdentifier: "UnwindToExerciseDetails", sender: self)
    }

}
