//
//  VN_Expand_ViewController.swift
//  VNN
//
//  Created by Thanh Hai Tran on 9/22/18.
//  Copyright © 2018 Thanh Hai Tran. All rights reserved.
//

import UIKit

class VN_Expand_ViewController: UIViewController {
        
    @IBOutlet var tableView: UITableView!
    
    var regionList = NSMutableArray()
    
    var cityList = NSMutableArray()
    
    var districtList = NSMutableArray()
    
    var kb: KeyBoard!
    
    var dealerList = NSMutableArray()
    
    
    var editData: NSDictionary!
    
    var tempEditData: NSDictionary!
    
    
    var ownList = NSMutableArray()
    
    var theirList = NSMutableArray()
    
    var expandList = NSMutableArray()

    var timer: Timer!
    
    var pageSize: Int = 100
    
    var tempData: NSMutableDictionary!
    
    var isEnemy = 1
    
    
    var temp = [["ident":"QL_Drop_Cell", "data":[:], "title":"Miền"],
                ["ident":"QL_Drop_Cell", "data":[:], "title":"Tỉnh"],
                ["ident":"QL_Drop_Cell", "data":[:], "title":"Quận/Huyện"],
                ["ident":"QL_Input_Cell", "data":100, "title":"Số lượng đại lý trên tỉnh", "number":1, "timer":""],
                ["ident":"QL_Box_Cell", "data":["title":"Đại lý có sẵn", "id":1], "title":"Tình trạng đại lý", "list":[["title":"Đại lý có sẵn", "id":1], ["title":"Đại lý đối thủ", "id":2], ["title":"Đại lý phát sinh", "id":3]]],
                ["ident":"QL_Code_Cell", "data":"", "list":[], "title":"Mã đại lý"],
                ["ident":"QL_Input_Cell", "data":"", "title":"Địa chỉ đại lý"],
                ["ident":"QL_Input_Cell", "data":"", "title":"Tên đại lý"],
                ["ident":"QL_Input_Cell", "data":"", "number":1, "title":"Số điện thoại"],
                ["ident":"TG_Room_Cell_N", "data":[], "title":"Vật phẩm 997 cung cấp"],
                ["ident":"QL_Input_Cell", "data":"", "title":"Ghi chú"]]

    
    
