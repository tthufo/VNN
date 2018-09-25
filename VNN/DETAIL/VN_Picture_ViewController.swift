//
//  VN_Picture_ViewController.swift
//  VNN
//
//  Created by Thanh Hai Tran on 9/22/18.
//  Copyright © 2018 Thanh Hai Tran. All rights reserved.
//

import UIKit

class VN_Picture_ViewController: UIViewController {

    @IBOutlet var tableView: UITableView!
    
    var regionList = NSMutableArray()
    
    var cityList = NSMutableArray()

    var districtList = NSMutableArray()
    
    var uploadData = NSMutableDictionary()

    var dataList = [["ident":"QL_Drop_Cell"],
                    ["ident":"QL_Drop_Cell"],
                    ["ident":"QL_Drop_Cell"],
                    ["ident":"QL_Drop_Cell"],
                    ["ident":"QL_Input_Cell"],
                    ["ident":"QL_Input_Cell"],
                    ["ident":"QL_Input_Cell"],
                    ["ident":"QL_Group_Cell"],
                    ["ident":"QL_Input_Cell"],
                    ["ident":"QL_Image_Cell"],
                    ["ident":"QL_Image_Cell"],
                    ["ident":"QL_Image_Cell"]]

    override func viewDidLoad() {
        super.viewDidLoad()

        self.tableView.withCell("QL_Drop_Cell")
        self.tableView.withCell("QL_Input_Cell")
        self.tableView.withCell("QL_Group_Cell")
        self.tableView.withCell("QL_Image_Cell")

        self.uploadData.addEntries(from: ["region":[:],
                                          "city":[:],
                                          "district":[:]])
        
        didRequestRegion()
    }

    @IBAction func didPressBack() {
       self.navigationController?.popViewController(animated: true)
    }
    
    func didRequestRegion() {
        self.showSVHUD("Đang tải", andOption: 0)
        LTRequest.sharedInstance().didRequestInfo(["absoluteLink":"".urlGet(postFix: "processRequest"),
                                                   "header":["Authorization":Information.token == nil ? "" : Information.token!],
                                                   "Postparam":["CMD_CODE":"getlistregion","user_id":INFO()["id"], "id":""],
                                                   "overrideAlert":1,
                                                   "postFix":"processRequest"
            ], withCache: { (cache) in
                
        }) { (response, errorCode, error, isValid) in
            
            if error != nil {
                
                self.hideSVHUD()
                
                return
            }
            let result = response?.dictionize()
            
            self.regionList.removeAllObjects()
            
            self.regionList.addObjects(from: result!["RESULT"] as! [Any])
            
            self.uploadData["region"] = self.regionList.firstObject
            
            self.didRequestCity(region: ((result!["RESULT"] as! [Any]).first as! NSDictionary)["id"] as! String)
            
            self.tableView.reloadData()
        }
    }
    
    func didRequestCity(region: String) {
        LTRequest.sharedInstance().didRequestInfo(["absoluteLink":"".urlGet(postFix: "processRequest"),
                                                   "header":["Authorization":Information.token == nil ? "" : Information.token!],
                                                   "Postparam":["CMD_CODE":"getlistcity","user_id":INFO()["id"], "id":region],
                                                   "overrideAlert":1,
                                                   "postFix":"processRequest"
            ], withCache: { (cache) in
                
        }) { (response, errorCode, error, isValid) in
            
            if error != nil {
                
                self.hideSVHUD()

                return
            }
            
            let result = response?.dictionize()
            
            self.cityList.removeAllObjects()
            
            if (result!["RESULT"] as! [Any]).count != 0 {
                
                self.cityList.addObjects(from: result!["RESULT"] as! [Any])
                
                self.uploadData["city"] = self.cityList.firstObject
                
                self.didRequestDistrict(city: ((result!["RESULT"] as! [Any]).first as! NSDictionary)["id"] as! String)
                
            } else {
                self.cityList.addObjects(from: [["title":"Danh sách trống", "id":-1]])
                
                self.uploadData["city"] = self.cityList.firstObject
                
                self.districtList.removeAllObjects()
                
                self.districtList.addObjects(from: [["title":"Danh sách trống", "id":-1]])
                
                self.uploadData["district"] = self.districtList.firstObject
            }

            self.tableView.reloadData()
        }
    }
    
