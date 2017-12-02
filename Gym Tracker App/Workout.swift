//
//  Workout.swift
//  Gym Tracker with Logs
//
//  Created by Ladislav Szolik on 22.10.17.
//  Copyright © 2017 Ladislav Szolik. All rights reserved.
//

import Foundation

struct Workout: Codable, Equatable {
    static func ==(lhs: Workout, rhs: Workout) -> Bool {
        return lhs.name == rhs.name
    }
    
    var name: String
    var exercises: [Exercise]
    var muscleGroups: [MuscleGroup]
    
    static func loadSampleWorkouts() -> [Workout] {
        return [ Workout(name: "Shoulder, Triceps",
                         exercises: [Exercise(name:"Seated Barbell Press", muscleGroup:.Shoulder,  workoutSets:[]),
                                     Exercise(name:"Seated Aronld Press", muscleGroup:.Shoulder,  workoutSets:[]),
                                     Exercise(name:"Barbell Front Raise", muscleGroup:.Shoulder,  workoutSets:[])]
            , muscleGroups: [.Shoulder, .Triceps]
            )]
    }
    
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

struct Exercise: Codable  {
    var name: String
    var muscleGroup: MuscleGroup
    var workoutSets: [WorkoutSet]
    
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
    

    static var count: Int { return MuscleGroup.Calves.hashValue+1 }
    static var indexList = [Shoulder, Triceps, Biceps, Chest, Abs, Back, Legs, Hammstrings, Calves]
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


