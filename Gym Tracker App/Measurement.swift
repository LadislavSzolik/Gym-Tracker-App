//
//  Measurement.swift
//  Gym Tracker App
//
//  Created by Ladislav Szolik on 09.11.17.
//  Copyright © 2017 Ladislav Szolik. All rights reserved.
//

import Foundation

struct BodyMeasurement {
    var measure: [Date: Double]
}

enum BodyPart: String, Codable {
    case Biceps = "Biceps"
    case Chest = "Chest"
    case Hips = "Hips"
    case Tight = "Tight"
    case Waist = "Waist"
    case Weight = "Weight"
    
    static var count: Int { return BodyPart.Weight.hashValue+1 }
    static var indexList = [Biceps, Chest, Hips, Tight, Waist, Weight]
    
}


