//
//  TG_Room_Cell_N.swift
//  TourGuide
//
//  Created by Mac on 7/13/18.
//  Copyright © 2018 Mac. All rights reserved.
//

import UIKit

class TG_Room_Cell_N: UITableViewCell, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout  {

    @IBOutlet var collectionView: UICollectionView!

    var images: NSMutableArray? = ["sfdsfdsfds", "sfdsfdsf", "sfdsfdsfds", "sfdsfdsfdsfdsf", "sfdsfs", "sfdsfdsf", "sdfdsfdfsfsdfdsfdsfffdsfdsfsdfsdfsdfdsfsdfdsfdsfds"]
    
//    @IBOutlet var flowLayout: UICollectionViewFlowLayout!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        collectionView.withCell("TG_Room_Cell")
        
        let flowLayout = UICollectionViewFlowLayout()
        
        let w = collectionView.frame.width - 20
        
        flowLayout.estimatedItemSize = CGSize(width: w, height: 50)
        
//        flowLayout.scrollDirection = .horizontal
        
        collectionView.setCollectionViewLayout(flowLayout, animated: true)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
    }
        
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.images!.count
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0.0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0.0
    }
    
    func preferredLayoutAttributesFitting(_ layoutAttributes: UICollectionViewLayoutAttributes) -> UICollectionViewLayoutAttributes {
//        setNeedsLayout()
//        layoutIfNeeded()
        let size = contentView.systemLayoutSizeFitting(layoutAttributes.size)
        var frame = layoutAttributes.frame
        frame.size.width = ceil(size.width)
        layoutAttributes.frame = frame
        return layoutAttributes
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "TG_Room_Cell", for: indexPath as IndexPath)
        
        let tag = (self.withView(cell, tag: 1) as! UILabel)
        
        tag.text = images![indexPath.row] as? String
        
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
