//
//  FPViewController.swift
//  ShopSmartAdmin
//
//  Created by thinatar on 3/26/16.
//  Copyright © 2016 Group5. All rights reserved.
//

import UIKit
import Alamofire

class FPViewController: UIViewController,UITableViewDataSource, UITableViewDelegate {
    
    
    @IBOutlet var tblView: UITableView!
    
  //  var fpItemArray=[String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        self.tblView.delegate=self
        self.tblView.dataSource=self

        loadData()

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
  //      return fpItemArray.count
        return 1
    }

    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let sensor = self.tblView.dequeueReusableCellWithIdentifier("sensor_cell", forIndexPath: indexPath) as! SensorTableViewCell
        
   //     fp.mylabel.text = fpItemArray[indexPath.row].fpName
        
        
        return sensor
    }
    
  func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath){
    }
    
    func loadData()
    {
        
        //   authenticate(user: "cmpe297-group5-shopsmart-c0f", password: "abb0580238d61d0abc69bf8e6204cfcb")
        
        
        
        let user = "cmpe297-group5-shopsmart-c0f"
        let password = "abb0580238d61d0abc69bf8e6204cfcb"
        
        let credentialData = "\(user):\(password)".dataUsingEncoding(NSUTF8StringEncoding)!
        let base64Credentials = credentialData.base64EncodedStringWithOptions([])
        
        let headers = ["Authorization": "Basic \(base64Credentials)", "Accept":"application/json"]
        
        Alamofire.request(.GET, "https://cloud.estimote.com/v1/beacons", parameters: nil,  encoding: .JSON , headers:headers).responseJSON{  response in
            
            switch response.result {
            case .Success(let JSON):
                print(response)
      //          self.populateData(JSON as! NSArray)
                
                
            case .Failure(let error):
                print("Request failed with error: \(error)")
                
            }
            
            
        }
    }

    
    
    
    
    
}
