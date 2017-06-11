//
//  OSQuestionChoiceCell.swift
//  Orthopaediscore
//
//  Created by S.t on 2017/6/1.
//  Copyright © 2017年 S.t. All rights reserved.
//

import UIKit

class OSQuestionChoiceCell: UIView {
    
    
    var view: UIView!

    
    // override initializers
    override init(frame: CGRect) {
        super.init(frame: frame)
        xibSetup()
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
        let nib = UINib(nibName: "OSQuestionChoiceCell", bundle: bundle)
        let view = nib.instantiate(withOwner: self, options: nil)[0] as! UIView
        return view
    }
    
    @IBOutlet var contentLabel: UILabel!
    @IBOutlet var iconImageView: UIImageView!
    
    var choiceID: Int  = -1
    var selection: Bool = false
    var tapBlock: ((_ target: OSQuestionChoiceCell) -> Void)?

    func update(content: String, ID: Int){
        self.choiceID = ID
        self.contentLabel.text = content
        self.contentLabel.font = UIFont.init(name: "Helvetica", size: 17)
        
        let size = CGSize.init(width: SCREENWIDTH - 30 - 43, height: SCREENHEIGHT)
        let bound = String.getBound(content, size: size, options: .usesLineFragmentOrigin, attributes: [NSFontAttributeName: UIFont.init(name: "Helvetica", size: 17)!], context: nil)
        
        var suitableH = CGFloat(40)
        if bound.height > 40 {
            suitableH = bound.height
        }
        
        self.frame = CGRect.init(x: 0, y: 0, width: SCREENWIDTH - 30, height: suitableH)
        
    }
    
    func unselect(){
        self.selection = false
        self.iconImageView.image = UIImage.init(named: "radio_unselect_icon")
    }
    
    @IBAction func tapAction(_ sender: Any) {
        self.selection = !self.selection
        if self.selection == true{
            self.iconImageView.image = UIImage.init(named: "radio_select_icon")
            if let blk = self.tapBlock{
                blk(self)
            }
        }
        else{
            self.iconImageView.image = UIImage.init(named: "radio_unselect_icon")
        }
    }
    

}
