//
//  OfferDetailViewController.swift
//  ShopSmartAdmin
//
//  Created by Jessie Deot on 3/22/16.
//  Copyright © 2016 Group5. All rights reserved.
//

import UIKit
import Alamofire

class OfferDetailViewController: UIViewController {

    @IBOutlet weak var offerTitle: UILabel!
    @IBOutlet weak var offerImage: UIImageView!
    @IBOutlet weak var offerDesc: UITextView!
    @IBOutlet weak var offerEndDate: UITextField!
    
    var offer: Offer!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        let url = NSURL(string: "\(offer.offerImgUrl)")
        let imageData: NSData = NSData(contentsOfURL: url!)!
        
        self.offerTitle.text = offer.offerTitle
        self.offerDesc.text = offer.offerDesc
        self.offerEndDate.text = String(offer.offerExpiry!)
        
        dispatch_async(dispatch_get_main_queue()){
            
            let image = UIImage(data:imageData)
            self.offerImage.image = image
            
        }
    }
    
    @IBAction func UpdateButton(sender: UIButton) {
        
        let prefs:NSUserDefaults = NSUserDefaults.standardUserDefaults()
        let csrftoken = prefs.objectForKey("csrftoken") as! String
        print(csrftoken)
        let headers = ["X-CSRFToken" : csrftoken]
        Alamofire.request(.PUT, "http://127.0.0.1:8000/smartretailapp/api/updateoffer/?offer_id=0&offer_end_date=2016-03-23/", headers: headers)
            .validate()
            .responseJSON {  response in
                switch response.result {
                case .Success:
                    print("Update Successful")
                    
                case .Failure(let error):
                    print("Request failed with error: \(error)")
                    
                }
        }

        
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
