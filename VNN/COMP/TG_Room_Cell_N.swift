//
//  TG_Room_Cell_N.swift
//  TourGuide
//
//  Created by Mac on 7/13/18.
//  Copyright © 2018 Mac. All rights reserved.
//

import UIKit

class TG_Room_Cell_N: UITableViewCell , TTGTagCollectionViewDelegate, TTGTagCollectionViewDataSource {

    @IBOutlet var collectionView: UICollectionView!
    
    @IBOutlet var tagCollectionView: TTGTagCollectionView!

    var dataList = NSMutableArray()
    
    var images: NSMutableArray!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        tagCollectionView.delegate = self;
        
        tagCollectionView.dataSource = self;
        
        tagCollectionView.scrollDirection = .horizontal
        
        self.reload()
    }
    
    func reload() {
        self.dataList.removeAllObjects()

        if images != nil {
            for dict in images {
                if (dict as! NSDictionary).getValueFromKey("active") == "1" {
                    self.dataList.add(self.contentView.newLabel(withText: "%@ %@".format(parameters: (dict as! NSDictionary)["title"] as! String, (dict as! NSDictionary)["data"] as! String)))
                }
            }
        }
        
        tagCollectionView.reload()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
    }
    
    func tagCollectionView(_ tagCollectionView: TTGTagCollectionView!, sizeForTagAt index: UInt) -> CGSize {
        return (self.dataList[Int(index)] as! UILabel).frame.size
    }
    
    func tagCollectionView(_ tagCollectionView: TTGTagCollectionView!, didSelectTag tagView: UIView!, at index: UInt) {
        
    }
    
    func numberOfTags(in tagCollectionView: TTGTagCollectionView!) -> UInt {
        return UInt(self.dataList.count)
    }
    
    func tagCollectionView(_ tagCollectionView: TTGTagCollectionView!, tagViewFor index: UInt) -> UIView! {
        
        let label = self.dataList[Int(index)] as! UILabel
        
        let button = self.withView(label, tag: 1000) as! UIButton
        
        button.action(forTouch: [:]) { (objc) in
            
            (self.images[Int(index)] as! NSMutableDictionary)["active"] = "0"
            
            print(index)
            
            self.reload()
        }
        
        return label
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
