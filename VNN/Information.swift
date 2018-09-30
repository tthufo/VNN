//
//  Information.swift
//  TourGuide
//
//  Created by Mac on 8/18/18.
//  Copyright © 2018 Mac. All rights reserved.
//

import UIKit

class Information: NSObject {
    
    static var itemList = [["title":"Ticke", "active":"0", "data":"997", "key":"ticke", "id":"0"],
                    ["title":"Biển hiệu", "active":"0", "data":"997", "key":"bienhieu", "id":"1"],
                    ["title":"Decal dán tủ", "active":"0", "data":"997", "key":"decal", "id":"2"],
                    ["title":"Phiếu thưởng", "active":"0", "data":"997", "key":"phieuthuong", "id":"3"],
                    ["title":"Dù", "active":"0", "data":"997", "key":"du", "id":"4"],
                    ["title":"Bèo mái hiên", "active":"0", "data":"997", "key":"beomaihien", "id":"5"],
                    ["title":"Bảng dò số", "active":"0", "data":"997", "key":"bangdoso", "id":"6"],
                    ["title":"Khác", "active":"0", "data":"997", "key":"khac", "id":"7"]
    ]
    
    static var token: String?
    
    static var userInfo: NSDictionary?
    
    static var userName: String?
    
    static func saveToken() {
        
        if self.getValue("token") != nil {
            token = "%@".format(parameters: self.getValue("token"))
        } else {
            token = nil
        }
        
//        if self.getValue("userName") != nil {
//            userName = self.getValue("userName")
//        } else {
//            userName = nil
//        }
    }
    
    static func saveInfo() {
        if self.getObject("info") != nil {
            userInfo = self.getObject("info")! as NSDictionary
        } else {
            userInfo = nil
        }
    }
    
    static func removeInfo() {
        
        self.removeValue("token")

        token = nil
        
        self.remove("info")

        userInfo = nil
    }
    
    static func cardType() -> NSDictionary {
        
        if userInfo == nil {
            return ["star_level":0]
        }
        
        let cardType = userInfo!["CardType"]
        
        return cardType as! NSDictionary
    }
}
