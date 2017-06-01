//
//  String-Extension.swift
//  Orthopaediscore
//
//  Created by S.t on 2017/5/31.
//  Copyright © 2017年 S.t. All rights reserved.
//

import UIKit

extension String{
    func toDate(with dateFormat:String) -> Date?{
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = dateFormat
        let date = dateFormatter.date(from: self)
        return date
    }
    
    /*
     描述： 获取给定字号字体下 string所占有的size
     */
    static func getBound(_ string: String,size:CGSize , options: NSStringDrawingOptions , attributes: [String : AnyObject]?, context: NSStringDrawingContext?) -> CGRect {
        let text: NSString = NSString(cString: string.cString(using: String.Encoding.utf8)! , encoding:String.Encoding.utf8.rawValue)!
        
        let bound = text.boundingRect(with: size , options: options, attributes: attributes, context: context)
        
        return bound
    }
}
