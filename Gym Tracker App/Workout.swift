//
//  Workout.swift
//  Gym Tracker with Logs
//
//  Created by Ladislav Szolik on 22.10.17.
//  Copyright © 2017 Ladislav Szolik. All rights reserved.
//

import Foundation

struct Workout: Codable, Equatable {
    var name: String
    var muscleGroupExercises: [MuscleGroupExercises]
    
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

struct Exercise: Codable, Equatable  {
    var name: String
    var muscleGroup: MuscleGroup
    var workoutSets: [WorkoutSet]
    var selected: Bool = false
    var count: Int = 0
    
    static func ==(lhs: Exercise, rhs: Exercise) -> Bool {
        return lhs.name == rhs.name
    }
    
    static func <(lhs: Exercise, rhs: Exercise) -> Bool {
        return lhs.name < rhs.name
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

struct WorkoutSet: Codable  {
    var index: Int
    var repetition: Int
    var weight: Double?
}



struct MuscleGroupExercises: Codable, Equatable {
   
    
    var muscleGroup : MuscleGroup
    var listOfExercises: [Exercise]
    
    static func ==(lhs: MuscleGroupExercises, rhs: MuscleGroupExercises) -> Bool {
        return lhs.muscleGroup.rawValue == rhs.muscleGroup.rawValue
    }
    
    static func <(lhs: MuscleGroupExercises, rhs: MuscleGroupExercises) -> Bool {
        return lhs.muscleGroup.rawValue < rhs.muscleGroup.rawValue
    }
    
    static let DocumentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
    static let SavedMuscleGroupExerciseURL = DocumentsDirectory.appendingPathComponent("muscleGroupExercises").appendingPathExtension("plist")
    
    static func loadMuscleGroupExercises() -> [MuscleGroupExercises]? {
        guard let codedMuscleGroupExercise = try? Data(contentsOf: SavedMuscleGroupExerciseURL) else {return nil}
        let propertyListDecoder = PropertyListDecoder()
        return try? propertyListDecoder.decode(Array<MuscleGroupExercises>.self, from: codedMuscleGroupExercise)
    }
    
    static func saveMuscleGroupExercises(_ muscleGroupexercises :[MuscleGroupExercises]) {
        let propertyListEncoder = PropertyListEncoder()
        let codedMuscleGroupExercise = try? propertyListEncoder.encode(muscleGroupexercises)
        try? codedMuscleGroupExercise?.write(to: SavedMuscleGroupExerciseURL, options: .noFileProtection)
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


