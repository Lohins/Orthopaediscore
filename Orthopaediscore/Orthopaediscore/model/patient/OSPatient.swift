//
//  OSPatient.swift
//  Orthopaediscore
//
//  Created by S.t on 2017/5/31.
//  Copyright © 2017年 S.t. All rights reserved.
//

import UIKit

class OSPatient: NSObject {
    var name: String = ""
    var sex: Int = -1
    var height: Int = -1
    var age: Int = -1
    var weight: Int = -1
    var office: Int = -1
    var birthDate: Date?
    var admissDate: Date?
    var leaveDate: Date?
    var comment: String = ""
    
    override init(){
    
    }
    
    init(dict: Dictionary<String, Any>){
    
    }
    
    init(shortDict: Dictionary<String, Any>){
        if let Name = shortDict["name"] as? String{
            self.name = Name
        }
        
        if let Office = shortDict["office"] as? Int{
            self.office = Office
        }
        
        if let Comment = shortDict["comment"] as? String{
            self.comment = Comment
        }
        
        if let dateStr = shortDict["admissdate"] as? String{
            let str = dateStr.replacingOccurrences(of: "T", with: " ")
            self.admissDate = str.toDate(with: "yyyy-MM-dd hh:mm:ss")
        }
        if let dateStr = shortDict["leavedate"] as? String{
            let str = dateStr.replacingOccurrences(of: "T", with: " ")
            self.leaveDate = str.toDate(with: "yyyy-MM-dd hh:mm:ss")
        }
    }
}
