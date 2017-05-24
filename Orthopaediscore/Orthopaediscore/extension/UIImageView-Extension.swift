//
//  UIImageView-Extension.swift
//  UBIEAT
//
//  Created by UBIELIFE on 2016-08-13.
//  Copyright © 2016 UBIELIFE Inc. All rights reserved.
//

import UIKit

extension UIImageView{
    class func imageChangeSize(_ original: UIImage , size: CGSize) -> UIImage{
        
        UIGraphicsBeginImageContextWithOptions(size, false, 0.0)
        original.draw(in: CGRect(x: 0, y: 0, width: size.width, height: size.height))
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return newImage!
    }
}
