//
//  OfferDetailViewController.swift
//  ShopSmartAdmin
//
//  Created by Jessie Deot on 3/22/16.
//  Copyright © 2016 Group5. All rights reserved.
//

import UIKit

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
