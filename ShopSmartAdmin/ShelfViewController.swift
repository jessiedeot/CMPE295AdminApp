//
//  ShelfViewController.swift
//  ShopSmartAdmin
//
//  Created by thinatar on 3/29/16.
//  Copyright © 2016 Group5. All rights reserved.
//

import UIKit
import Alamofire


class ShelfViewController: UIViewController,UITableViewDataSource, UITableViewDelegate {


    var shelfArray=[String]()
    
    @IBOutlet weak var shelfTblView: UITableView!

    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        self.shelfTblView.delegate=self
        self.shelfTblView.dataSource=self
        
        // added on 04/11/2016 for wordwrap fix - Start
        
        self.shelfTblView.estimatedRowHeight = 100.0;
        self.shelfTblView.rowHeight = UITableViewAutomaticDimension;
        // added on 04/11/2016 for wordwrap fix - end
        
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
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let myShelfToReturn = self.shelfTblView.dequeueReusableCellWithIdentifier("myShelf", forIndexPath: indexPath) as! SSTableViewCell
        
        myShelfToReturn.shelfLabel.text = shelfArray[indexPath.row]
        
        return myShelfToReturn
    }

    
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        
        var numOfSection: NSInteger = 0
        
        if shelfArray.count > 0 {
            
            self.shelfTblView.backgroundView = nil
            numOfSection = 1
            
            
        } else
        {
            
            let noDataLabel: UILabel = UILabel(frame: CGRectMake(0, 0, self.shelfTblView.bounds.size.width,self.shelfTblView.bounds.size.height))
            
            noDataLabel.text = "No Data to Display"
            noDataLabel.textColor = UIColor(red: 22.0/255.0, green: 106.0/255.0, blue: 176.0/255.0, alpha: 1.0)
            noDataLabel.textAlignment = NSTextAlignment.Center
            self.shelfTblView.backgroundView = noDataLabel
            
        }
        return numOfSection
        
    }

    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
    }

    // added the 2 functions below  to fix the wrap issue - 04/11/2016 START
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
    func tableView(tableView: UITableView, estimatedHeightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }

     // added the 2 functions below  to fix the wrap issue - 04/11/2016 END
    
    
    func loadData() {
        
        
        let url="\(Constant.baseURL)/smartretailapp/api/shelfsugglist/?"
        
        // \(Constant.baseURL)
        // let url="http://127.0.0.1:8000/smartretailapp/api/shelfsugglist/?"
        
        let modUrl = url.stringByAddingPercentEscapesUsingEncoding(NSUTF8StringEncoding)
        
        Alamofire.request(.GET, modUrl!)
            .responseJSON   {
                response in
                switch response.result {
                case .Success(let JSON):
                    self.populateData(JSON as! NSArray)
                     print("Request Success : \(JSON)")
                    
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
                
                self.shelfTblView.reloadData()
                
                
                
                
            };
            
            
        }
        
        
    }
    
} // end of main
