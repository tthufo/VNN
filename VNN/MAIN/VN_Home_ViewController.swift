//
//  VN_Home_ViewController.swift
//  VNN
//
//  Created by Thanh Hai Tran on 9/22/18.
//  Copyright © 2018 Thanh Hai Tran. All rights reserved.
//

import UIKit

class VN_Home_ViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    @IBOutlet var bottomView: UIView!
    
    @IBOutlet var overLay: UIButton!
    
    @IBOutlet var collectionView: UICollectionView!
    
    @IBOutlet var user: UILabel!
    
    var timer: Timer?
    
    var images: NSMutableArray? = [["title":"Kiểm tra hình ảnh", "img":"ic_thuthap"],["title":"Chăm sóc đại lý", "img":"ic_suco"],["title":"Phát triển thị trường", "img":"ic_kiemtra"],["title":"Báo cáo chưa đạt", "img":"ic_kiemtra"]]
    
    let menuList: NSArray = [["title":"Đồng bộ danh mục", "ima":"ic_sync_home"], ["title":"Thay đổi địa chỉ máy chủ", "ima":"ic_change_server"], ["title":"Thay đổi mật khẩu", "ima":"ic_change_pass"], ["title":"Cài đặt", "ima":"ic_setting"], ["title":"Đăng xuất", "ima":"ic_logout"], ["title":"Thoát", "ima":"ic_exit"]]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.withCell("TG_Image_Cell")
        
        didRequestInfo()
        
        user.text = "User: %@".format(parameters: Information.userInfo?["username"] as! CVarArg)
        
        bottomView.frame = CGRect.init(x: 0, y: CGFloat(self.screenHeight() - 0), width: CGFloat(self.screenWidth()), height: 50)
        
        self.view.addSubview(bottomView)
        
        
        overLay.frame = CGRect.init(x: 0, y: 0, width: CGFloat(self.screenWidth()), height: CGFloat(self.screenHeight() - 0))
        
        overLay.backgroundColor = UIColor.black
        
        overLay.alpha = 0.6
        
        overLay.action(forTouch: [:]) { (objc) in
            self.didPressLogOut()
            
            self.view.endEditing(true)
        }
        
        (self.withView(bottomView, tag: 1) as! UIButton).action(forTouch: [:]) { (objc) in
            exit(0)
        }
        
        (self.withView(bottomView, tag: 2) as! UIButton).action(forTouch: [:]) { (objc) in
            
            self.navigationController?.popToRootViewController(animated: true)
            
            Information.removeInfo()
        }
    }
    
    @IBAction func didPressLogOut() {
        self.view.endEditing(true)
        
        UIView.animate(withDuration: 0.3, animations: {
            
            var frame = self.bottomView.frame
            
            frame.origin.y -= frame.origin.y == CGFloat(self.screenHeight()) ? 50 : -50
            
            self.bottomView.frame = frame
            
        }) { (done) in
            
            let frame = self.bottomView.frame
            
            if frame.origin.y == CGFloat(self.screenHeight()) {
                self.overLay.removeFromSuperview()
            } else {
                self.view.insertSubview(self.overLay, belowSubview: self.bottomView)
            }
        }
    }
    
    func didRequestInfo() {
        LTRequest.sharedInstance().didRequestInfo(["absoluteLink":"".urlGet(postFix: "processRequest"),
                                                   "header":["Authorization":Information.token == nil ? "" : Information.token!],
                                                   "Postparam":["CMD_CODE":"getappinfo","platform":"ios"],
                                                   "overrideLoading":1,
                                                   "overrideAlert":1,
                                                   "host":self,
                                                   "postFix":"processRequest"
            ], withCache: { (cache) in
                
        }) { (response, errorCode, error, isValid) in
            
            print(response)
            
        }
    }
    
    @IBAction func didPressMenu(menu: DropButton) {
        menu.didDropDown(withData: menuList as! [Any], andInfo: ["rect":CGRect.init(x: Int(self.screenWidth() - 225), y: -135, width: 225, height: 200)]) { (objc) in
            
            if objc == nil {
                return
            }
            
            let indexing = (objc as! NSDictionary)["index"]
            
            switch (indexing as AnyObject).integerValue {
            case 0:
            
                break
            case 1:
                //self.navigationController?.pushViewController(TL_ChangeHost_ViewController(), animated: true)
                break
            case 2:
                //self.navigationController?.pushViewController(QL_Recover_ViewController(), animated: true)
                break
            case 3:
                //self.navigationController?.pushViewController(QL_Setting_ViewController(), animated: true)
                break
            case 4:
                self.navigationController?.popToRootViewController(animated: true)
                
                Information.removeInfo()
                break
            case 5:
                exit(0)
                break
            default :
                break
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.images!.count
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: Int(screenWidth()/2 - 20), height: Int(screenWidth()/2 - 20) + 30)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0.0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0.0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "TG_Image_Cell", for: indexPath as IndexPath)
        
        let dict = images![indexPath.item] as! NSDictionary
        
        let image = (self.withView(cell, tag: 11) as! UIImageView)
        
        image.withBorder(["Bwidth":"3", "Bcolor":UIColor.red])
        
        image.image = UIImage.init(named: dict["img"] as! String)
        
        (self.withView(cell, tag: 12) as! UILabel).text = dict["title"] as? String
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {

        switch indexPath.item {
        case 0:
            if INFO().getValueFromKey("type") == "4" {
                self.showToast("Bạn không đường quyền truy cập chức năng này", andPos: 0)
                
                return
            }
            
            self.navigationController?.pushViewController(VN_Picture_ViewController(), animated: true)
            break
        case 1:
            if INFO().getValueFromKey("type") == "2" {
                self.showToast("Bạn không đường quyền truy cập chức năng này", andPos: 0)
                
                return
            }
            self.navigationController?.pushViewController(VN_Care_ViewController(), animated: true)
            break
        case 2:
            if INFO().getValueFromKey("type") == "2" {
                self.showToast("Bạn không đường quyền truy cập chức năng này", andPos: 0)
                
                return
            }
            self.navigationController?.pushViewController(VN_Expand_ViewController(), animated: true)
            break
        case 3:
            self.navigationController?.pushViewController(VN_Report_ViewController(), animated: true)
            break
        default:
            break
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
