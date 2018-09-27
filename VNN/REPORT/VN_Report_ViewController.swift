//
//  VN_Report_ViewController.swift
//  VNN
//
//  Created by Thanh Hai Tran on 9/25/18.
//  Copyright © 2018 Thanh Hai Tran. All rights reserved.
//

import UIKit

class VN_Report_ViewController: UIViewController {

    var dataList = NSMutableArray()
    
    @IBOutlet var tableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()

        didRequestAgency()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func didRequestAgency() {
        LTRequest.sharedInstance().didRequestInfo(["absoluteLink":"".urlGet(postFix: "processRequest"),
                                                   "header":["Authorization":Information.token == nil ? "" : Information.token!],
                                                   "Postparam":["CMD_CODE":"listagencyerror","user_id":INFO()["id"]],
                                                   "overrideAlert":1,
                                                   "postFix":"processRequest"
            ], withCache: { (cache) in
                
        }) { (response, errorCode, error, isValid) in
            
            if error != nil {
                
                self.hideSVHUD()
                
                return
            }
            let result = response?.dictionize()
            
//            self.regionList.removeAllObjects()
//
//            self.regionList.addObjects(from: result!["RESULT"] as! [Any])
//
//            (self.ownList[0] as! NSMutableDictionary)["data"] = self.regionList.firstObject
//
//            (self.theirList[0] as! NSMutableDictionary)["data"] = self.regionList.firstObject
//
//            self.didRequestCity(region: ((result!["RESULT"] as! [Any]).first as! NSDictionary)["id"] as! String)
//
//            self.tableView.reloadData()
        }
    }
   
    @IBAction func didPressBack() {
        self.navigationController?.popViewController(animated: true)
    }
}

extension VN_Report_ViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return UITableViewAutomaticDimension
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.dataList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "", for: indexPath)
        
        let data = self.dataList[indexPath.row] as! NSDictionary
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
