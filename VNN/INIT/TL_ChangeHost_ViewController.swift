//
//  TL_ChangeHost_ViewController.swift
//  QLDT
//
//  Created by Thanh Hai Tran on 7/28/18.
//  Copyright © 2018 Thanh Hai Tran. All rights reserved.
//

import UIKit

class TL_ChangeHost_ViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet var host: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        self.view.endEditing(true)
        
        return true
    }
    
    @IBAction func didPressSubmi() {
        if host.text == "" {
            self.showToast("Bạn chưa nhập địa chỉ email", andPos: 0)
            
            return
        }
        
        didRequestChangePass()
    }
    
    func didRequestChangePass() {
        LTRequest.sharedInstance().didRequestInfo(["absoluteLink":"".urlGet(postFix: "processRequest"),
                                                   "Postparam":["CMD_CODE":"resetpassword", "user_name": host.text],
                                                   "overrideLoading":1,
                                                   "overrideAlert":1,
                                                   "host":self,
                                                   "postFix":"processRequest"
            ], withCache: { (cache) in
                
        }) { (response, errorCode, error, isValid) in
            
            print(response)
            
        }
    }
    
    @IBAction func didPressBack() {
        self.navigationController?.popViewController(animated: true)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
