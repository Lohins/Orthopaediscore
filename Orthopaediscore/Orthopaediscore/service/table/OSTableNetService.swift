//
//  TableService.swift
//  Orthopaediscore
//
//  Created by S.t on 2017/5/31.
//  Copyright © 2017年 S.t. All rights reserved.
//

import UIKit

class OSTableNetService: NSObject {

    
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
}
