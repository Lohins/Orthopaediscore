//
//  OSUserService.swift
//  Orthopaediscore
//
//  Created by S.t on 2017/6/7.
//  Copyright © 2017年 S.t. All rights reserved.
//

import UIKit

class OSUserService: NSObject {

    
    func doctorLogin(email: String, pwd: String, finish: @escaping (_ status: Bool, _ error : Error?) -> Void){
        
        let url = BASEURL + "api/doctor_login/"
        let params = [
            "data" :[
                "email" : email,
                "passwd" : pwd
            ]
        ]
        
        OSBaseNetService.sharedInstance.postWithoutCache(url, params: params as Dictionary<String, AnyObject>?) { (data, error) in
            if error != nil{
                return finish(false , error)
            }
            
            if let data = data, let status = data["status"] as? Int{
                if status == 1{
                    let subData = data["data"] as! Dictionary<String, Any>
                    let userid = subData["userid"] as! Int
                    return finish(true , error)
                }
                else{
                    let subData = data["data"] as! Dictionary<String, Any>
                    let msg = subData["msg"] as! String
                    return finish(false , NSError.init(domain: msg, code: 0, userInfo: nil))

                }
                
                
            }
            else{
                return finish(false , NSError.init(domain: "Network Error", code: 0, userInfo: nil))

            }
        }
    }
}
