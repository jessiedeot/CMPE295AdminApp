//
//  ManageSensorsViewController.swift
//  ShopSmartAdmin
//
//  Created by Jessie Deot on 3/5/16.
//  Copyright © 2016 Group5. All rights reserved.
//


import UIKit
import Alamofire


class ManageSensorsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var sensorArray=[Sensor]()
    
    
    
    @IBOutlet var tblView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        //Add the pan gesture to the view.
        
        self.tblView.delegate=self
        self.tblView.dataSource=self
        
        
        loadData()
   
    
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // Step5
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sensorArray.count
    }
    
    
    //Step6
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let sensor = self.tblView.dequeueReusableCellWithIdentifier("sensor_cell", forIndexPath: indexPath) as! SensorTableViewCell
        
        //Step 8
        
        // this needs to be modified
        sensor.mylabel.text = sensorArray[indexPath.row].sensorName
        
        
        return sensor
        
        
    }
    
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {}
    
    
    func loadData()
    {
        
        let headers = ["Accept":"application/json"]
        
        Alamofire.request(.GET, "https://cloud.estimote.com/v1/beacons", parameters: nil,  encoding: .JSON , headers:headers).authenticate(user: "cmpe297-group5-shopsmart-c0f", password: "abb0580238d61d0abc69bf8e6204cfcb")
            .responseJSON {  response in
              
                /*switch response.result {
               case .Success(let JSON):
                    self.populateData(JSON as! NSArray)
                    
                    
                case .Failure(let error):
                    print("Request failed with error: \(error)")*/
                    
                    print(response)
                    
                
        }
    }
    
    
    func populateData(jsonData: NSArray){
        
        if(jsonData.count>0){
            
            // let jsonArray = response.result.value as! NSMutableArray
            for item in jsonData{
                
               // self.sensorArray.append(item[0] as! String)
                
                
            }
            
            dispatch_async(dispatch_get_main_queue()) {
                
                self.tblView.reloadData()
                
                
            };
            
            
        }
        
}
    

    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        
        
        
        var numOfSection: NSInteger = 0
        
        if sensorArray.count > 0 {
            
            self.tblView.backgroundView = nil
            numOfSection = 1
            
            
        } else {
            
            var noDataLabel: UILabel = UILabel(frame: CGRectMake(0, 0, self.tblView.bounds.size.width, self.tblView.bounds.size.height))
            noDataLabel.text = "No Data to Display"
            noDataLabel.textColor = UIColor(red: 22.0/255.0, green: 106.0/255.0, blue: 176.0/255.0, alpha: 1.0)
            noDataLabel.textAlignment = NSTextAlignment.Center
            self.tblView.backgroundView = noDataLabel
            
        }
        return numOfSection
        
        
    }
    
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if(segue.identifier == "sensor_detail"){
            let indexPath = self.tblView.indexPathForCell(sender as! SensorTableViewCell)
            let sensor = self.sensorArray[indexPath!.row]
            
            let dvc = segue.destinationViewController as! SensorDetailViewController
            
            
         //   dvc.categoryName = category
        }
    }
    


    
    
}