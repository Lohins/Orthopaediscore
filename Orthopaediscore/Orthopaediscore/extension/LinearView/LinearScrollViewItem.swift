//
//  UBILinearItem.swift
//  UBIEAT
//
//  Created by UBIELIFE on 2016-09-17.
//  Copyright © 2016 UBIELIFE Inc. All rights reserved.
//

import UIKit

class LinearScrollViewItem: NSObject {
    
    var view: UIView!
    
    var paddingTop: CGFloat!
    
    var paddingBottom: CGFloat!
    
    var tag: NSInteger!
    
    init(view: UIView, paddingTop: CGFloat , paddingBottom: CGFloat){
        self.view = view
        self.paddingTop = paddingTop
        self.paddingBottom = paddingBottom
    }

}