    func didRequestDistrict(city: String) {
        LTRequest.sharedInstance().didRequestInfo(["absoluteLink":"".urlGet(postFix: "processRequest"),
                                                   "header":["Authorization":Information.token == nil ? "" : Information.token!],
                                                   "Postparam":["CMD_CODE":"getlistdistrict","user_id":INFO()["id"], "id":city],
                                                   "overrideAlert":1,
                                                   "postFix":"processRequest"
            ], withCache: { (cache) in
                
        }) { (response, errorCode, error, isValid) in
            
            self.hideSVHUD()

            if error != nil {
                return
            }
            let result = response?.dictionize()
            
            self.districtList.removeAllObjects()
            
            if (result!["RESULT"] as! [Any]).count != 0 {
                self.districtList.addObjects(from: result!["RESULT"] as! [Any])
                
                self.uploadData["district"] = self.districtList.firstObject
            } else {
                self.districtList.removeAllObjects()

                self.districtList.addObjects(from: [["title":"Danh sách trống", "id":-1]])
                
                self.uploadData["district"] = self.districtList.firstObject
            }
            self.tableView.reloadData()
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()

    }
    
    func didAskForMedia(indexing: String) {
        Permission.shareInstance().askGallery { (camType) in
            switch (camType) {
            case .authorized:
                Media.shareInstance().startPickImage(withOption: false, andBase: nil, andRoot: self, andCompletion: { (image) in
                    if image != nil {
                        self.saveImage(image: image as! UIImage, indexing: indexing)
                    }
                })
                break
            case .denied:
                self.showToast("Bạn chưa cho phép sử dụng Bộ sưu tập", andPos: 0)
                break
            case .per_denied:
                self.showToast("Bạn chưa cho phép sử dụng Bộ sưu tập", andPos: 0)
                break
            case .per_granted:
                Media.shareInstance().startPickImage(withOption: false, andBase: nil, andRoot: self, andCompletion: { (image) in
                    if image != nil {
                        self.saveImage(image: image as! UIImage, indexing: indexing)
                    }
                })
                break
            case .restricted:
                self.showToast("Bạn chưa cho phép sử dụng Bộ sưu tập", andPos: 0)
                break
            default:
                break
            }
        }
    }
    
    func didAskForCamera(indexing: String) {
        Permission.shareInstance().askCamera { (camType) in
            switch (camType) {
            case .authorized:
                Media.shareInstance().startPickImage(withOption: true, andBase: nil, andRoot: self, andCompletion: { (image) in
                    if image != nil {
                        self.saveImage(image: image as! UIImage, indexing: indexing)
                    }
                })
                break
            case .denied:
                self.showToast("Bạn chưa cho phép sử dụng Bộ sưu tập", andPos: 0)
                break
            case .per_denied:
                self.showToast("Bạn chưa cho phép sử dụng Bộ sưu tập", andPos: 0)
                break
            case .per_granted:
                Media.shareInstance().startPickImage(withOption: true, andBase: nil, andRoot: self, andCompletion: { (image) in
                    if image != nil {
                        self.saveImage(image: image as! UIImage, indexing: indexing)
                    }
                })
                break
            case .restricted:
                self.showToast("Bạn chưa cho phép sử dụng Bộ sưu tập", andPos: 0)
                break
            default:
                break
            }
        }
    }
    
    func saveImage(image: UIImage, indexing: String) {
        (dataList[Int(indexing)!] as! NSMutableDictionary)["data"] = image.imageString()
        
        self.tableView.reloadData()
    }
}

extension VN_Picture_ViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        
        return true
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        let indexing = Int(textField.accessibilityLabel!)
        
        if let text = textField.text as NSString? {
            let txtAfterUpdate = text.replacingCharacters(in: range, with: string)
            
            (dataList[indexing!] as! NSMutableDictionary)["data"] = txtAfterUpdate
        }
        
        return true
    }
}

extension VN_Picture_ViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.uploadData.allKeys.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: (dataList[indexPath.row] as NSDictionary)["ident"] as! String, for: indexPath)
        
