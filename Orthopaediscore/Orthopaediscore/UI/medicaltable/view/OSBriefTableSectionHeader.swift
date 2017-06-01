//
//  OSBriefTableSectionHeader.swift
//  Orthopaediscore
//
//  Created by S.t on 2017/6/1.
//  Copyright © 2017年 S.t. All rights reserved.
//

import UIKit

class OSBriefTableSectionHeader: UIView {
    static let Height = CGFloat(45)

    var titleLabel: UILabel!
    
    class func factory() -> OSBriefTableSectionHeader{
        return OSBriefTableSectionHeader.init(frame: CGRect.init(x: 0, y: 0, width: SCREENWIDTH, height: Height))
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func updateTitle(title: String){
        self.titleLabel.text = title
    }
    
    func setupUI(){
        let label = UILabel.init(frame: CGRect.init(x: 5, y: 0, width: 30, height: self.height))
        label.text = "类:"
        label.textAlignment = .center
        label.font = UIFont.init(name: "System-Regular", size: 17)
        label.textColor = UIColor.white
        
        self.titleLabel = UILabel.init(frame: CGRect.init(x: 0, y: 0, width: SCREENWIDTH - 52, height: self.height))
        self.titleLabel.left = label.right + 17
        self.titleLabel.textColor = UIColor.white
        self.titleLabel.font = UIFont.init(name: "System-Regular", size: 17)
        
        let bottomLine = UIView.init(frame: CGRect.init(x: 0, y: 0, width: SCREENWIDTH, height: 1))
        bottomLine.backgroundColor = UIColor.white
        bottomLine.bottom = self.height
        
        
        self.addSubview(label)
        self.addSubview(self.titleLabel)
        self.addSubview(bottomLine)

    }

}
