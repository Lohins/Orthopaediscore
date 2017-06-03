//
//  OSQuestionView.swift
//  Orthopaediscore
//
//  Created by S.t on 2017/6/1.
//  Copyright © 2017年 S.t. All rights reserved.
//

import UIKit

class OSQuestionView: UIView {
    
    let margin = CGFloat(15)
    
    let Width = SCREENWIDTH - CGFloat(15) * 2
    
    var choiceViewList = [OSQuestionChoiceCell]()
    
    var question: OSQuestion!
    
    init(frame: CGRect, Question: OSQuestion){
        super.init(frame: frame)
        self.question = Question
        
        self.setupUI()
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupUI(){
        
        let size = CGSize.init(width: Width, height: SCREENHEIGHT)
        
        
        let bound = String.getBound(self.question.content, size: size, options: .usesLineFragmentOrigin, attributes: [NSFontAttributeName : UIFont.init(name: "Helvetica", size: 17)!], context: nil)
        
        let titleLabel = UILabel.init(frame: CGRect.init(x: 0, y: 0, width: Width, height: bound.height))
        titleLabel.font = UIFont.init(name: "Helvetica", size: 17)
        titleLabel.textColor = UIColor.white
        titleLabel.text = self.question.content
        titleLabel.numberOfLines = 0
        titleLabel.textAlignment = .center
        titleLabel.top = 10
        titleLabel.lineBreakMode = .byWordWrapping
        
        let separateLine = UIView.init(frame: CGRect.init(x: 0, y: 0, width: Width, height: 1))
        separateLine.top = titleLabel.bottom + 5
        separateLine.backgroundColor = UIColor.white
        self.addSubview(separateLine)
        
        self.addSubview(titleLabel)
        var offset = titleLabel.bottom + 10
        for choice in self.question.choiceList{
            let view = OSQuestionChoiceCell.init(frame: CGRect.init(x: 0, y: 0, width: 0, height: 0))
            self.choiceViewList.append(view)
            view.update(content: choice.choicecontent, ID: choice.choiceid)
            view.top = offset
            offset = offset + view.height
            self.addSubview(view)
        }
        
        self.frame = CGRect.init(x: 0, y: 0, width: Width, height: offset + 10)
        self.layer.borderColor = UIColor.white.cgColor
        self.layer.borderWidth = 2
        self.layer.cornerRadius = 8
        
    }



}
