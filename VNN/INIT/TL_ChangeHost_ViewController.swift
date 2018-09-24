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
            self.showToast("Bạn chưa nhập địa chỉ máy chủ", andPos: 0)
            
            return
        }
        
        self.addValue(host.text, andKey: "url")
    }
    
    @IBAction func didPressBack() {
        self.navigationController?.popViewController(animated: true)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
