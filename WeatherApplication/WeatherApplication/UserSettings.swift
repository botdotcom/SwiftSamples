//
//  UserSettings.swift
//  WeatherApplication
//
//  Created by Mac on 11/2/17.
//  Copyright © 2017 Mac. All rights reserved.
//

import Foundation

class UserSettings {
    //storing and retrieval of unit settings by users
    static func setUnitOfTemperature(unitType: Int) {
        switch unitType {
        case 0:
            UserDefaults.standard.set("C", forKey: "Temperature")
            print("Temperature is set to degree Celsius")
        case 1:
            UserDefaults.standard.set("F", forKey: "Temperature")
            print("Temperature is set to degree Fahreinheit")
        default:
            break
        }
    }
    
    static func getUnitOfTemperature() -> Int {
        let unit = UserDefaults.standard.object(forKey: "Temperature") as? String
        if unit == "C" {
            return 0
        }
        else {
            return 1
        }
    }
    
    static func setUnitOfPressure(unitType: Int) {
        switch unitType {
        case 0:
            UserDefaults.standard.set("hPa", forKey: "Pressure")
            print("Pressure is set to hectoPascals")
        case 1:
            UserDefaults.standard.set("bar", forKey: "Pressure")
            print("Pressure is set to bar")
        default:
            break
        }
    }
    
    static func getUnitOfPressure() -> Int {
        let unit = UserDefaults.standard.object(forKey: "Pressure") as? String
        if unit == "hPa" {
            return 0
        }
        else {
            return 1
        }
    }
}
