//
//  ManageOffersViewController.swift
//  ShopSmartAdmin
//
//  Created by Jessie Deot on 3/5/16.
//  Copyright © 2016 Group5. All rights reserved.
//

import UIKit
import Alamofire

class ManageOffersViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    
    @IBOutlet weak var offerTableView: UITableView!
    
    var offerArray=[Offer]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.offerTableView.delegate=self
        self.offerTableView.dataSource=self
        
        Alamofire.request(.GET, "http://54.153.9.205:8000/smartretailapp/api/offer/?format=json")
            .responseJSON {  response in
                switch response.result {
                case .Success(let JSON):
                    print("Successs: \(JSON)")
                    self.populateData(JSON as! NSArray)
                    
                case .Failure(let error):
                    print("Request failed with error: \(error)")
                    
                }
        }

    }
    
    func populateData(jsonData: NSArray){
        
        if(jsonData.count>0){
            
            for item in jsonData{
                
                let dict = item as! NSMutableDictionary
                let offerItem = Offer(data: dict)
                self.offerArray.append(offerItem)
                
            }
            
            dispatch_async(dispatch_get_main_queue()) {
                
                self.offerTableView.reloadData()
            };

        }
        
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return offerArray.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let offer = self.offerTableView.dequeueReusableCellWithIdentifier("offer_item", forIndexPath: indexPath) as! OfferTableViewCell
        
        offer.offerLabel.text = offerArray[indexPath.row].offerTitle
        
        return offer
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
    }


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if(segue.identifier == "offer_detail"){
            let indexPath = self.offerTableView.indexPathForCell(sender as! OfferTableViewCell)
            let offer = self.offerArray[indexPath!.row]

            let dvc = segue.destinationViewController as! OfferDetailViewController
            dvc.offer = offer
        }
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
