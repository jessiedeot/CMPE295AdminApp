//
//  SensorDetailViewController.swift
//  ShopSmartAdmin
//
//  Created by Mansi Modi on 3/15/16.
//  Copyright © 2016 Group5. All rights reserved.
//

import UIKit
import Alamofire

class SensorDetailViewController: UIViewController {
    
    var sensor : Sensor!
    
    @IBOutlet var name: UILabel!
    @IBOutlet var power: UITextField!
    @IBOutlet var uuid: UILabel!
    @IBOutlet var major: UILabel!
    @IBOutlet var minor: UILabel!
    @IBOutlet var tags: UILabel!
    @IBOutlet var basicPwr: UITextField!
    @IBOutlet var smartPwr: UITextField!
    
   
    @IBOutlet var lifeDays: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        populateData()
        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

   func populateData(){
    
    if(sensor != nil) {
    
    name.text = sensor.sensorName
    uuid.text = sensor.sensorUUID
    major.text = String(sensor.sensorMajor!)
    minor.text = String(sensor.sensorMinor!)
    power.text = String(sensor.sensorPower!)
    smartPwr.text = String(sensor.sensorSmartPower!)
    basicPwr.text = String (sensor.sensorBasicPower!)
    lifeDays.text = String(sensor.sensorLifeExpectancyDays!)
        
        var tagText : NSMutableString = ""
        
        for tag in sensor.sensorTag!{
        
            tagText.appendString(String(tag))
        
        }
        
        tags.text = String(tagText)
    
        
    }
    
    }
   
    @IBAction func updateSettings(sender: UIButton) {
        
        
                 
            
            var url = "https://cloud.estimote.com/v1/beacons/" + sensor.macName!
            url = url + "/pending_settings"
            
            print(url)
            
            
            var params = [String: AnyObject]()
            
            params = ["power" : Int(power.text!)! , "basic_power_mode" : NSString(string: basicPwr.text!).boolValue , "smart_power_mode" : NSString(string: smartPwr.text!).boolValue ]
        
        
        
        
        let user = "cmpe297-group5-shopsmart-c0f"
        let password = "abb0580238d61d0abc69bf8e6204cfcb"
        
        let credentialData = "\(user):\(password)".dataUsingEncoding(NSUTF8StringEncoding)!
        let base64Credentials = credentialData.base64EncodedStringWithOptions([])
        
        let headers = ["Authorization": "Basic \(base64Credentials)", "Accept":"application/json"]
        
        Alamofire.request(.POST, url, parameters: params,  encoding: .JSON , headers:headers).responseJSON{  response in
            
            switch response.result {
            case .Success(let JSON):
                print(response)
                //self.populateData(JSON as! NSArray)
                
                
            case .Failure(let error):
                print("Request failed with error: \(error)")
                
            }
            
            
        }

        
        
        }

    
    
   }
