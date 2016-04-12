//
//  NIBViewController.swift
//  ShopSmartAdmin
//
//  Created by thinatar on 3/30/16.
//  Copyright © 2016 Group5. All rights reserved.
//

import UIKit
import Alamofire

class NIBViewController: UIViewController {

    var recoText: String = ""
    
    @IBOutlet weak var nibCustId: UITextField!


    @IBOutlet weak var nibProd: UITextField!

    @IBAction func nibRecoEngine(sender: AnyObject) {
       
        loadData()
        
        
    }

    @IBOutlet weak var nibRecoText: UITextView!

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // for setting the border for UITextView
        
//        let borderColor : UIColor = UIColor(red: 0.85, green: 0.85, blue: 0.85, alpha: 1.0)
        let borderColor : UIColor = UIColor(red: 0.41, green: 0.10, blue: 0.6, alpha: 1.0)
        nibRecoText.layer.borderWidth = 0.5
        nibRecoText.layer.borderColor = borderColor.CGColor
        nibRecoText.layer.cornerRadius = 5.0
        
        
        // Do any additional setup after loading the view, typically from a nib.
        
        //self.shelfTblView.delegate=self
        //self.shelfTblView.dataSource=self
        
       // loadData()
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func loadData() {
        
        // let url="http://127.0.0.1:8000/smartretailapp/api/nextinbasket/?cust=&productName="
        
        
        let urlPath = "\(Constant.baseURL)/smartretailapp/api/nextinbasket/?cust=\(nibCustId.text!)&productName=\(nibProd.text!)"
        
  //      let urlPath = "http://127.0.0.1:8000/smartretailapp/api/nextinbasket/?cust=\(nibCustId.text!)&productName=\(nibProd.text!)"
        
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
            
                
                recoText = item[0] as! String
                print("recoText Char count is ---> :  \(self.recoText.characters.count)")

                // handling empty string with a noData Label
                
                if(self.recoText.characters.count<1)
                    {
                        print("IF Start recoText Char count is ---> :  \(self.recoText.characters.count)")
                        self.recoText="\n\n\n\n      No Data to Display\n\n\n\n"
                        print("IF End recoText Char count is ---> :  \(self.recoText.characters.count)")
                    }
                
                
              //  shelfArray.append(item[0] as! String)
                
                
                
            }
            
            dispatch_async(dispatch_get_main_queue()) {
                
                self.nibRecoText.text = self.recoText
                
                
              //  self.shelfTblView.reloadData()
                
                
                
                
            };
            
            
        }
        
        
    }



} // end of Main
