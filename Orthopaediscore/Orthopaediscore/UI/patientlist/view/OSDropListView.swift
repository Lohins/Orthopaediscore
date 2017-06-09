//
//  OSDropListView.swift
//  Orthopaediscore
//
//  Created by S.t on 2017/5/29.
//  Copyright © 2017年 S.t. All rights reserved.
//

import UIKit

class OSDropListView: UIView {

    var view: UIView!
    
    var picker: OSPickerView!
    
    var title: String = ""
    
    @IBOutlet var contentLabel: UILabel!
    
    @IBOutlet var titleLabel: UILabel!
    var dataList = [String]()
    
    // override initializers
    override init(frame: CGRect) {
        super.init(frame: frame)
        xibSetup()
    }
    
    init(frame: CGRect , title:String , datalist: [String]) {
        super.init(frame: frame)
        self.dataList = datalist
        xibSetup()
        self.picker = OSPickerView.init(frame: CGRect.init(x: 0, y: 0, width: SCREENWIDTH, height: SCREENHEIGHT - STATUSBARHEIGHT - NAVIGATIONBARHEIGHT), delegate: self)
        self.picker.feedbackBlk = {[weak self](index) -> Void in
            if let weakSelf = self{
                weakSelf.contentLabel.text = weakSelf.dataList[index]
            }
        }
        

        self.title = title
        self.titleLabel.text = self.title + " : "
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
        let nib = UINib(nibName: "OSDropListView", bundle: bundle)
        let view = nib.instantiate(withOwner: self, options: nil)[0] as! UIView
        return view
    }
    
    func setupUI(){
    }
    
    func updateContent(text: String){
        if let index = self.dataList.index(of: text){
            self.contentLabel.text = text
            self.picker.updateSelection(index: index)
        }
    }
    
    func getContent() -> String?{
        if let text = self.contentLabel.text{
            return text
        }
        else{
            OSAppCenter.sharedInstance.InfoNotification(vc: self.getCurrentViewController()!, title: "提示", message: "请选择" + self.titleLabel.text!)
            return nil
        }
    }
    
    
    @IBAction func tapAction(_ sender: Any) {
        self.getCurrentViewController()?.view.addSubview(self.picker)
    }
}


extension OSDropListView: UIPickerViewDelegate , UIPickerViewDataSource{
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return self.dataList.count
    }
    
//    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
//        return self.dataList[row]
//    }
    
    func pickerView(_ pickerView: UIPickerView, attributedTitleForRow row: Int, forComponent component: Int) -> NSAttributedString? {
        return NSAttributedString.init(string: self.dataList[row], attributes: [NSForegroundColorAttributeName: UIColor.white])
    }
}
