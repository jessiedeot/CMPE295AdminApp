//
//  Sensor.swift
//  ShopSmartAdmin
//
//  Created by Mansi Modi on 3/15/16.
//  Copyright © 2016 Group5. All rights reserved.
//

import Foundation


struct Sensor {

    var sensorId:Int?
    var sensorName:String?
    var sensorDesc:String?
    var sensorUrl:String
    var sensorPower:String?
    
    
    init(data : NSDictionary){
      
        /* sensorId = data["offer_id"] as? Int
        sensorName = data["offer_desc"] as? String
        sensorDesc = data["offer_title"] as? String
        sensorUrl = (data["offer_end_date"] as? String)
        sensorPower =  data["offer_img_url"] as! String*/
        
        sensorId = 1
        sensorName = "mint"
        sensorDesc = "Sensor Detail"
        sensorUrl = "http://www.megamart.com"
        sensorPower =  "50px"
        
        
    }



}