    var temp1 = [["ident":"QL_Drop_Cell", "data":[:], "title":"Miền"],
                 ["ident":"QL_Drop_Cell", "data":[:], "title":"Tỉnh"],
                 ["ident":"QL_Drop_Cell", "data":[:], "title":"Quận/Huyện"],
                 ["ident":"QL_Input_Cell", "data":100, "title":"Số lượng đại lý trên tỉnh", "number":1, "timer":""],
                 ["ident":"QL_Box_Cell", "data":["title":"Đại lý có sẵn", "id":1], "title":"Tình trạng đại lý", "list":[["title":"Đại lý có sẵn", "id":1], ["title":"Đại lý đối thủ", "id":2], ["title":"Đại lý phát sinh", "id":3]]],
                 ["ident":"QL_Input_Cell", "data":"", "title":"Địa chỉ đại lý"],
                 ["ident":"QL_Input_Cell", "data":"", "title":"Tên đại lý"],
                 ["ident":"QL_Input_Cell", "data":"", "number":1, "title":"Số điện thoại"],
                 ["ident":"QL_Box_Cell", "data":["title":"997", "id":1], "list":[["title":"997", "id":"0", "key":"997"],
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
                                                                                           ["title":"Đầu số khác", "id":"11", "key":"Đầu số khác"]], "title":"Đối thủ liên hệ với đại lý", "enemy":1],
                 ["ident":"QL_Input_Cell", "data":"", "title":"Ghi chú"],
                 ["ident":"QL_Image_Cell", "id":1, "data":"", "title":"Ảnh vật phẩm"],
                 ["ident":"QL_Image_Cell", "id":2, "data":"", "title":"Ảnh toàn cảnh"],
                 ["ident":"QL_Image_Cell", "id":3, "data":"", "title":"Ảnh trực diện tủ vé"]]
    
    
    var temp2 = [["ident":"QL_Drop_Cell", "data":[:], "title":"Miền"],
                 ["ident":"QL_Drop_Cell", "data":[:], "title":"Tỉnh"],
                 ["ident":"QL_Drop_Cell", "data":[:], "title":"Quận/Huyện"],
                 ["ident":"QL_Input_Cell", "data":100, "title":"Số lượng đại lý trên tỉnh", "number":1, "timer":""],
                 ["ident":"QL_Box_Cell", "data":["title":"Đại lý có sẵn", "id":1], "title":"Tình trạng đại lý", "list":[["title":"Đại lý có sẵn", "id":1], ["title":"Đại lý đối thủ", "id":2], ["title":"Đại lý phát sinh", "id":3]]],
                 ["ident":"QL_Input_Cell", "data":"", "title":"Mã đại lý"],
                 ["ident":"QL_Input_Cell", "data":"", "title":"Địa chỉ đại lý"],
                 ["ident":"QL_Input_Cell", "data":"", "title":"Tên đại lý"],
                 ["ident":"QL_Input_Cell", "data":"", "number":1, "title":"Số điện thoại"],
                 ["ident":"TG_Room_Cell_N", "data":[], "title":"Vật phẩm 997 cung cấp"],
                 ["ident":"QL_Input_Cell", "data":"", "number":1, "title":"Phân cấp đại lý"],
                 ["ident":"QL_Input_Cell", "data":"", "title":"Ghi chú"],
                 ["ident":"QL_Image_Cell", "id":1, "data":"", "title":"Ảnh vật phẩm"],
                 ["ident":"QL_Image_Cell", "id":2, "data":"", "title":"Ảnh toàn cảnh"],
                 ["ident":"QL_Image_Cell", "id":3, "data":"", "title":"Ảnh trực diện tủ vé"],
                 ["ident":"QL_Image_Cell", "id":4, "data":"", "title":"Ảnh đại lý trước quảng cáo"]]
    
