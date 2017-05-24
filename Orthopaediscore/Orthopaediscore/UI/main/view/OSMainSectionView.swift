//
//  OSMainSectionView.swift
//  Orthopaediscore
//
//  Created by S.t on 2017/5/23.
//  Copyright © 2017年 S.t. All rights reserved.
//

import UIKit

class OSMainSectionView: UIView {
    
    
    var view: UIView!
    
    // override initializers
    override init(frame: CGRect) {
        super.init(frame: frame)
        xibSetup()
        setupUI()
    }
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
        xibSetup()
    }
    
    func xibSetup() {
        view = loadViewFromNib()
        view.frame = bounds
        view.autoresizingMask = [UIViewAutoresizing.flexibleWidth, UIViewAutoresizing.flexibleHeight]
        addSubview(view)
        
    }
    
    func loadViewFromNib()-> UIView{
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: "OSMainSectionView", bundle: bundle)
        let view = nib.instantiate(withOwner: self, options: nil)[0] as! UIView
        return view
    }


    @IBOutlet var iconImage: UIImageView!
    
    @IBOutlet var titleLabel: UILabel!
    
    
    func setupUI(){
        self.layer.borderColor = UIColor.white.cgColor
        self.layer.borderWidth = 3
        self.layer.cornerRadius = 10
    }
    
    func update(_ title: String , _ icon: UIImage){
        self.iconImage.image = icon
        self.titleLabel.text = title
    }
}
