//
//  VN_Home_ViewController.swift
//  VNN
//
//  Created by Thanh Hai Tran on 9/22/18.
//  Copyright © 2018 Thanh Hai Tran. All rights reserved.
//

import UIKit

class VN_Home_ViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    @IBOutlet var collectionView: UICollectionView!
    
    var timer: Timer?
    
    var images: NSMutableArray? = [["title":"Kiểm tra hình ảnh", "img":"ic_thuthap"],["title":"Chăm sóc đại lý", "img":"ic_suco"],["title":"Phát triển thị trường", "img":"ic_kiemtra"],["title":"Báo cáo chưa đạt", "img":"ic_kiemtra"]]
    
    let menuList: NSArray = [["title":"Đồng bộ danh mục", "ima":"ic_sync_home"], ["title":"Thay đổi địa chỉ máy chủ", "ima":"ic_change_server"], ["title":"Thay đổi mật khẩu", "ima":"ic_change_pass"], ["title":"Cài đặt", "ima":"ic_setting"], ["title":"Đăng xuất", "ima":"ic_logout"], ["title":"Thoát", "ima":"ic_exit"]]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.withCell("TG_Image_Cell")
        
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

        if indexPath.item == 3 {
            let info = VN_Report_ViewController()
            
            self.navigationController?.pushViewController(info, animated: true)
            
        } else {
            let info = VN_Picture_ViewController()
            
            self.navigationController?.pushViewController(info, animated: true)
            
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
