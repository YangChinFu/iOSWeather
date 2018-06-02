//
//  WeatherCollectionViewCell.swift
//  WeatehrFinal
//
//  Created by FU_MAC on 2018/6/2.
//  Copyright © 2018年 FU_MAC. All rights reserved.
//

import UIKit

class WeatherCollectionViewCell: UICollectionViewCell {
    var imageView: UIImageView!
    var timeLabel: UILabel!
    var tempLabel: UILabel!
    
    override init(frame: CGRect) {
        super.init(frame:frame)
        
        let w = Double(UIScreen.main.bounds.size.width)
        
        timeLabel = UILabel(frame: CGRect(x: 0, y: 0, width: w/4 - 10.0 , height: 40.0))
        timeLabel.textAlignment = .center
        timeLabel.textColor = UIColor.orange
        self.addSubview(timeLabel)
        
        imageView = UIImageView(frame: CGRect(x: 0, y: 40, width: w/4 - 10.0, height: w/4 - 10.0))
        self.addSubview(imageView)
        
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
