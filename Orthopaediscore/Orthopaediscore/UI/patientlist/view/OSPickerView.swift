//
//  OSPickerView.swift
//  Orthopaediscore
//
//  Created by S.t on 2017/5/29.
//  Copyright © 2017年 S.t. All rights reserved.
//

import UIKit
import BlocksKit

class OSPickerView: UIView {
    
    var picker: UIPickerView!
    
    var feedbackBlk: ((_ index:Int) -> Void )?
    
    weak var delegate:OSDropListView?
    
    // override initializers
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupUI()
    }
    
    init(frame: CGRect , delegate: OSDropListView){
        super.init(frame: frame)
        self.delegate = delegate
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupUI(){
        self.backgroundColor = UIColor.init(floatValueRed: 0, green: 0, blue: 0, alpha: 0.8)
        
        let button = UIButton.init(frame: self.frame)
        button.bk_(whenTapped: {[weak self] () -> Void in
            if let weakSelf = self{
                weakSelf.removeFromSuperview()
            }
        })
        self.addSubview(button)
        
        
        self.picker = UIPickerView.init(frame: CGRect.init(x: 0, y: 0, width: SCREENWIDTH, height: self.height / 3))
        self.picker.top = self.height / 2
        self.addSubview(self.picker)
        
        
        if let del = self.delegate{
            self.picker.delegate = del
            self.picker.dataSource = del
        }
        
        let doneButton = UIButton.init(frame: CGRect.init(x: 0, y: 0, width: SCREENWIDTH, height: 50))
        doneButton.setTitle("确定", for: .normal)
        doneButton.setTitleColor(UIColor.white, for: .normal)
        doneButton.titleLabel?.textAlignment = .center
        doneButton.bottom = self.picker.top

        doneButton.bk_(whenTapped: {[weak self] () -> Void in
            if let weakSelf = self{
                if let blk = weakSelf.feedbackBlk{
                    let index = weakSelf.picker.selectedRow(inComponent: 0)
                    blk(index)
                }
                weakSelf.removeFromSuperview()
                
            }
            

        })
        self.addSubview(doneButton)
    }
    
    func updateSelection(index: Int){
        if index < self.picker.numberOfComponents{
            self.picker.selectedRow(inComponent: index)
        }
    }
    
    
}