    func fillInDealer(dealer: NSDictionary) {
        
        self.tempData = dealer.reFormat()
        
        var hehe = [Any]()
        
        for dict in self.ownList {
            if (dict as! NSDictionary)["ident"] as! String == "QL_Image_Cell" {
                hehe.append(dict)
            }
        }
        
        self.ownList.removeObjects(in: hehe)
        
        let aDealer = dealer.reFormat()
        
        let inputPictures = aDealer!["input_picture"] as! NSArray
        
        for dict in inputPictures {
            let imageCell = NSMutableDictionary()
            
            imageCell.addEntries(from: dict as! [AnyHashable : Any])
            
            imageCell["ident"] = "QL_Image_Cell"
            
            imageCell["data"] = ""
            
            self.ownList.add(imageCell)
        }
        
        let inputItems = aDealer!["vat_pham"] as! NSArray
        
        let items = NSMutableArray.init(array: (Information.itemList as NSArray).withMutable())
        
        for dict in inputItems {
            for item in items {
                if (item as! NSDictionary)["title"] as? String ==  (dict as! NSDictionary)["title"] as? String {
                    (item as! NSMutableDictionary)["active"] = "1"
                }
            }
        }
        
//        let items = NSMutableArray()
//
//        for dict in inputItems {
//            for item in (Information.itemList as NSArray).withMutable() {
//                if (item as! NSDictionary)["title"] as? String ==  (dict as! NSDictionary)["title"] as? String {
//                    (item as! NSMutableDictionary)["active"] = "1"
//                    items.add(item)
//                } else {
//                    items.add(item)
//                }
//            }
//        }
        
        
        (self.ownList[5] as! NSMutableDictionary)["data"] = dealer.getValueFromKey("agency_code")
        
        (self.ownList[6] as! NSMutableDictionary)["data"] = dealer.getValueFromKey("address")
        
        (self.ownList[7] as! NSMutableDictionary)["data"] = dealer.getValueFromKey("agency_name")
        
        (self.ownList[8] as! NSMutableDictionary)["data"] = dealer.getValueFromKey("phonenumber")
        
        (self.ownList[9] as! NSMutableDictionary)["data"] = items
        
        (self.ownList[10] as! NSMutableDictionary)["data"] = dealer.getValueFromKey("ghi_chu")
        
        self.tableView.reloadData()
        
        self.tableView.action(forTouch: [:]) { (objc) in
            self.view.endEditing(true)
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.sectionHeaderHeight = UITableViewAutomaticDimension;
        self.tableView.estimatedSectionHeaderHeight = 69;
        
        kb = KeyBoard.shareInstance()
        
        self.tableView.withCell("QL_Code_Cell")
        self.tableView.withCell("TG_Room_Cell_N")
        self.tableView.withCell("QL_Drop_Cell")
        self.tableView.withCell("QL_Input_Cell")
        self.tableView.withCell("QL_Group_Cell")
        self.tableView.withCell("QL_Image_Cell")
        self.tableView.withCell("QL_Box_Cell")
        
        self.ownList.addObjects(from: (self.temp as NSArray).withMutable())
        
        self.theirList.addObjects(from: (self.temp1 as NSArray).withMutable())
        
        self.expandList.addObjects(from: (self.temp2 as NSArray).withMutable())

        didRequestRegion()
    }
    
    func dataList() -> NSMutableArray {
        if isEnemy == 1 {
            return self.ownList
        } else if isEnemy == 2 {
            return self.theirList
        } else {
            return self.expandList
        }
    }
    
    func getID(type: Int) -> String {
        let data = ((self.dataList()[type] as! NSDictionary)["data"] as! NSDictionary)
        
        if !data.response(forKey: "id") {
            return ""
        }
        let id = ((self.dataList()[type] as! NSDictionary)["data"] as! NSDictionary)["id"]
        
        return id as! String
    }
    
    func getNAME(type: Int) -> String {
        let data = ((self.dataList()[type] as! NSDictionary)["data"] as! NSDictionary)
        
        if !data.response(forKey: "title") {
            return ""
        }
        let id = ((self.dataList()[type] as! NSDictionary)["data"] as! NSDictionary)["title"]
        
        return id as! String
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        kb.keyboardOff()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        tableView.beginUpdates()
        
        tableView.endUpdates()
        
        kb.keyboard { (height, isOn) in
            self.tableView.contentInset = UIEdgeInsetsMake(0, 0, isOn ? (height) : 0, 0)
        }
    }
    
    @IBAction func didPressBack() {
        self.navigationController?.popViewController(animated: true)
    }
    
    func getDefault(array: NSArray, indexing: String) -> Int {
        var index = 0
        
        if self.tempEditData == nil {
            return index
        }
        
        for dict in array {
            if (dict as! NSDictionary).getValueFromKey("id") == indexing {
                index = array.index(of: dict)
                break
            }
        }
        
        return index
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
            
            var indexing = 0
            
            if self.tempEditData != nil {
                indexing = self.getDefault(array: self.regionList, indexing: self.editData.getValueFromKey("region_id"))
            }
            
            (self.ownList[0] as! NSMutableDictionary)["data"] = self.regionList.object(at: indexing)
            
            (self.theirList[0] as! NSMutableDictionary)["data"] = self.regionList.object(at: indexing)
            
            (self.expandList[0] as! NSMutableDictionary)["data"] = self.regionList.object(at: indexing)

            self.didRequestCity(region: (self.regionList.object(at: indexing) as! NSDictionary).getValueFromKey("id"))

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
                
                var indexing = 0
                
                if self.tempEditData != nil {
                    indexing = self.getDefault(array: self.cityList, indexing: self.editData.getValueFromKey("city_id"))
                }
                
                (self.ownList[1] as! NSMutableDictionary)["data"] = self.cityList.object(at: indexing)
                
                (self.theirList[1] as! NSMutableDictionary)["data"] = self.cityList.object(at: indexing)
                
                (self.expandList[1] as! NSMutableDictionary)["data"] = self.cityList.object(at: indexing)

                self.didRequestDistrict(city: (self.cityList.object(at: indexing) as! NSDictionary).getValueFromKey("id"))

            } else {
                self.cityList.addObjects(from: [["title":"Danh sách trống", "id":-1]])
                
                (self.ownList[1] as! NSMutableDictionary)["data"] = self.cityList.firstObject
                
                (self.theirList[1] as! NSMutableDictionary)["data"] = self.cityList.firstObject
                
                (self.expandList[1] as! NSMutableDictionary)["data"] = self.cityList.firstObject

                self.districtList.removeAllObjects()
                
                self.districtList.addObjects(from: [["title":"Danh sách trống", "id":-1]])
                
                (self.ownList[2] as! NSMutableDictionary)["data"] = self.districtList.firstObject
                
                (self.theirList[2] as! NSMutableDictionary)["data"] = self.districtList.firstObject
                
                (self.expandList[2] as! NSMutableDictionary)["data"] = self.districtList.firstObject
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
                
                var indexing = 0
                
                if self.tempEditData != nil {
                    indexing = self.getDefault(array: self.districtList, indexing: self.editData.getValueFromKey("district_id"))
                }
                
                (self.ownList[2] as! NSMutableDictionary)["data"] = self.districtList.object(at: indexing)
                
                (self.theirList[2] as! NSMutableDictionary)["data"] = self.districtList.object(at: indexing)
                
                (self.expandList[2] as! NSMutableDictionary)["data"] = self.districtList.object(at: indexing)
                
            } else {
                self.districtList.removeAllObjects()
                
                self.districtList.addObjects(from: [["title":"Danh sách trống", "id":-1]])
                
                (self.ownList[2] as! NSMutableDictionary)["data"] = self.districtList.firstObject
                
                (self.theirList[2] as! NSMutableDictionary)["data"] = self.districtList.firstObject
                
                (self.expandList[2] as! NSMutableDictionary)["data"] = self.districtList.firstObject
            }
            self.tableView.reloadData()
            
            self.didRequestAgency()
        }
    }
    
    @objc func didRequestAgency() {
        
        if self.tempEditData != nil {
            self.tempEditData = nil
        }
        
        let dict = ["CMD_CODE":"searchagency",
                    "user_id":INFO()["id"],
                    "page_size": self.pageSize,
                    "agency_type": isEnemy,
                    "module_id":3,
                    "city_id":self.getID(type: 1),
                    "district_id":self.getID(type: 2),
                    "region_id":self.getID(type: 0)]
        
        LTRequest.sharedInstance().didRequestInfo(["absoluteLink":"".urlGet(postFix: "processRequest"),
                                                   "header":["Authorization":Information.token == nil ? "" : Information.token!],
                                                   "Postparam":dict,
                                                   "overrideAlert":1,
                                                   "host":self,
                                                   "overrideLoading":1,
                                                   "postFix":"processRequest"
            ], withCache: { (cache) in
                
        }) { (response, errorCode, error, isValid) in
            
            if error != nil {
                
                return
            }
            
            if self.editData != nil {
                self.fillInDealer(dealer: (self.editData)!)
                
                return
            }
            
            let result = response?.dictionize()["RESULT"]
            
            if (result as! NSArray).count == 0 {
                
                self.dealerList.removeAllObjects()
                
                self.reset()
                
                return
            }
            
            self.dealerList.removeAllObjects()
            
            self.dealerList.addObjects(from: result as! [Any])
            
            let dealer = (result as! NSArray).firstObject
            
            self.fillInDealer(dealer: dealer as! NSDictionary)
        }
    }
    
    func reset() {
        
        (self.ownList[5] as! NSMutableDictionary)["data"] = ""
        
        (self.ownList[6] as! NSMutableDictionary)["data"] = ""
        
        (self.ownList[7] as! NSMutableDictionary)["data"] = ""
        
        (self.ownList[8] as! NSMutableDictionary)["data"] = ""
        
        (self.ownList[10] as! NSMutableDictionary)["data"] = ""
        
        var hehe = [Any]()
        
        for dict in self.ownList {
            if (dict as! NSDictionary)["ident"] as! String == "QL_Image_Cell" {
                hehe.append(dict)
            }
        }
        
        self.ownList.removeObjects(in: hehe)
        
        self.tableView.reloadData()
    }
    
    func getPicture() -> NSDictionary {
        
        let pictures = NSMutableArray()
        
        for dict in self.dataList() {
            
            let data = (dict as! NSDictionary)
            
            if data["ident"] as! String == "QL_Image_Cell" {
                
                pictures.add(["id":data["id"], "image_base64":data["data"], "title":data["title"]])
            }
        }
        
        return ["input_picture":pictures]
    }
    
    func getItem() -> NSDictionary {
        
        let items = NSMutableArray()
        
        if isEnemy == 2 {
            return ["vat_pham":items]
        }
        
        for dict in ((self.dataList()[9] as! NSDictionary)["data"] as! NSArray) {
            
            let data = (dict as! NSDictionary)
            
            if data.getValueFromKey("active") == "0" {
                continue
            }
            
            items.add(["id":"",
                       "type":data["data"],
                       "index_title": 0,
                       "index_type": 0,
                       "title":data["title"],
                       "popupType":0,
                       "isSelected":false,
                       "indexList":0
                ])
        }
        
        return ["vat_pham":items]
    }
    
    func prepAgencyInfor() -> NSDictionary {
        let agencyInfo = ["agencyinfo":["address":(self.dataList()[6] as! NSMutableDictionary)["data"],
                                        "agency_code": (self.dataList()[5] as! NSMutableDictionary)["data"],
                                        "agency_id": "",
                                        "agency_level": "",
                                        "agency_name": (self.dataList()[7] as! NSMutableDictionary)["data"],
                                        "agency_type": self.isEnemy,
                                        "city_id":self.getID(type: 1),
                                        "city_name": self.getNAME(type: 1),
                                        "district_id": self.getID(type: 2),
                                        "district_name": self.getNAME(type: 2),
                                        "doi_thu_lien_he": "",
                                        "ghi_chu": (self.dataList()[10] as! NSMutableDictionary)["data"],
                                        "hinh_thuc_cham_xoc": "",
                                        "id": self.editData != nil ? self.editData.getValueFromKey("id") : "0",
                                        "location": self.coor(),
                                        "ly_do_mat_quang_cao": "",
                                        "module_id": 1,
                                        "phonenumber": (self.dataList()[8] as! NSMutableDictionary)["data"],
                                        "region_id": self.getID(type: 0),
                                        "region_name": self.getNAME(type: 0),
                                        "status_code": "",
                                        "status_detail": "",
                                        "time_process": "",
                                        "id_job": self.tempData != nil ? (self.tempData.response(forKey: "id_job") ? self.tempData["id_job"] : 0) : 0
            ]]
        
        let agencyInfo1 = ["agencyinfo":["address":(self.dataList()[5] as! NSMutableDictionary)["data"],
                                        "agency_code": "",
                                        "agency_id": "",
                                        "agency_level": "",
                                        "agency_name": (self.dataList()[6] as! NSMutableDictionary)["data"],
                                        "agency_type": self.isEnemy,
                                        "city_id":self.getID(type: 1),
                                        "city_name": self.getNAME(type: 1),
                                        "district_id": self.getID(type: 2),
                                        "district_name": self.getNAME(type: 2),
                                        "doi_thu_lien_he": "",
                                        "ghi_chu": (self.dataList()[9] as! NSMutableDictionary)["data"],
                                        "hinh_thuc_cham_xoc": "",
                                        "id": self.editData != nil ? self.editData.getValueFromKey("id") : "0",
                                        "location": self.coor(),
                                        "ly_do_mat_quang_cao": "",
                                        "module_id": 1,
                                        "phonenumber": (self.dataList()[7] as! NSMutableDictionary)["data"],
                                        "region_id": self.getID(type: 0),
                                        "region_name": self.getNAME(type: 0),
                                        "status_code": "",
                                        "status_detail": "",
                                        "time_process": "",
                                        "id_job": self.tempData != nil ? (self.tempData.response(forKey: "id_job") ? self.tempData["id_job"] : 0) : 0
            ]]
        
        let agencyInfo2 = ["agencyinfo":["address":(self.dataList()[6] as! NSMutableDictionary)["data"],
                                        "agency_code": (self.dataList()[5] as! NSMutableDictionary)["data"],
                                        "agency_id": "",
                                        "agency_level": "",
                                        "agency_name": (self.dataList()[7] as! NSMutableDictionary)["data"],
                                        "agency_type": self.isEnemy,
                                        "city_id":self.getID(type: 1),
                                        "city_name": self.getNAME(type: 1),
                                        "district_id": self.getID(type: 2),
                                        "district_name": self.getNAME(type: 2),
                                        "doi_thu_lien_he": "",
                                        "ghi_chu": (self.dataList()[10] as! NSMutableDictionary)["data"],
                                        "hinh_thuc_cham_xoc": "",
                                        "id": self.editData != nil ? self.editData.getValueFromKey("id") : "0",
                                        "location": self.coor(),
                                        "ly_do_mat_quang_cao": "",
                                        "module_id": 1,
                                        "phonenumber": (self.dataList()[8] as! NSMutableDictionary)["data"],
                                        "region_id": self.getID(type: 0),
                                        "region_name": self.getNAME(type: 0),
                                        "status_code": "",
                                        "status_detail": "",
                                        "time_process": "",
                                        "id_job": self.tempData != nil ? (self.tempData.response(forKey: "id_job") ? self.tempData["id_job"] : 0) : 0,
                                        "phan cap dai ly":(self.dataList()[9] as! NSMutableDictionary)["data"]
            ]]

        return (isEnemy == 1 ? agencyInfo : isEnemy == 2 ? agencyInfo1 : agencyInfo2) as NSDictionary
    }
    
    @IBAction func didRequestUpdateAgency() {
        
        if isEnemy == 1 || isEnemy == 3 {
            if (self.dataList()[5] as! NSMutableDictionary).getValueFromKey("data") == "" {

                self.showToast("Chưa có mã đại lý", andPos: 0)

                return
            }
        }
        
        let updateData = NSMutableDictionary()
        
        let header = NSMutableDictionary()
        
        header.addEntries(from: self.prepAgencyInfor().reFormat() as! [AnyHashable : Any])
        
        (header["agencyinfo"] as! NSMutableDictionary).addEntries(from: self.getPicture() as! [AnyHashable : Any])
        
        (header["agencyinfo"] as! NSMutableDictionary).addEntries(from: self.getItem() as! [AnyHashable : Any])
        
        let dict = ["CMD_CODE":"updateagencyInfo",
                    "user_id":INFO()["id"],
                    "location": self.coor(),
                    "id": self.tempData != nil ? (self.tempData.response(forKey: "id_job") ? self.tempData["id_job"] : 0) : 0]
        
        updateData.addEntries(from: header as! [AnyHashable : Any])
        
        updateData.addEntries(from: dict)
        
        print(updateData)
        
        LTRequest.sharedInstance().didRequestInfo(["absoluteLink":"".urlGet(postFix: "processRequest"),
                                                   "header":["Authorization":Information.token == nil ? "" : Information.token!],
                                                   "Postparam":updateData,
                                                   "overrideAlert":1,
                                                   "host":self,
                                                   "overrideLoading":1,
                                                   "postFix":"processRequest"
            ], withCache: { (cache) in
                
        }) { (response, errorCode, error, isValid) in
            
            if error != nil {
                
                return
            }
            
            let result = response?.dictionize().getValueFromKey("ERR_CODE")
            
            if result == "0" {
                self.showToast("Cập nhật đại lý thành công", andPos: 0)
            }
            
            print(response)
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
        (self.dataList()[Int(indexing)!] as! NSMutableDictionary)["data"] = "data:image/png;base64,%@".format(parameters: image.imageString())
        
        self.tableView.reloadData()
    }
    
    func timerStart() {
        if timer != nil {
            
            timer.invalidate()
            
            timer = nil
        }

        timer = Timer.scheduledTimer(timeInterval: 2, target: self, selector:#selector(didRequestAgency), userInfo: nil, repeats: false)
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
        self.tableView.updateHeaderViewHeight()
    }
}

extension VN_Expand_ViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        
        return true
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        let indexing = Int(textField.accessibilityLabel!)
        
        if let text = textField.text as NSString? {
            let txtAfterUpdate = text.replacingCharacters(in: range, with: string)
            
            if textField.accessibilityValue == "timer" {
                self.pageSize = Int(txtAfterUpdate == "" ? "1" : txtAfterUpdate)!
                
                self.timerStart()
                
                return (txtAfterUpdate.count) > 0 && (txtAfterUpdate.count) < 5
            } else {
                (self.dataList()[indexing!] as! NSMutableDictionary)["data"] = txtAfterUpdate
            }
        }
        
        return true
    }
}

