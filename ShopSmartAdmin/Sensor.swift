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
   // var sensorDesc:String?
   // var sensorUrl:String?
    var sensorPower:Int?
    
    
    init(data : NSDictionary){
      
        sensorId = data["id"] as? String
        sensorName = data["name"] as? String
       // sensorDesc = data["major"] as? String
       // sensorUrl = (data["minor"] as? String)
        sensorPower =  data["settings"]!["power"] as? Int
        
       
        
        
    }



}