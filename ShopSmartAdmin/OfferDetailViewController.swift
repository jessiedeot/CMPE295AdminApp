//
//  OfferDetailViewController.swift
//  ShopSmartAdmin
//
//  Created by Jessie Deot on 3/22/16.
//  Copyright © 2016 Group5. All rights reserved.
//

import UIKit
import Alamofire

class OfferDetailViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var offerTitle: UILabel!
    @IBOutlet weak var offerImage: UIImageView!
    @IBOutlet weak var offerDesc: UITextView!
    @IBOutlet weak var offerEndDate: UITextField!
    
    var offer: Offer!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.offerEndDate.delegate = self;
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
        
        let currentDate = NSDate()
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let todaysDate = dateFormatter.stringFromDate(currentDate)
        
        //let offer_end_date = "2016-04-27"
        
        switch todaysDate.compare(offerEndDate.text!) {
            
        case .OrderedAscending:
            print("todaysDate is earlier than offer_end_date")
            self.updateOffer()
            
        case .OrderedDescending:
            print("todaysDate is later than offer_end_date")
            let alert = UIAlertController(title: "Failed!", message:"Please enter a future date", preferredStyle: .Alert)
            let action = UIAlertAction(title: "OK", style: .Default) { _ in}
            alert.addAction(action)
            self.presentViewController(alert, animated: true){}
            
            
        case .OrderedSame:
            print("The two dates are the same")
            let alert = UIAlertController(title: "Failed!", message:"Please enter a future date", preferredStyle: .Alert)
            let action = UIAlertAction(title: "OK", style: .Default) { _ in}
            alert.addAction(action)
            self.presentViewController(alert, animated: true){}
        }

        
        
    }
    
    func updateOffer(){
        
        let params = ["offer_id":offer.offerId!, "offer_end_date":offerEndDate.text!] as Dictionary<String, AnyObject>
        print(params)
        let prefs:NSUserDefaults = NSUserDefaults.standardUserDefaults()
        let csrftoken = prefs.objectForKey("csrftoken") as! String
        print(csrftoken)
        let headers = ["X-CSRFToken" : csrftoken]
        Alamofire.request(.PUT, "\(Constant.baseURL)/smartretailapp/api/offer/\(offer.offerId!)",parameters: params,  encoding: .JSON , headers:headers)
            .validate()
            .responseJSON {  response in
                switch response.result {
                case .Success:
                    print("Update Successful")
                    let alert = UIAlertController(title: "Success!", message:"Offer has been updated successfully", preferredStyle: .Alert)
                    let action = UIAlertAction(title: "OK", style: .Default) { _ in}
                    alert.addAction(action)
                    dispatch_async(dispatch_get_main_queue(), {
                        self.presentViewController(alert, animated: true){}
                    })
                    
                    
                case .Failure(let error):
                    print("Request failed with error: \(error)")
                    
                }
        }
        

        
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
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
