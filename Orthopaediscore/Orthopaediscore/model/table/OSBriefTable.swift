//
//  OSBriefTable.swift
//  Orthopaediscore
//
//  Created by S.t on 2017/6/1.
//  Copyright © 2017年 S.t. All rights reserved.
//

import UIKit

/*
 说明 ： 使用的地方有 1.给病人分配量表， 2.让病人填写量表页面。
 */


class OSBriefTable: NSObject {
    
    var name: String = ""
    var id: Int  = -1
    var subTable = [OSBriefTable]()
    
    
    init(Name:String, ID: Int) {
        self.name = Name
        self.id = ID
    }
    
    
    // 初始化方法 ：分配量表的时候
    init(dict:Dictionary<String, Any>){
        if let Name = dict["subtablename"] as? String{
            self.name = Name
        }
        
        if let ID = dict["subtablid"] as? Int{
            self.id = ID
        }
    }
    
    class func parse(dictList: [Dictionary<String, Any>]) -> [OSBriefTable]{
        var result = [OSBriefTable]()
        for dict in dictList{
            if let mainTableName = dict["maintablename"] as? String, let mainTableId = dict["maintableid"] as? Int , let subDictList = dict["subtableinfo"] as? [Dictionary<String, Any>]{
                let mainTable = OSBriefTable.init(Name: mainTableName, ID: mainTableId)
                result.append(mainTable)
                
                for subDict in subDictList{
                    let subTable = OSBriefTable.init(dict: subDict)
                    mainTable.subTable.append(subTable)
                }
            }
        }
        return result
    }
}
