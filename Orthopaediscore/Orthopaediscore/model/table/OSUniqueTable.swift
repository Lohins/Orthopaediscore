//
//  OSUniqueTable.swift
//  Orthopaediscore
//
//  Created by S.t on 2017/6/3.
//  Copyright © 2017年 S.t. All rights reserved.
//

import UIKit

class OSUniqueTable: NSObject {
    //"subtablename": "Foot & Ankle Disability index",
    //"ticket": "91089fb3-2a51-4650-8e1f-87cae8efb414",
    //"subtableid": 4,
    //"patientid": 1,
    //"handoutdate": "2017-05-28"
    
    var tableName: String = ""
    var ticket: String = ""
    var tableId : Int  = -1
    var patientId : Int = -1
    var handoutDate: String = ""
    
    init(uniqueDict: Dictionary<String, Any>){
        if let Name = uniqueDict["subtablename"] as? String{
            self.tableName = Name
        }
        if let Ticket = uniqueDict["ticket"] as? String{
            self.ticket = Ticket
        }
        if let TableId = uniqueDict["subtableid"] as? Int{
            self.tableId = TableId
        }
        if let PatientID = uniqueDict["patientid"] as? Int{
            self.patientId = PatientID
        }
        if let HandoutDate = uniqueDict["handoutdate"] as? String{
            self.handoutDate = HandoutDate
        }
        
    }

}
