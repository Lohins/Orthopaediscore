//
//  UBILinearScrollView.swift
//  UBIEAT
//
//  Created by UBIELIFE on 2016-09-17.
//  Copyright © 2016 UBIELIFE Inc. All rights reserved.
//

import UIKit
import TPKeyboardAvoiding

class LinearScrollView: TPKeyboardAvoidingScrollView {
    
    // variables
    
    var items: [LinearScrollViewItem] = [LinearScrollViewItem]()
    
    var autoAdjustFrameSize: Bool!
    
    var autoAdjustContentSize: Bool!
    
    var minContentSizeHeight: CGFloat!
    
    
    
    // MARK init methods
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.autoAdjustFrameSize = false
        self.autoAdjustContentSize = true
        self.autoresizesSubviews = false
        
        self.backgroundColor = UIColor.clear
        self.showsVerticalScrollIndicator = false
        self.showsHorizontalScrollIndicator = false
        
        self.minContentSizeHeight = 0
    }
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
        self.autoAdjustFrameSize = false
        self.autoAdjustContentSize = true
        self.autoresizesSubviews = false
        
        self.backgroundColor = UIColor.clear
        self.showsVerticalScrollIndicator = false
        self.showsHorizontalScrollIndicator = false
        
        self.minContentSizeHeight = 0
        
        
    }
//    required init?(coder aDecoder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
    
    func setMinHeight(_ height: CGFloat){
        self.minContentSizeHeight = height
    }
    
    // MARK action
    
    func linear_addSubview(_ view: UIView , paddingTop:CGFloat, paddingBottom: CGFloat){
        
        let item = LinearScrollViewItem.init(view: view, paddingTop: paddingTop, paddingBottom: paddingBottom)
        self.items.append(item)
        super.addSubview(view)
        
        if self.autoAdjustFrameSize == true{
            self.resetFrameSize()
        }
        
        if self.autoAdjustContentSize == true{
            self.resetContentSize()
        }
        
        self.linear_updateDisplay()
        
    }
    
    func linear_removeView(_ view: UIView){
        var target: LinearScrollViewItem?
        for item in self.items {
            if item.view == view {
                target = item
                continue
            }
        }
        if let item = target{
            item.view.removeFromSuperview()
            self.items.remove(at: self.items.index(of: item)!)
            self.linear_updateDisplay()
        }
    }
    
    func linear_removeViewAtIndex(_ index: Int){
        if index >= self.items.count {
            return
        }
        let item = self.items[index]
        item.view.removeFromSuperview()
        self.items.remove(at: index)
        self.linear_updateDisplay()
    }
    
    func linear_removeAllSubviews(){
        for item in self.items {
            item.view.removeFromSuperview()
        }
        self.items.removeAll()
        self.linear_updateDisplay()
    }
    
    func liear_replaceWithItems(_ items: [LinearScrollViewItem]){
        self.linear_removeAllSubviews()
        self.items = items
        self.linear_updateDisplay()
    }
    
    func linear_insertViewAtIndex(_ index: Int , view: UIView , paddingTop: CGFloat, paddingBottom: CGFloat){
        if index >= self.items.count {
            return
        }
        
        if let parent = view.superview{
            if parent == self{
                return
            }
        }
        
        let item = LinearScrollViewItem.init(view: view, paddingTop: paddingTop, paddingBottom: paddingBottom)
        super.addSubview(view)
        self.items.insert(item, at: index)
        self.linear_updateDisplay()
    }
    
    func linear_insertView(before previousView: UIView, for targetView: UIView,paddingTop: CGFloat, paddingBottom: CGFloat){
        var previousItem: LinearScrollViewItem?
        for item in self.items{
            if item.view == previousView{
                previousItem = item
                continue
            }
        }
        
        if let item  = previousItem{
            let index = self.items.index(of: item)
            let newItem = LinearScrollViewItem.init(view: targetView, paddingTop: paddingTop, paddingBottom: paddingBottom)
            self.items.insert(newItem, at: index! + 1)
            super.addSubview(targetView)
            self.linear_updateDisplay()
            
        }
    }
    
    func linear_updateDisplay(){
        var curBottom: CGFloat = 0
        
        for item in self.items {
            if item.view.isHidden == true {
                continue
            }
            curBottom = curBottom + item.paddingTop
            item.view.top = curBottom
            curBottom = curBottom + item.paddingBottom + item.view.height
        }
        
        let suitable = max(curBottom, self.minContentSizeHeight)
        self.contentSize = CGSize(width: self.frame.size.width, height: suitable)
    }
    
    
    // MARK reset size methods
    
    func resetFrameSize(){
        self.frame = CGRect(x: self.frame.origin.x, y: self.frame.origin.y, width: self.frame.size.width, height: self.layoutOffset())
        
        print(self.frame)
    }

    func resetContentSize(){
        
        var width = CGFloat(0)
        if self.frame.size.width > SCREENWIDTH{
            width = SCREENWIDTH
        }
        else{
            width = self.frame.size.width
        }
        
        //let curOffset = self.layoutOffset()
        //let suitable = max(curOffset, self.minContentSizeHeight)
        var suitable = self.layoutOffset()
        if suitable - self.minContentSizeHeight < 0{
            suitable = minContentSizeHeight
        }
        self.contentSize = CGSize(width: width, height: suitable)
        print(self.frame)

        print(self.contentSize)
        
    }
    
    func layoutOffset() -> CGFloat{
        var curOffset: CGFloat = 0
        
        for item in self.items {
            if item.view.isHidden == true{
                continue
            }
            curOffset = curOffset + item.paddingTop + item.paddingBottom + item.view.height
        }
        return curOffset
    }
}
