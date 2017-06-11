//
//  OSAppCenter.swift
//  Orthopaediscore
//
//  Created by S.t on 2017/6/7.
//  Copyright © 2017年 S.t. All rights reserved.
//

import UIKit

class OSAppCenter: NSObject {
    
    static let sharedInstance: OSAppCenter = OSAppCenter.init()
    
    override init(){
        super.init()
        self.initOfficeInfo()
    }
    
    private var currentUser : OSDoctor?
    
    var officeList = [OSOffice]()
    var officeDict = Dictionary<Int, String>()
    
    func isLogin() -> Bool{
        if  OSAppCenter.sharedInstance.currentUser != nil{
            return true
        }
        else{
            return false
        }

    }
    
    func login(doctor: OSDoctor){
        OSAppCenter.sharedInstance.currentUser = doctor
    }
    
    func logout(){
        OSAppCenter.sharedInstance.currentUser = nil
    }
    
    func getCurrentUserId() -> Int{
        if OSAppCenter.sharedInstance.isLogin(){
            return (OSAppCenter.sharedInstance.currentUser?.doctorID)!
        }
        else{
            return -1
        }

    }
    
    // 获取 科室列表
    func initOfficeInfo(){
        let service = OSPatientService()
        service.getOffice { (list, error) in
            if let list = list{
                self.officeList = list
                for item in list{
                    self.officeDict[item.id] = item.name
                }
            }
        }
    }
    
    
    
    // 消息提示
    func InfoNotification(vc: UIViewController , title: String , message: String){
        // 提示信息
        let alertVC = UIAlertController.init(title: title, message: message, preferredStyle: .alert)
        vc.present(alertVC, animated: true, completion: nil)
        
        let timer = DispatchTime.now() + 1.6
        DispatchQueue.main.asyncAfter(deadline: timer) {
            alertVC.dismiss(animated: true, completion: nil)
        }
    }
    
    func InfoNotification(vc: UIViewController , title: String , message: String, finishBlock: @escaping ()-> Void){
        // 提示信息
        let alertVC = UIAlertController.init(title: title, message: message, preferredStyle: .alert)
        vc.present(alertVC, animated: true, completion: nil)
        
        let timer = DispatchTime.now() + 1.6
        DispatchQueue.main.asyncAfter(deadline: timer) {
            alertVC.dismiss(animated: true, completion: nil)
            finishBlock()
        }
        
        
    }
    
    
    
    
}
