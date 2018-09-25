//
//  TG_PopUp_View.swift
//  TourGuide
//
//  Created by Mac on 8/17/18.
//  Copyright © 2018 Mac. All rights reserved.
//

import UIKit

class TG_PopUp_View: CustomIOS7AlertView, UITextFieldDelegate {
  
    func initWithContent(content: NSDictionary, finished: @escaping (_ obj: NSDictionary) -> Void) {
        let base = Bundle.main.loadNibNamed("TG_Menu_View",
                                            owner: nil,
                                            options: nil)?[2] as! UIView
        base.frame = CGRect.init(x: 0, y: 0, width: 300, height: 230)
        
        let request = self.withView(base, tag: 11) as! UIButton
        
        request.action(forTouch: [:]) { (obj) in
            self.close()
            
            finished(["1":""])
        }
        
        let carecenter = self.withView(base, tag: 12) as! UIButton
        
        carecenter.action(forTouch: [:]) { (obj) in
            self.close()
            
            finished(["2":""])
        }
        
        self.containerView = base
        
        self.useMotionEffects = true
        
        show()
    }
    
    func initWithCode(content: NSDictionary, finished: @escaping (_ obj: NSDictionary) -> Void) {
        let base = Bundle.main.loadNibNamed("TG_Menu_View",
                                            owner: nil,
                                            options: nil)?[2] as! UIView
        base.frame = CGRect.init(x: 0, y: 0, width: 300, height: 400)
        
        
        
        
        
        let search = self.withView(base, tag: 2) as! UITextField
        
        search.delegate = self
        
        let done = self.withView(base, tag: 4) as! UIButton
        
        done.action(forTouch: [:]) { (obj) in
            self.close()
            
            finished(["1":""])
        }
        
        self.containerView = base
        
        self.useMotionEffects = true
        
        show()
    }
    
    func initWithItem(content: NSDictionary, finished: @escaping (_ obj: NSDictionary) -> Void) {
        let base = Bundle.main.loadNibNamed("TG_Menu_View",
                                            owner: nil,
                                            options: nil)?[3] as! UIView
        base.frame = CGRect.init(x: 0, y: 0, width: 300, height: 400)
        
        
        
        
        let done = self.withView(base, tag: 5) as! UIButton
        
        done.action(forTouch: [:]) { (obj) in
            self.close()
            
            finished(["1":""])
        }
        
        
        let cancel = self.withView(base, tag: 4) as! UIButton
        
        cancel.action(forTouch: [:]) { (obj) in
            self.close()
        }
        
        self.containerView = base
        
        self.useMotionEffects = true
        
        show()
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        textField.resignFirstResponder()
        
        return true
    }
    
    override func close() {
        super.close()
    }
}
