//
//  OSTimePickerView.swift
//  Orthopaediscore
//
//  Created by S.t on 2017/5/29.
//  Copyright © 2017年 S.t. All rights reserved.
//

import UIKit

class OSTimePickerView: UIView {
    
    var block : ((_ str: String)-> Void)?
    
    var datePicker: UIDatePicker!
    
    var selectedDate: Date?

    // override initializers
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupUI(){
        self.backgroundColor = UIColor.init(floatValueRed: 0, green: 0, blue: 0, alpha: 0.8)
        
        self.datePicker = UIDatePicker.init(frame: CGRect.init(x: 0, y: 0, width: SCREENWIDTH, height: self.height / 3))
//        self.datePicker.top = self.height / 2
        self.datePicker.bottom = self.height
        self.datePicker.datePickerMode = .date
        self.datePicker.locale = Locale.init(identifier: "zh_CN")
        self.datePicker.setValue(UIColor.white, forKey: "textColor")
        self.addSubview(self.datePicker)
        self.datePicker.backgroundColor = UIColor.lightGray
        
        let doneButton = UIButton.init(frame: CGRect.init(x: 0, y: 0, width: 80, height: 50))
        doneButton.setTitleColor(UIColor.white, for: .normal)
        doneButton.setTitle("确定", for: .normal)
        doneButton.center = CGPoint.init(x: SCREENWIDTH / 2, y: SCREENHEIGHT / 2)
        doneButton.bottom = datePicker.top
        doneButton.addTarget(self, action: #selector(dateChanged), for: .touchUpInside)
        self.addSubview(doneButton)

    }
    
    func updateDate(date: Date){
        self.selectedDate = date
        self.datePicker.setDate(date, animated: true)
    }
    
    func getDate() -> Date?{
        
        return self.selectedDate
    }
    
    func dateChanged() {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy年MM月dd日"
        let dateStr = formatter.string(from: self.datePicker.date)
        if let blk = self.block{
            blk(dateStr)
        }
        
        self.selectedDate = self.datePicker.date
        
        self.removeFromSuperview()
    }

}
