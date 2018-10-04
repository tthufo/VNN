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
    
    var tempList = NSMutableArray()
        
    @IBOutlet var tableView: UITableView!

    var kb = KeyBoard.shareInstance()
    
    var refreshHeader: UIRefreshControl!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        refreshHeader = UIRefreshControl.init()
        
        refreshHeader.addTarget(self, action: #selector(didRequestAgency), for: UIControlEvents.valueChanged)
        
        tableView.addSubview(refreshHeader)
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        didRequestAgency()

        kb?.keyboard { (height, isOn) in
            self.tableView.contentInset = UIEdgeInsetsMake(0, 0, isOn ? (height) : 0, 0)
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        kb?.keyboardOff()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @objc func didRequestAgency() {
        LTRequest.sharedInstance().didRequestInfo(["absoluteLink":"".urlGet(postFix: "processRequest"),
                                                   "header":["Authorization":Information.token == nil ? "" : Information.token!],
                                                   "Postparam":["CMD_CODE":"listagencyerror","user_id":INFO()["id"]],
                                                   "overrideAlert":1,
                                                   "overrideLoading":1,
                                                   "host":self,
                                                   "postFix":"processRequest"
            ], withCache: { (cache) in
                
        }) { (response, errorCode, error, isValid) in
            
            self.refreshHeader.endRefreshing()
            
            if error != nil {
                
                self.hideSVHUD()
                
                return
            }
            let result = response?.dictionize()
            
            self.dataList.removeAllObjects()

            self.tempList.removeAllObjects()

            self.dataList.addObjects(from: result!["RESULT"] as! [Any])

            self.tempList.addObjects(from: result!["RESULT"] as! [Any])
            
            self.tableView.reloadData()
       }
    }
   
    @IBAction func didPressBack() {
        self.navigationController?.popViewController(animated: true)
    }
}

extension VN_Report_ViewController: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        if let text = textField.text as NSString? {
            let txtAfterUpdate = text.replacingCharacters(in: range, with: string)
            
            let predicate = NSPredicate(format: "SELF.agency_name CONTAINS[cd] %@ OR SELF.address CONTAINS[cd] %@", txtAfterUpdate, txtAfterUpdate)
            
            let arr = (tempList as NSArray).filtered(using: predicate)
            
            self.dataList.removeAllObjects()
            
            if arr.count > 0 {
                self.dataList.addObjects(from: arr)
            } else {
                self.dataList.addObjects(from: self.tempList as! [Any])
            }
            
            let parent = textField.superview
            
            self.tableView.reloadData()
        }
        
        return true
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        textField.resignFirstResponder()
        
        return true
    }
}

extension VN_Report_ViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 45
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.dataList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: "Cell")
        
        if( !(cell != nil))
        {
            cell = UITableViewCell(style: UITableViewCellStyle.subtitle, reuseIdentifier: "Cell")
        }
        
        let data = self.dataList[indexPath.row] as! NSDictionary

        cell!.textLabel?.text = data["agency_name"] as? String
        
        cell!.detailTextLabel?.text = data["address"] as? String
        
        return cell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let data = self.dataList[indexPath.row] as! NSDictionary
        
        let module = Int(data["agency_type"] as! String)
        
        switch module {
        case 1, 2, 3:
            let picture = VN_Picture_ViewController()
            
            picture.isEnemy = (module == 2 || module == 3)
            
            picture.editData = data
            
            picture.tempEditData = data

            self.navigationController?.pushViewController(picture, animated: true)
            break
//        case 3:
//            let expand = VN_Expand_ViewController()
//
//            expand.editData = data
//
//            expand.tempEditData = data
//
//            self.navigationController?.pushViewController(expand, animated: true)
//            break
        default:
            break
        }
    }
}
