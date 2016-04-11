//
//  FreqPViewController.swift
//  ShopSmartAdmin
//
//  Created by thinatar on 4/2/16.
//  Copyright © 2016 Group5. All rights reserved.
//

import UIKit
import Alamofire

class FreqPViewController: UIViewController {
    
    var freqpurcText: String = ""
    
    @IBOutlet weak var fpCustId: UITextField!
    
    @IBAction func submitFP(sender: AnyObject) {
        
    loadData()
        
        
        
    }
    
    
    @IBOutlet weak var fpText: UITextView!
  
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // for setting the border for UITextView 
        
        // let borderColor : UIColor = UIColor(red: 0.85, green: 0.85, blue: 0.85, alpha: 1.0)
        
        let borderColor : UIColor = UIColor(red: 0.41, green: 0.10, blue: 0.6, alpha: 1.0)
        fpText.layer.borderWidth = 0.5
        fpText.layer.borderColor = borderColor.CGColor
        fpText.layer.cornerRadius = 5.0
        

        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func loadData() {
        
        
        let urlPath = "http://127.0.0.1:8000/smartretailapp/api/freqpurcust/?cust=\(fpCustId.text!)"
        
        print(urlPath)
        
        
        let modUrl = urlPath.stringByAddingPercentEscapesUsingEncoding(NSUTF8StringEncoding)
        
        
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
                
                
                freqpurcText = item[0] as! String
                print("freqpurcText Char count is ---> :  \(self.freqpurcText.characters.count)")
                
                // handling empty string with a noData Label
                
                if(self.freqpurcText.characters.count<1)
                {
                    print("IF Start freqpurcText Char count is ---> :  \(self.freqpurcText.characters.count)")
                    
                    self.freqpurcText="\n\n\n\n      No Data to Display\n\n\n\n"
                    print("IF End freqpurcText Char count is ---> :  \(self.freqpurcText.characters.count)")
                }
                
                
                //  shelfArray.append(item[0] as! String)
                
                
                
            }
            
            dispatch_async(dispatch_get_main_queue()) {
                
                self.fpText.text = self.freqpurcText
                
                
                //  self.shelfTblView.reloadData()
                
                
                
                
            };
            
            
        }
        
        
    }
    

} // end of Main()

