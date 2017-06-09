//
//  OSPatientService.swift
//  Orthopaediscore
//
//  Created by S.t on 2017/6/7.
//  Copyright © 2017年 S.t. All rights reserved.
//

import UIKit

class OSPatientService: NSObject {

    // 获取科室信息，用于添加病人页面。
    func getOffice(finish:@escaping (_ list: [OSOffice]? , _ error: Error?) -> Void){
        let url = BASEURL + "api/get_office/"
        
        OSBaseNetService.sharedInstance.getWithoutCache(url, params: nil) { (data, error) in
            if error != nil{
                return finish(nil, error)
            }

            if let data = data, let status = data["status"] as? Int{
                if status == 1{
                    let list = data["data"] as! [Dictionary<String, Any>]
                    var result = [OSOffice]()
                    for datum in list{
                        let office = OSOffice.init(dict: datum)
                        result.append(office)
                    }
                    return finish(result , nil)
                }
                else{
                    return finish(nil , nil)
                }
            }
            else{
                finish(nil , nil)
            }
        }
    }
    
    // 获取 当前医生的病人列表
    func getPatientList(finish: @escaping (_ list : [OSPatient]? , _ error : Error?) -> Void){
        let url = BASEURL + "api/get_patient_list/"
        let params = ["data" :
        [
            "doctorid" : OSAppCenter.sharedInstance.getCurrentUserId()
            ]
        ]
        
        OSBaseNetService.sharedInstance.postWithoutCache(url, params: params as Dictionary<String, AnyObject>?) { (data, error) in
            if error != nil{
                return finish(nil, error)
            }

            
            if let data = data, let status = data["status"] as? Int{
                if status == 1{
                    let dataList = data["data"] as! [Dictionary<String, Any>]
                    var result = [OSPatient]()
                    for datum in dataList{
                        let patient = OSPatient.init(shortDict: datum)
                        result.append(patient)
                    }
                    return finish(result, nil)
                }
            }
            else{
                return finish(nil, NSError.init(domain: "Error occurs.", code: 0, userInfo: nil))
            }
            
        }
    }
    
    // 获取病人详情信息
    func getPatientDetail(id: Int, finish:@escaping (_ patient: OSPatient? , _ error: Error?) -> Void){
        let url = BASEURL + "api/get_patient_detail/"
        let params = ["data": ["patientid" : id]]
        OSBaseNetService.sharedInstance.postWithoutCache(url, params: params as Dictionary<String, AnyObject>?) { (data, error) in
            if error != nil{
                return finish(nil , error)
            }
            if let data = data, let status = data["status"] as? Int{
                if status == 1{
                    let dict = data["data"] as! Dictionary<String, Any>
                    let patient = OSPatient.init(longDict: dict)
                    return finish(patient , nil)
                }
                else{
                    return finish(nil , NSError.init(domain: "Error happens.", code: 0, userInfo:nil) )
                }
            }
            else{
                return finish(nil , NSError.init(domain: "Error happens.", code: 0, userInfo:nil) )
            }
            
        }
    }
    
    // 添加新 病人接口
    func addPatientDetail(dict: Dictionary<String, Any> , finish:@escaping (_ flag: Bool, _ error: Error?) -> Void){
        let url = BASEURL + "api/add_patient/"
        let params = ["data" : dict]
        print(params)
        OSBaseNetService.sharedInstance.postWithoutCache(url, params: params as Dictionary<String, AnyObject>?) { (data, error) in
            if error != nil{
                print(error.debugDescription)
                return finish(false , error)
            }
            if let data = data, let status = data["status"] as? Int{
                if status == 1{
                    return finish(true , nil)
                }
                else{
                    return finish(false , NSError.init(domain: "Error occurs", code: 0, userInfo: nil))
                }
            }
            else{
                return finish(false , NSError.init(domain: "Error occurs", code: 0, userInfo: nil))
                
            }
        }
    
    }
    
    // 更新病人信息
    func updatePatientDetail(dict: Dictionary<String, Any> , finish:@escaping (_ flag: Bool, _ error: Error?) -> Void){
        let url = BASEURL + "api/update_patient/"
        let params = ["data" : dict]
        OSBaseNetService.sharedInstance.postWithoutCache(url, params: params as Dictionary<String, AnyObject>?) { (data, error) in
            if error != nil{
                return finish(false , error)
            }
            if let data = data, let status = data["status"] as? Int{
                if status == 1{
                    return finish(true , nil)
                }
                else{
                    return finish(false , NSError.init(domain: "Error occurs", code: 0, userInfo: nil))
                }
            }
            else{
                return finish(false , NSError.init(domain: "Error occurs", code: 0, userInfo: nil))

            }
        }
    }
    
    // 删除病人
    func deletePatient(patientID : Int, finish:@escaping (_ flag: Bool, _ error: Error?) -> Void){
        let url = BASEURL + "api/hide_patient/"
        let params = ["data" :
            ["doctorid" : OSAppCenter.sharedInstance.getCurrentUserId() ,
             "patientid" : patientID]]
        OSBaseNetService.sharedInstance.postWithoutCache(url, params: params as Dictionary<String, AnyObject>?) { (data, error) in
            if error != nil{
                return finish(false , error)
            }
            
            if let data = data, let status = data["status"] as? Int{
                if status == 1{
                    return finish(true , nil)
                }
                else{
                    return finish(false , NSError.init(domain: "Error occurs", code: 0, userInfo: nil))
                }
            }
            else{
                return finish(false , NSError.init(domain: "Error occurs", code: 0, userInfo: nil))
                
            }
        }
    }
    
}
