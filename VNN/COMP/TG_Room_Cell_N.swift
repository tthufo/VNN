//
//  TG_Room_Cell_N.swift
//  TourGuide
//
//  Created by Mac on 7/13/18.
//  Copyright © 2018 Mac. All rights reserved.
//

import UIKit

protocol CellDelegate:class {
    func didReloadDataCell(data: NSMutableArray, indexing: Int)
}

class TG_Room_Cell_N: UITableViewCell , TTGTagCollectionViewDelegate, TTGTagCollectionViewDataSource {

    weak var delegate: CellDelegate?

    @IBOutlet var collectionView: UICollectionView!
    
    @IBOutlet var tagCollectionView: TTGTagCollectionView!

    var dataList = NSMutableArray()
    
    var images: NSMutableArray!
    
    var noShow: Bool = false
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        tagCollectionView.delegate = self;
        
        tagCollectionView.dataSource = self;
        
        tagCollectionView.scrollDirection = .horizontal
        
        self.reload()
    }
    
    func reload() {
        self.dataList.removeAllObjects()
        
        if noShow {
            if images != nil {
                for dict in images {
                    if (dict as! NSDictionary).getValueFromKey("active") == "1" {
                        self.dataList.add(self.contentView.newLabel(withText: "%@".format(parameters: (dict as! NSDictionary)["title"] as! String), andHint: (dict as! NSDictionary).getValueFromKey("id")))
                    }
                }
            }
        } else {
            if images != nil {
                for dict in images {
                    if (dict as! NSDictionary).getValueFromKey("active") == "1" {
                        self.dataList.add(self.contentView.newLabel(withText: "%@ %@".format(parameters: (dict as! NSDictionary)["title"] as! String, (dict as! NSDictionary)["data"] as! String), andHint: (dict as! NSDictionary).getValueFromKey("id")))
                    }
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
                        
            for dict in self.images {
                if (dict as! NSDictionary).getValueFromKey("id") == label.accessibilityLabel {
                    (dict as! NSMutableDictionary)["active"] = "0"
                }
            }
            
            self.dataList.removeObject(at: Int(index))
            
            tagCollectionView.reload()
  
//            self.delegate?.didReloadDataCell(data: self.images, indexing: 8)

//            guard let cell1 = self.superview as? UITableView else {
//                let indexing = self.inDexOf(tagCollectionView, andTable: self.superview?.superview as! UITableView)
//
//                self.delegate?.didReloadDataCell(data: self.images, indexing: Int(indexing))
//
//                return
//            }
            
            
            
            let indexing = self.inDexOf(tagCollectionView, andTable: self.contentView.getTableView())

            self.delegate?.didReloadDataCell(data: self.images, indexing: Int(indexing))
        }
        
        return label
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
