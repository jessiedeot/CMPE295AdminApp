//
//  Offer.swift
//  ShopSmartAdmin
//
//  Created by Jessie Deot on 3/22/16.
//  Copyright © 2016 Group5. All rights reserved.
//

import Foundation

struct Offer {
    
    var offerId:Int?
    var offerTitle:String?
    var offerDesc:String?
    var offerImgUrl:String
    var offerExpiry:String?
    
    
    init(data : NSDictionary){
        offerId = data["offer_id"] as? Int
        offerDesc = data["offer_desc"] as? String
        offerTitle = data["offer_title"] as? String
        offerExpiry = (data["offer_end_date"] as? String)
        offerImgUrl =  data["offer_img_url"] as! String
    }
}