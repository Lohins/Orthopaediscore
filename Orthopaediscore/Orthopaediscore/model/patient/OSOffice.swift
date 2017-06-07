//
//  OSOffice.swift
//  Orthopaediscore
//
//  Created by S.t on 2017/6/7.
//  Copyright © 2017年 S.t. All rights reserved.
//

import UIKit

class OSOffice: NSObject {
    
    var name: String = ""
    var id : Int = -1
    init(dict: Dictionary<String, Any>) {
        if let Name = dict["officename"] as? String{
            self.name = Name
        }
        if let ID = dict["officeid"] as? Int{
            self.id = ID
        }
    }

}
