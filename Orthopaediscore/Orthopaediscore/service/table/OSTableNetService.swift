//
//  TableService.swift
//  Orthopaediscore
//
//  Created by S.t on 2017/5/31.
//  Copyright © 2017年 S.t. All rights reserved.
//

import UIKit

class OSTableNetService: NSObject {
    
    // 根据表的id 获取 详细信息
    func getTableInfoBy(id: Int , finished : @escaping (_ list : [OSQuestion]? , _ error: Error?)-> Void){
        let url = BASEURL + "api/get_subtableinfo_by_subtable_id/"
        let params = ["data": [
            "subtableid" : id
            ]]
        
        OSBaseNetService.sharedInstance.postWithoutCache(url, params: params as Dictionary<String, AnyObject>?) { (dict, error) in
            if error != nil{
                return finished(nil , error)
            }
            
            if let data = dict{
                let list = OSQuestion.parse(dict: data)
                return finished(list , nil)
            }
            else{
                return finished(nil , nil)
            }
            
        }
    }

//    获取全部列表
    func getTableInfo(finished : @escaping (_ list : [OSBriefTable]? , _ error: Error?)-> Void){
        let url = BASEURL + "api/get_tableinfo/"
        
        OSBaseNetService.sharedInstance.getWithoutCache(url, params: nil) { (dict, error) in
            if error != nil{
                return finished(nil , error)
            }
            let status = dict?["status"] as! Int
            if status == 1{
                let data = dict?["data"] as! [Dictionary<String, Any>]
                let result = OSBriefTable.parse(dictList: data)
                return finished(result , nil)
            }
            else{
                return finished(nil , nil)
            }
        }
    }
    
    
//    给病人分配量表
    func assignTableToPatient(withID ID: Int, forTables tableIDs: [Int] , finished : @escaping (_ list : Bool , _ error: Error?)-> Void){
        let url = BASEURL + "api/give_table_to_patient/"
        let params = ["data" :
            [
                "patientid" : ID,
                "subtablelist" : tableIDs
            ]
        ]
        
        OSBaseNetService.sharedInstance.postWithoutCache(url, params: params as Dictionary<String, AnyObject>?) { (data, error) in
            if error != nil{
                return finished(false , error)
            }
            if let data = data, let status = data["status"] as? Int{
                if status == 1{
                    return finished(true , nil)
                }
                else{
                    return finished(false , NSError.init(domain: "Error occurs when assign tables to patient.", code: 0, userInfo: nil))
                }
            }else{
                    return finished(false , NSError.init(domain: "Error occurs when assign tables to patient.", code: 0, userInfo: nil))
            }
        }
    
    }
    
//    删除病人的某一张量表
    func deleteTableForPatient(withID ID : Int, withTableID tableID: Int, withTicket ticket: String,finished : @escaping (_ list : Bool , _ error: Error?)-> Void){
        let url = BASEURL + "api/delete_table_from_patient/"
        let params = [ "data" :
            [
                "patientid" : ID,
                "subtableid": tableID,
                "ticket" : ticket
            ]
        ]
        
        OSBaseNetService.sharedInstance.postWithoutCache(url, params: params as Dictionary<String, AnyObject>?) { (data, error) in
            if error != nil{
                return finished(false , error)
            }
            if let data = data, let status = data["status"] as? Int{
                if status == 1{
                    return finished(true , nil)
                }
                else{
                    return finished(false , NSError.init(domain: "Error occurs when delete tables to patient.", code: 0, userInfo: nil))
                }
            }else{
                return finished(false , NSError.init(domain: "Error occurs when delete tables to patient.", code: 0, userInfo: nil))
            }
        }
    }
    
}
