//
//  Sensor.swift
//  ShopSmartAdmin
//
//  Created by Mansi Modi on 3/15/16.
//  Copyright © 2016 Group5. All rights reserved.
//

import Foundation


struct Sensor {

    var sensorId:String?
    var sensorName:String?
    var sensorMajor:Int?
    var sensorMinor:Int?
    var sensorUUID:String?
    var sensorPower:Int?
    var sensorTag: NSArray?
    var sensorBasicPower: Bool?
    var sensorSmartPower:Bool?
    var sensorLifeExpectancyDays: Int?
    var macName : String?
    
    init(data : NSDictionary){
      
        sensorId = data["id"] as? String
        sensorName = data["name"] as? String
        sensorMajor = data["major"] as? Int
        sensorMinor = (data["minor"] as? Int)
        sensorUUID=(data["uuid"] as? String)
        sensorBasicPower = data["settings"]!["basic_power_mode"] as? Bool
        sensorSmartPower = data["settings"]!["smart_power_mode"] as? Bool
        sensorPower =  data["settings"]!["power"] as? Int
        sensorTag = data["tags"] as? NSArray
        sensorLifeExpectancyDays = data["battery_life_expectancy_in_days"] as?Int
        macName = data["mac"] as? String
        
       
        
        
    }



}