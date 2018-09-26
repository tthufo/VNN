//
//  TG_PopUp_View.swift
//  TourGuide
//
//  Created by Mac on 8/17/18.
//  Copyright © 2018 Mac. All rights reserved.
//

import UIKit

class TG_PopUp_View: CustomIOS7AlertView, UITextFieldDelegate, UITableViewDelegate, UITableViewDataSource {
  
    var dataList = NSMutableArray()
    
    var tempList = NSMutableArray()
    
    var checkList = NSMutableArray()
    
    var itemList = [["title":"Ticke", "active":"0", "data":"", "key":"ticke", "id":"0"],
                    ["title":"Biển hiệu", "active":"0", "data":"", "key":"bienhieu", "id":"1"],
                    ["title":"Decal dán tủ", "active":"0", "data":"", "key":"decal", "id":"2"],
                    ["title":"Phiếu thưởng", "active":"0", "data":"", "key":"phieuthuong", "id":"3"],
                    ["title":"Dù", "active":"0", "data":"", "key":"du", "id":"4"],
                    ["title":"Bèo mái hiên", "active":"0", "data":"", "key":"beomaihien", "id":"5"],
                    ["title":"Bảng dò số", "active":"0", "data":"", "key":"bangdoso", "id":"6"],
                    ["title":"Khác", "active":"0", "data":"", "key":"khac", "id":"7"]
                   ]

    
    let dataModel = [["title":"997", "id":"0", "key":"997"],
                     ["title":"8179", "id":"1", "key":"8179"],
                     ["title":"6020", "id":"2", "key":"6020"],
                     ["title":"6089", "id":"3", "key":"6089"],
                     ["title":"8036", "id":"4", "key":"8036"],
                     ["title":"6095", "id":"5", "key":"6095"],
                     ["title":"7039", "id":"6", "key":"7039"],
                     ["title":"8048", "id":"7", "key":"8048"],
                     ["title":"5055", "id":"8", "key":"5055"],
                     ["title":"8x12", "id":"9", "key":"8x12"],
                     ["title":"6x66", "id":"10", "key":"6x66"],
                     ["title":"Đầu số khác", "id":"11", "key":"Đầu số khác"]
                     ]
    
    
    
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
    
    
    
    func initWithCode(content: NSArray, finished: @escaping (_ obj: NSDictionary) -> Void) {
        let base = Bundle.main.loadNibNamed("TG_Menu_View",
                                            owner: nil,
                                            options: nil)?[2] as! UIView
        base.frame = CGRect.init(x: 0, y: 0, width: 300, height: 400)
        
        
        self.dataList.addObjects(from: content as! [Any])
        
        self.tempList.addObjects(from: content as! [Any])

        
        let search = self.withView(base, tag: 2) as! UITextField
        
        search.delegate = self
        
        
        
        let tableView = self.withView(base, tag: 3) as! UITableView
        
        
        tableView.withCell("TG_Drop_Cell")
        
        
        tableView.dataSource = self
        
        tableView.delegate = self
        
        
        
        
        let done = self.withView(base, tag: 4) as! UIButton
        
        done.action(forTouch: [:]) { (obj) in
            self.close()
        }
        
        
        
        self.containerView = base
        
        self.useMotionEffects = true
        
        show()
    }
    
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableView.tag == 3 ? self.dataList.count : self.itemList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: tableView.tag == 3 ? "TG_Drop_Cell" : "TG_Item_Cell", for: indexPath)
        
        if tableView.tag == 3 {
            let data = self.dataList[indexPath.row] as! NSDictionary
            
            (self.withView(cell, tag: 101) as! UILabel).text = data.getValueFromKey("agency_code")
        } else {
            let data = self.checkList[indexPath.row] as! NSDictionary

            
            
            let title = self.withView(cell, tag: 1) as! UILabel
            
            title.text = data["title"] as? String
            
            
            
            let check = self.withView(cell, tag: 10) as! UIButton
            
            check.setImage(UIImage(named: (self.checkList[indexPath.row] as! NSMutableDictionary).getValueFromKey("active") == "0" ? "check_in_b" : "check_ac_b"), for: .normal)
            
            check.action(forTouch: [:]) { (objc) in
                (self.checkList[indexPath.row] as! NSMutableDictionary)["active"] = (self.checkList[indexPath.row] as! NSDictionary).getValueFromKey("active") == "0" ? "1" : "0"
                
                tableView.reloadData()
            }
            
            
            
            let drop = self.withView(cell, tag: 2) as! DropButton
            
            drop.action(forTouch: [:]) { (objc) in
                drop.didDropDown(withData: self.dataModel, andCompletion: { (result) in
                    let output = (result as! NSDictionary)["data"]
                    
                    drop.setTitle((output as! NSDictionary)["title"] as? String, for: .normal)
                    
                    (self.checkList[indexPath.row] as! NSMutableDictionary)["data"] = (output as! NSDictionary)["title"] as? String
                })
            }
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        if tableView.tag == 3 {
            let data = self.dataList[indexPath.row] as! NSDictionary

            self.close()
            
            self.delegate.customIOS7dialogButtonTouchUp(inside: data, clickedButtonAt: indexPath.row)
        }
    }
    
    
    
    
    
    func initWithItem(content: NSDictionary, finished: @escaping (_ obj: NSDictionary) -> Void) {
        let base = Bundle.main.loadNibNamed("TG_Menu_View",
                                            owner: nil,
                                            options: nil)?[3] as! UIView
        base.frame = CGRect.init(x: 0, y: 0, width: 300, height: 400)
        
        
        
        self.checkList.addObjects(from: (self.itemList as NSArray).withMutable())
        
        
        
        let tableView = self.withView(base, tag: 30) as! UITableView
        
        
        tableView.withCell("TG_Item_Cell")
        
        
        tableView.dataSource = self
        
        tableView.delegate = self
        
        
        
        
        
        let done = self.withView(base, tag: 5) as! UIButton
        
        done.action(forTouch: [:]) { (obj) in
            self.close()
            
            print(self.checkList);
            
        }
        
        
        let cancel = self.withView(base, tag: 4) as! UIButton
        
        cancel.action(forTouch: [:]) { (obj) in
            self.close()
        }
        
        self.containerView = base
        
        self.useMotionEffects = true
        
        show()
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        if let text = textField.text as NSString? {
            let txtAfterUpdate = text.replacingCharacters(in: range, with: string)
            
            let predicate = NSPredicate(format: "SELF.agency_code CONTAINS[cd] %@", txtAfterUpdate)
            
            let arr = (tempList as NSArray).filtered(using: predicate)
            
            self.dataList.removeAllObjects()

            if arr.count > 0 {
                self.dataList.addObjects(from: arr)
            } else {
                self.dataList.addObjects(from: self.tempList as! [Any])
            }
            
            let parent = textField.superview
            
            (self.withView(parent, tag: 3) as! UITableView).reloadData()
        }
        
        return true
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        textField.resignFirstResponder()
        
        return true
    }
    
    override func close() {
        super.close()
    }
}
