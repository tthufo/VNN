//
//  QL_LogIn_ViewController.swift
//  QLDT
//
//  Created by Thanh Hai Tran on 7/28/18.
//  Copyright © 2018 Thanh Hai Tran. All rights reserved.
//

import UIKit

class QL_LogIn_ViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet var check: UIButton!
    
    @IBOutlet var uName: UITextField!
    
    @IBOutlet var pass: UITextField!
    
    @IBOutlet var app: UILabel!
    
    @IBOutlet var changeHost: UILabel!

    var authenHost = "http://117.4.242.159:3334"
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if logged() {
            self.navigationController?.pushViewController(VN_Home_ViewController(), animated: false)
        }
        
        let appInfo = self.appInfor()! as NSDictionary
        
        app.text = "Phiên bản %@".format(parameters: appInfo.getValueFromKey("majorVersion"))
        
        changeHost.action(forTouch: [:]) { (obj) in
            self.navigationController?.pushViewController(TL_ChangeHost_ViewController(), animated: true)
        }
        
        if self.getValue("auto") == nil {
            self.addValue("1", andKey: "auto")
        }
        
//        if self.getValue("auto") == "1" {
//            uName.text = self.getValue("name")
//            pass.text = self.getValue("pass")
//        }
     
        check.setImage(UIImage.init(named: (self.getValue("auto") == nil || self.getValue("auto") == "0") ? "check_in" : "check_ac"), for: .normal)
        
        self.view.action(forTouch: [:]) { (obj) in
            self.view.endEditing(true)
        }
        
        //didRequestInfo()
    }
    
    @IBAction func didPressCheck() {
        check.setImage(UIImage.init(named: self.getValue("auto") == "1" ? "check_in" : "check_ac"), for: .normal)
        
        self.addValue(self.getValue("auto") == "0" ? "1" : "0", andKey: "auto")
    }
    
    @IBAction func didPressSubmit() {
        
        self.view.endEditing(true)
        
        if uName.text == "" || pass.text == "" {
            self.showToast("Tên đăng nhập và Mật khẩu không được để trống", andPos: 0)
            
            return
        }
        
        if (pass.text?.count)! < 6 {
            self.showToast("Mật khẩu phải có từ 6 ký tự", andPos: 0)
            
            return
        }
        
        didRequestLogin()
    }
    
    func didRequestLogin() {
        LTRequest.sharedInstance().didRequestInfo(["CMD_CODE":"login",
                                                   "Postparam":["user_name":"test", "password":"123456", "push_device_id":"1"],
                                                   "overrideLoading":1,
                                                   "overrideAlert":1,
                                                   "postFix":"login",
                                                   "host":self], withCache: { (cache) in
            
        }) { (response, errorCode, error, isValid) in
            if error != nil {
                
                let result = response?.dictionize()
                
                self.showToast(result!["ERR_MSG"] as! String, andPos: 0)
                
                return
            }
            
            let result = response?.dictionize()

            self.addValue(result!["TOKEN"] as? String, andKey: "token")
            
            self.add(result!["RESULT"] as! [AnyHashable : Any], andKey: "info")
            
            Information.saveInfo()
            
            Information.saveInfo()
            
            self.navigationController?.pushViewController(VN_Home_ViewController(), animated: true)
        }
    }
    
//    func didAuthorize() {
//        self.showSVHUD("Đang đăng nhập", andOption: 0)
//
//        let config = OIDServiceConfiguration.init(authorizationEndpoint: URL.init(string: "%@/connect/authorize".format(parameters: authenHost))!, tokenEndpoint: URL.init(string: "%@/connect/token".format(parameters: authenHost))!)
//
//        let token1 = OIDTokenRequest.init(configuration: config, grantType: "password", authorizationCode: nil, redirectURL: nil, clientID: "htgt.bn.app", clientSecret: "secret", scopes: nil, refreshToken: nil, codeVerifier: nil, additionalParameters: ["username":uName.text!,"password":pass.text!])
//
//        OIDAuthorizationService.perform(token1) { (response, error) in
//
//            if error != nil {
//
//                self.hideSVHUD()
//
//                self.showToast("Đăng nhập không thành công", andPos: 0)
//
//                return
//            }
//
//            if self.getValue("auto") == "0" {
//                self.removeValue("name")
//                self.removeValue("pass")
//            } else {
//                self.addValue(self.uName.text, andKey: "name")
//                self.addValue(self.pass.text, andKey: "pass")
//            }
//
//            self.addValue(response?.accessToken, andKey: "token")
//
//            self.addValue(self.uName.text, andKey: "userName")
//
//            Information.saveToken()
//
//            self.hideSVHUD()
//
//            self.navigationController?.pushViewController(QL_Home_ViewController(), animated: true)
//        }
//    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
    
        if textField ==  uName {
            pass.becomeFirstResponder()
        } else {
            pass.resignFirstResponder()
        }
        
        return true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