//        if dataList.count == 0 {
//            return cell
//        }
        
        let data = dataList[indexPath.row] as NSDictionary
        
        if data["ident"] as! String == "QL_Input_Cell" {
            let input = (self.withView(cell, tag: 2) as! UITextField)
            
//            let isNumber = data.response(forKey: "number")
//
//            input.keyboardType = isNumber ? .numberPad : .default
//
//            input.accessibilityLabel = "%i".format(parameters: indexPath.row)
            
            input.delegate = self
            
//            input.text = data["data"] as? String
        }
        
        if data["ident"] as! String == "QL_Drop_Cell" {
            
            let drop = (self.withView(cell, tag: 2) as! DropButton)

            let data = self.uploadData.allValues[indexPath.row] as! NSDictionary
            
            if data.allValues.count != 0 {
                drop.setTitle(data["title"] as? String, for: .normal)
            }
            
            let array = indexPath.row == 0 ? self.regionList : indexPath.row == 1 ? self.cityList : self.districtList
            
            let key = indexPath.row == 0 ? "region" : indexPath.row == 1 ? "city" : "district"
            
            drop.action(forTouch: [:]) { (objc) in
                drop.didDropDown(withData: array as! [Any], andCompletion: { (result) in
                    if result != nil {
                        let data = (result as! NSDictionary)["data"]
                        
                        if (data as! NSDictionary).getValueFromKey("id") == "-1" {
                            return
                        }
                        
                        self.uploadData[key] = data
                        
                        drop.setTitle((data as! NSDictionary)["title"] as? String, for: .normal)
                        
                        if indexPath.row == 0 {
                            self.didRequestCity(region: (data as! NSDictionary)["id"] as! String)
                        }
                        
                        if indexPath.row == 1 {
                            self.didRequestDistrict(city: (data as! NSDictionary)["id"] as! String)
                        }
                    }
                })
            }
        }
        
//        if data["ident"] as! String == "QL_Calendar_Cell" {
//            let cal = (self.withView(cell, tag: 2) as! UIImageView)
//
//            cal.action(forTouch: [:]) { (objc) in
//                let cal = MNViewController.init(calendar: Calendar.init(identifier: .gregorian), title: "%i".format(parameters: indexPath.row))
//
//                cal?.delegate = self
//
//                self.present(cal!, animated: true) {
//
//                }
//            }
//
//            let date = (self.withView(cell, tag: 3) as! UILabel)
//
//            date.text = data["data"] as? String
//        }
//
//        if data["ident"] as! String == "QL_Location_Cell" {
//            let loc = (self.withView(cell, tag: 2) as! UIImageView)
//
//            loc.action(forTouch: [:]) { (objc) in
//                let map = QL_Map_ViewController()
//
//                map.indexing = "%i".format(parameters: indexPath.row)
//
//                map.tempLocation = data["data"] as! [[String : String]]
//
//                map.isMulti = false
//
//                map.delegate = self
//
//                self.present(map, animated: true, completion: {
//
//                })
//            }
//
//            if (data["data"] as! NSArray).count != 0 {
//
//                let coor = (data["data"] as! NSArray).firstObject as! NSDictionary
//
//                let X = (self.withView(cell, tag: 3) as! UILabel)
//
//                X.text = coor["lat"] as? String
//
//                let Y = (self.withView(cell, tag: 4) as! UILabel)
//
//                Y.text = coor["lng"] as? String
//            }
//        }
//
//        if data["ident"] as! String == "QL_Geo_Cell" {
//            let loc = (self.withView(cell, tag: 2) as! UIImageView)
//
//            loc.action(forTouch: [:]) { (objc) in
//                let map = QL_Map_ViewController()
//
//                map.indexing = "%i".format(parameters: indexPath.row)
//
//                map.tempLocation = data["data"] as! [[String : String]]
//
//                map.isMulti = true
//
//                map.delegate = self
//
//                self.present(map, animated: true, completion: {
//
//                })
//            }
//
//            let te = (self.withView(cell, tag: 100) as! UILabel)
//
//            let scroll = (self.withView(cell, tag: 200) as! UIScrollView)
//
//
//            if (data["data"] as! NSArray).count != 0 {
//
//                te.text = self.geoText(data: (data["data"] as? NSArray)!)
//
//                scroll.contentSize = CGSize.init(width: te.getSize().width + 10, height: 44)
//            }
//        }
//
        if data["ident"] as! String == "QL_Image_Cell" {

            let gallery = (self.withView(cell, tag: 2) as! UIButton)

            gallery.action(forTouch: [:]) { (objc) in
                self.didAskForMedia(indexing: "%i".format(parameters: indexPath.row))
            }

            let cam = (self.withView(cell, tag: 3) as! UIButton)

            cam.action(forTouch: [:]) { (objc) in
                self.didAskForCamera(indexing: "%i".format(parameters: indexPath.row))
            }

            let image = (self.withView(cell, tag: 4) as! UIImageView)

//            if data["data"] as! String != "" {
//                image.image = (data["data"] as! String).stringImage()
//            }
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
