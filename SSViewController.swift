//
//  SSViewController.swift
//  ShopSmartAdmin
//
//  Created by thinatar on 3/28/16.
//  Copyright © 2016 Group5. All rights reserved.
//

import UIKit
import Alamofire

class SSViewController: UIViewController,UITableViewDataSource, UITableViewDelegate {

       var shelfArray=[String]()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        loadData()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // Step5
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return shelfArray.count
    }
    
    
    // Step6
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let myShelfToReturn = tableView.dequeueReusableCellWithIdentifier("myShelf", forIndexPath: indexPath) as! SSTableViewCell
        
        myShelfToReturn.shelfLabel.text = shelfArray[indexPath.row]
        
        return myShelfToReturn
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        
        var numOfSection: NSInteger = 0
        
        if shelfArray.count > 0 {
            
            tableView.backgroundView = nil
            numOfSection = 1
            
            
        } else
        {
            
            let noDataLabel: UILabel = UILabel(frame: CGRectMake(0, 0, tableView.bounds.size.width,tableView.bounds.size.height))
        
            noDataLabel.text = "No Data to Display"
            noDataLabel.textColor = UIColor(red: 22.0/255.0, green: 106.0/255.0, blue: 176.0/255.0, alpha: 1.0)
            noDataLabel.textAlignment = NSTextAlignment.Center
            tableView.backgroundView = noDataLabel
            
        }
        return numOfSection
        
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
            }
    
    
    
    
    func loadData() {
    
    let url="http://127.0.0.1:8000/smartretailapp/api/shelfsugglist/?"
    
    let modUrl = url.stringByAddingPercentEscapesUsingEncoding(NSUTF8StringEncoding)
    
    Alamofire.request(.GET, modUrl!)
    .responseJSON   {
            response in
                switch response.result {
                            case .Success(let JSON):
                            self.populateData(JSON as! NSArray)
    
                            case .Failure(let error):
                            print("Request failed with error: \(error)")
    
                                        }
                    }
    }
    
   
    func populateData(jsonData: NSArray){
        
        if(jsonData.count>0){
            
            // let jsonArray = response.result.value as! NSMutableArray
            for item in jsonData{
                
             
                shelfArray.append(item[0] as! String)
                
                
                
            }
            
            dispatch_async(dispatch_get_main_queue()) {
                
                //self.categoryTblView.reloadData()
                //self.tableView.reloadData()
                
                
                
            };
            
            
        }
        
        
    }
    
    
    
    
    
}
