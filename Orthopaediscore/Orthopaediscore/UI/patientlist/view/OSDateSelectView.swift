//
//  OSDateSelectView.swift
//  Orthopaediscore
//
//  Created by S.t on 2017/5/29.
//  Copyright © 2017年 S.t. All rights reserved.
//

import UIKit

class OSDateSelectView: UIView {
    
    var view: UIView!
    
    var timePicker: OSTimePickerView!

    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var contentLabel: UILabel!
    
    // override initializers
    override init(frame: CGRect) {
        super.init(frame: frame)
        xibSetup()
    }
    
    init(frame: CGRect , title: String) {
        super.init(frame: frame)
        xibSetup()
        
        self.titleLabel.text = title + " : "
        
        self.timePicker = OSTimePickerView.init(frame: CGRect.init(x: 0, y: 0, width: SCREENWIDTH, height: SCREENHEIGHT - STATUSBARHEIGHT - NAVIGATIONBARHEIGHT))
        self.timePicker.block = { [weak self] (str) -> Void in
            if let weakSelf = self{
                weakSelf.contentLabel.text = str
            }
        }
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
        let nib = UINib(nibName: "OSDateSelectView", bundle: bundle)
        let view = nib.instantiate(withOwner: self, options: nil)[0] as! UIView
        return view
    }

    
    @IBAction func tapAction(_ sender: Any) {
        self.getCurrentViewController()?.view.addSubview(self.timePicker)
    }
    

}