extension VN_Expand_ViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat
    {
        return CGFloat.leastNormalMagnitude
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat
    {
        return self.editData != nil ? UITableViewAutomaticDimension : CGFloat.leastNormalMagnitude
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = Bundle.main.loadNibNamed("TG_Menu_View", owner: self, options: nil)![5]
        
        if self.editData != nil {
            (self.withView(header, tag: 2) as! UILabel).text = self.editData["reject"] as? String
        }
        
        return header as? UIView
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        let data = self.dataList()[indexPath.row] as! NSDictionary
        
        if data["ident"] as! String == "QL_Image_Cell" {
            return data["data"] as! String == "" ? 55 : 234
        }
        
        return UITableViewAutomaticDimension
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.dataList().count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: (self.dataList()[indexPath.row] as! NSDictionary)["ident"] as! String, for: indexPath)
        
        let data = self.dataList()[indexPath.row] as! NSDictionary
        
        let title = self.withView(cell, tag: 1) as! UILabel
        
        title.text = data["title"] as? String
        
        if data["ident"] as! String == "QL_Input_Cell" {
            let input = (self.withView(cell, tag: 2) as! UITextField)
            
            let isNumber = data.response(forKey: "number")
            
            input.keyboardType = isNumber ? .numberPad : .default
            
            input.inputAccessoryView = isNumber ? self.toolBar() : nil

            input.accessibilityLabel = "%i".format(parameters: indexPath.row)
            
            input.accessibilityValue = data.response(forKey: "timer") ? "timer" : ""

            input.isEnabled = self.editData == nil //&& data.response(forKey: "timer"))
            
            if self.editData != nil && data.response(forKey: "timer") {
                input.isEnabled = false
            } else {
                input.isEnabled = true
            }
            
            input.delegate = self
            
            input.text = data.response(forKey: "timer") ? String(self.pageSize) : data["data"] as? String
        }
        
        if data["ident"] as! String == "QL_Drop_Cell" {
            
            let drop = (self.withView(cell, tag: 2) as! DropButton)
            
            let dropData = data["data"] as! NSDictionary
            
            if dropData.allValues.count != 0 {
                drop.setTitle(dropData["title"] as? String, for: .normal)
            }
            
            let array = indexPath.row == 0 ? self.regionList : indexPath.row == 1 ? self.cityList : self.districtList
            
            drop.action(forTouch: [:]) { (objc) in
                self.view.endEditing(true)
                drop.didDropDown(withData: array as! [Any], andCompletion: { (result) in
                    if result != nil {
                        let data = (result as! NSDictionary)["data"]
                        
                        if (data as! NSDictionary).getValueFromKey("id") == "-1" {
                            return
                        }
                        
                        
                        (self.ownList[indexPath.row] as! NSMutableDictionary)["data"] = data
                        
                        (self.theirList[indexPath.row] as! NSMutableDictionary)["data"] = data
                        
                        (self.expandList[indexPath.row] as! NSMutableDictionary)["data"] = data

                        
                        drop.setTitle((data as! NSDictionary)["title"] as? String, for: .normal)
                        
                        if indexPath.row == 0 {
                            self.didRequestCity(region: (data as! NSDictionary)["id"] as! String)
                        }
                        
                        if indexPath.row == 1 {
                            self.didRequestDistrict(city: (data as! NSDictionary)["id"] as! String)
                        }
                        
                        if indexPath.row == 2 {
                            self.didRequestAgency()
                        }
                        
                        self.tableView.reloadData()
                    }
                })
            }
        }
        
        if data["ident"] as! String == "QL_Box_Cell" {
            let drop = (self.withView(cell, tag: 2) as! DropButton)
            
            drop.isEnabled = self.editData == nil

            let dropData = data["data"] as! NSDictionary
            
            drop.setTitle(dropData["title"] as? String, for: .normal)
            
            drop.action(forTouch: [:]) { (objc) in
                self.view.endEditing(true)
                drop.didDropDown(withData: data["list"] as! [Any], andCompletion: { (result) in
                    if result != nil {
                        let out = (result as! NSDictionary)["data"]
                        
                        if !data.response(forKey: "enemy") {
                            self.isEnemy = (out as! NSDictionary)["id"] as! Int
                            
                        }
                        
                        (self.dataList()[indexPath.row] as! NSMutableDictionary)["data"] = out
                        
                        drop.setTitle((out as! NSDictionary)["title"] as? String, for: .normal)
                        
                        self.perform(#selector(self.didReloadData), with: nil, afterDelay: 0.5)
                    }
                })
            }
        }
        
        if data["ident"] as! String == "QL_Code_Cell" {
            let code = (self.withView(cell, tag: 2) as! UIButton)
            
            code.isEnabled = self.editData == nil

            let codeData = data["data"] as! String
            
            code.setTitle(codeData, for: .normal)
            
            code.action(forTouch: [:]) { (objc) in
                self.view.endEditing(true)
                let pop = TG_PopUp_View()
                
                pop?.delegate = self
                
                pop?.initWithCode(content: self.dealerList, finished: { (result) in
                    
                })
            }
        }
        
        if data["ident"] as! String == "TG_Room_Cell_N" {
            let items = (self.dataList()[indexPath.row] as! NSMutableDictionary)["data"] as! NSMutableArray
            
            (cell as! TG_Room_Cell_N).images = items
            
            (cell as! TG_Room_Cell_N).noShow = true

            (cell as! TG_Room_Cell_N).reload()
            
            let group = (self.withView(cell, tag: 2) as! UIImageView)
            
            (cell as! TG_Room_Cell_N).delegate = self
            
            group.action(forTouch: [:]) { (objc) in
                self.view.endEditing(true)
                TG_PopUp_View().initWithRemainItem(content: items, finished: { (result) in
                    
                    (self.dataList()[indexPath.row] as! NSMutableDictionary)["data"] = result
                    
                    (cell as! TG_Room_Cell_N).images = result
                    
                    (cell as! TG_Room_Cell_N).noShow = true

                    (cell as! TG_Room_Cell_N).reload()
                    
                    self.tableView.reloadData()
                })
            }
        }
        
        if data["ident"] as! String == "QL_Image_Cell" {
            
            let cam = (self.withView(cell, tag: 3) as! UIButton)
            
            cam.action(forTouch: [:]) { (objc) in
                
                self.view.endEditing(true)

                self.didAskForCamera(indexing: "%i".format(parameters: indexPath.row))
            }
            
            let image = (self.withView(cell, tag: 4) as! UIImageView)
            
            if data["data"] as! String != "" {
                image.image = (data["data"] as! NSString).replacingOccurrences(of: "data:image/png;base64,", with: "").stringImage()
            } else {
                image.image = nil
            }
        }
        
        return cell
    }
    
    func toolBar() -> UIToolbar {
        
        let toolBar = UIToolbar.init(frame: CGRect.init(x: 0, y: 0, width: Int(self.screenWidth()), height: 50))
        
        toolBar.barStyle = .default
        
        toolBar.items = [UIBarButtonItem.init(barButtonSystemItem: .flexibleSpace, target: nil, action: nil),
                         UIBarButtonItem.init(barButtonSystemItem: .flexibleSpace, target: nil, action: nil),
                         UIBarButtonItem.init(title: "Thoát", style: .done, target: self, action: #selector(disMiss))]
        return toolBar
    }
    
    @objc func disMiss() {
        self.view.endEditing(true)
    }
    
    @objc func didReloadData() {
        self.tableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

extension VN_Expand_ViewController: CellDelegate {
    func didReloadDataCell(data: NSMutableArray, indexing: Int) {
        (self.dataList()[indexing] as! NSMutableDictionary)["data"] = data
    }
}

extension VN_Expand_ViewController: CustomIOS7AlertViewDelegate {
    func customIOS7dialogButtonTouchUp(inside alertView: Any!, clickedButtonAt buttonIndex: Int) {
        
        let data = alertView as! NSDictionary
        
        self.fillInDealer(dealer: data)
    }
}
