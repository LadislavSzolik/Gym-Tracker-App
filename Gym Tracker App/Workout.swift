//
//  Workout.swift
//  Gym Tracker with Logs
//
//  Created by Ladislav Szolik on 22.10.17.
//  Copyright © 2017 Ladislav Szolik. All rights reserved.
//

import Foundation



struct WorkoutLog:Codable {
    var workout: Workout
    var dateOfRecord: Date
    
    static let dateOfRecordFormatter:DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        formatter.timeStyle = .short
        return formatter
    }()
    
    static let DocumentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
    static let SavedWorkoutLogURL = DocumentsDirectory.appendingPathComponent("workoutLog").appendingPathExtension("plist")
    
    static func loadWorkoutLogs() -> [WorkoutLog]? {
        guard let codedWorkoutLogs = try? Data(contentsOf: SavedWorkoutLogURL) else {return nil}
        let propertyListDecoder = PropertyListDecoder()
        return try? propertyListDecoder.decode(Array<WorkoutLog>.self, from: codedWorkoutLogs)
    }
    
    static func saveWorkoutLogs(_ workoutLogs:[WorkoutLog]) {
        let propertyListEncoder = PropertyListEncoder()
        let codedWorkoutLogs = try? propertyListEncoder.encode(workoutLogs)
        try? codedWorkoutLogs?.write(to: SavedWorkoutLogURL, options: .noFileProtection)
    }
}








/*
enum TypeOfMeasurement: String, Codable {
    case Time = "Time"
    case TimeAndWeight = "TimeAndWeight"
    case Repetition = "Repetition"
    case RepetitionAndWeight = "RepetitionAndWeight"
    
    static var count: Int { return TypeOfMeasurement.RepetitionAndWeight.hashValue+1}
    static var indexList = [Time, TimeAndWeight, Repetition, RepetitionAndWeight]
} */


