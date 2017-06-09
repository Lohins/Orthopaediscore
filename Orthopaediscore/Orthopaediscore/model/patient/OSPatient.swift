//
//  OSPatient.swift
//  Orthopaediscore
//
//  Created by S.t on 2017/5/31.
//  Copyright © 2017年 S.t. All rights reserved.
//

import UIKit

class OSPatient: NSObject {
    var id: Int = -1
    var name: String = ""
    var sex: Int = -1  // 1 male, 0 female
    var height: Int = -1
    var age: Int = -1
    var weight: Int = -1
    var office: Int = -1
    var birthDate: Date?
    var admissDate: Date?
    var leaveDate: Date?
    var comment: String = ""
    var admissNote: String = ""
    var leaveNote: String = ""

    
    override init(){
    
    }
    
    init(longDict: Dictionary<String, Any>){
        if let ID = longDict["patientid"] as? Int{
            self.id = ID
        }
        if let Name = longDict["patientname"] as? String{
            self.name = Name
        }
        
        if let Office = longDict["office"] as? String{
            for key in OSAppCenter.sharedInstance.officeDict.keys{
                if Office == OSAppCenter.sharedInstance.officeDict[key]{
                    self.office = key
                }
            }
        }
        
        if let Comment = longDict["comment"] as? String{
            self.comment = Comment
        }
        if let text = longDict["admissionnote"] as? String{
            self.admissNote = text
        }
        if let text = longDict["leavenote"] as? String{
            self.leaveNote = text
        }
        
        if let dateStr = longDict["admissiondate"] as? String{
            let str = dateStr.replacingOccurrences(of: "T", with: " ")
            self.admissDate = str.toDate(with: "yyyy-MM-dd")
        }
        if let dateStr = longDict["leavedate"] as? String{
            let str = dateStr.replacingOccurrences(of: "T", with: " ")
            self.leaveDate = str.toDate(with: "yyyy-MM-dd")
        }
        if let dateStr = longDict["birthday"] as? String{
            let str = dateStr.replacingOccurrences(of: "T", with: " ")
            self.birthDate = str.toDate(with: "yyyy-MM-dd")
        }
        if let Weight = longDict["weight"] as? Int{
            self.weight = Weight
        }
        if let Height = longDict["weight"] as? Int{
            self.height = Height
        }
        if let Age = longDict["age"] as? Int{
            self.age = Age
        }
        if let Sex = longDict["sex"] as? Int{
            self.sex = Sex
        }
//        "leavedate": "2017-03-30",
//        "comment": "Please take care",
//        "admissionnote": "This patient is not good",
//        "weight": 77,
//        "age": 32,
//        "leavenote": "This patient is good",
//        "patientid": 6,
//        "height": 179,
//        "birthday": null,
//        "admissiondate": null,
//        "sex": 1,
//        "patientname": "mika",
//        "office": "foot"
    }
    
    init(shortDict: Dictionary<String, Any>){
        if let ID = shortDict["patientid"] as? Int{
            self.id = ID
        }
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
