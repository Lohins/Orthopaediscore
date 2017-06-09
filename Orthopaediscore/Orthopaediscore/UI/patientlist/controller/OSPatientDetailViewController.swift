//
//  OSPatientDetailViewController.swift
//  Orthopaediscore
//
//  Created by S.t on 2017/5/29.
//  Copyright © 2017年 S.t. All rights reserved.
//

import UIKit
import TPKeyboardAvoiding

class OSPatientDetailViewController: UIViewController {
    
    var mainScrollView : TPKeyboardAvoidingScrollView!
    var nameInputView: OSInputView!
    var birthDateView: OSDateSelectView!
    var goInDateView: OSDateSelectView!
    var goOutDateView: OSDateSelectView!

    var genderSelectView: OSDropListView!
    var weightInputView: OSInputView!
    var heightInputView: OSInputView!
    var typeSelectView: OSDropListView!
    
    var admissDiagnosisTextView: UITextView!
    var leaveDiagnosisTextView: UITextView!
    var commentTextView: UITextView!


    
    // 0 代表新建病人， 1 代表更新病人信息
    // 差别在于 
//    新建病人 ： 各项输入框内容为空， 点击完成按钮的操作是 创建 病人
//    更新病人 ： 各项输入框内容为原始数据， 点击完成按钮 操作是去 更新病人信息
    var Flag: Int = 0
    let service = OSPatientService()
    
    var patient: OSPatient = OSPatient.init()
    var patientId: Int
    
    init(flag: Int, patientID: Int ){
        self.patientId = patientID
        self.Flag = flag
        super.init(nibName: nil, bundle: nil)

    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    


    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setupNav()
        
        self.setupUI()

        self.fillData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setupNav(){
        self.title = "详细信息"
        let leftButton = UIButton.init(frame: CGRect.init(x: 0, y: 0, width: 30, height: 30))
        leftButton.bk_(whenTapped: {[weak self]()-> Void in
            if let weakSelf = self{
                _ = weakSelf.navigationController?.popViewController(animated: true)
            }
        })
        leftButton.setImage(UIImage.init(named: "white_back_icon"), for: .normal)
        let leftBarButton = UIBarButtonItem.init(customView: leftButton)
        self.navigationItem.leftBarButtonItem = leftBarButton
        
        self.view.backgroundColor = UIColor.init(floatValueRed: 24, green: 31, blue: 40, alpha: 1)
        
        let rightButton = UIButton.init(frame: CGRect.init(x: 0, y: 0, width: 50, height: 30))
        rightButton.setTitle("完成", for: .normal)
        rightButton.setTitleColor(UIColor.white, for: .normal)
        rightButton.bk_(whenTapped: {[weak self]()-> Void in
            if let weakSelf = self{
                weakSelf.updatePatientInfo()
            }
        })
        let rightBarButton = UIBarButtonItem.init(customView: rightButton)
        self.navigationItem.rightBarButtonItem = rightBarButton
    }
    
    func setupUI(){
        self.edgesForExtendedLayout = UIRectEdge()
        
        self.mainScrollView = TPKeyboardAvoidingScrollView.init(frame: CGRect.init(x: 0, y: 0, width: SCREENWIDTH, height: SCREENHEIGHT - STATUSBARHEIGHT - NAVIGATIONBARHEIGHT))
        self.mainScrollView.contentSize = CGSize.init(width: SCREENWIDTH, height: SCREENHEIGHT - STATUSBARHEIGHT - NAVIGATIONBARHEIGHT)
        self.view.addSubview(self.mainScrollView)
        
        let margin = CGFloat(14)
        let sectionWidth = ( SCREENWIDTH - 3 * margin ) / 2
        let sectionHeight = CGFloat(50)
        
        // name gender
        self.nameInputView = OSInputView.init(frame: CGRect.init(x: 0, y: 0, width: sectionWidth, height: sectionHeight) , title: "姓名")
        self.nameInputView.left = margin
        self.nameInputView.top = margin
        
        self.genderSelectView = OSDropListView.init(frame: CGRect.init(x: 0, y: 0, width: sectionWidth, height: sectionHeight) , title: "性别", datalist: ["男" , "女"])
        self.genderSelectView.left = self.nameInputView.right + margin
        self.genderSelectView.top = margin
        
        // birth date
        self.birthDateView = OSDateSelectView.init(frame: CGRect.init(x: 0, y: 0, width: SCREENWIDTH - 2 * margin, height: sectionHeight), title: "出生年月")
        self.birthDateView.top = self.genderSelectView.bottom + margin
        self.birthDateView.left = margin
        
        // weight height
        self.weightInputView = OSInputView.init(frame: CGRect.init(x: 0, y: 0, width: sectionWidth, height: sectionHeight), title: "体重")
        self.weightInputView.left = margin
        self.weightInputView.top = self.birthDateView.bottom + margin
        
        self.heightInputView = OSInputView.init(frame: CGRect.init(x: 0, y: 0, width: sectionWidth, height: sectionHeight), title: "身高")
        self.heightInputView.left = self.weightInputView.right + margin
        self.heightInputView.top = self.birthDateView.bottom + margin
        
        // 科室
        self.typeSelectView = OSDropListView.init(frame: CGRect.init(x: 0, y: 0, width: SCREENWIDTH - 2 * margin, height: sectionHeight) , title: "科室", datalist: Array(OSAppCenter.sharedInstance.officeDict.values) )
        self.typeSelectView.left = margin
        self.typeSelectView.top = self.heightInputView.bottom + margin
        
        // 入院时间
        self.goInDateView = OSDateSelectView.init(frame: CGRect.init(x: 0, y: 0, width: SCREENWIDTH - 2 * margin, height: sectionHeight), title: "入院时间")
        self.goInDateView.top = self.typeSelectView.bottom + margin
        self.goInDateView.left = margin
        
        // 出院时间
        self.goOutDateView = OSDateSelectView.init(frame: CGRect.init(x: 0, y: 0, width: SCREENWIDTH - 2 * margin, height: sectionHeight), title: "出院时间")
        self.goOutDateView.top = self.goInDateView.bottom + margin
        self.goOutDateView.left = margin
        
        // 诊断结果
        let admissLabel = UILabel.init(frame: CGRect.init(x: 0, y: 0, width: 300, height: 30))
        admissLabel.text = "入院诊断 : "
        admissLabel.textColor = UIColor.white
        admissLabel.font = UIFont.init(name: "Helvetica", size: 16)
        admissLabel.top = self.goOutDateView.bottom + margin
        admissLabel.left = margin
        
        self.admissDiagnosisTextView = UITextView.init(frame: CGRect.init(x: 0, y: 0, width: SCREENWIDTH - 2 * margin, height: 200))
        self.admissDiagnosisTextView.font = UIFont.init(name: "Helvetica", size: 16)
        self.admissDiagnosisTextView.layer.cornerRadius = 10
        self.admissDiagnosisTextView.top = admissLabel.bottom + margin
        self.admissDiagnosisTextView.left = margin
        
        
        // 出院诊断
        let leaveLabel = UILabel.init(frame: CGRect.init(x: 0, y: 0, width: 300, height: 30))
        leaveLabel.text = "出院诊断 : "
        leaveLabel.textColor = UIColor.white
        leaveLabel.font = UIFont.init(name: "Helvetica", size: 16)
        leaveLabel.top = self.admissDiagnosisTextView.bottom + margin
        leaveLabel.left = margin
        
        self.leaveDiagnosisTextView = UITextView.init(frame: CGRect.init(x: 0, y: 0, width: SCREENWIDTH - 2 * margin, height: 200))
        self.leaveDiagnosisTextView.font = UIFont.init(name: "Helvetica", size: 16)
        self.leaveDiagnosisTextView.layer.cornerRadius = 10
        self.leaveDiagnosisTextView.top = leaveLabel.bottom + margin
        self.leaveDiagnosisTextView.left = margin
        
        // 医生评价
        let commentLabel = UILabel.init(frame: CGRect.init(x: 0, y: 0, width: 300, height: 30))
        self.leaveDiagnosisTextView.font = UIFont.init(name: "Helvetica", size: 16)
        commentLabel.text = "医生评价 : "
        commentLabel.textColor = UIColor.white
        commentLabel.font = UIFont.init(name: "Helvetica", size: 16)

        commentLabel.top = self.leaveDiagnosisTextView.bottom + margin
        commentLabel.left = margin
        
        self.commentTextView = UITextView.init(frame: CGRect.init(x: 0, y: 0, width: SCREENWIDTH - 2 * margin, height: 200))
        self.commentTextView.font = UIFont.init(name: "Helvetica", size: 16)
        self.commentTextView.layer.cornerRadius = 10
        self.commentTextView.top = commentLabel.bottom + margin
        self.commentTextView.left = margin
        
        
        self.mainScrollView.addSubview(self.nameInputView)
        self.mainScrollView.addSubview(self.genderSelectView)
        self.mainScrollView.addSubview(self.birthDateView)
        self.mainScrollView.addSubview(self.weightInputView)
        self.mainScrollView.addSubview(self.heightInputView)
        self.mainScrollView.addSubview(self.typeSelectView)
        self.mainScrollView.addSubview(self.goInDateView)
        self.mainScrollView.addSubview(self.goOutDateView)
        self.mainScrollView.addSubview(admissLabel)
        self.mainScrollView.addSubview(self.admissDiagnosisTextView)
        self.mainScrollView.addSubview(leaveLabel)
        self.mainScrollView.addSubview(self.leaveDiagnosisTextView)
        self.mainScrollView.addSubview(commentLabel)
        self.mainScrollView.addSubview(self.commentTextView)
        
        self.mainScrollView.contentSize = CGSize.init(width: SCREENWIDTH, height: self.commentTextView.bottom + margin)
    }
    
    func updatePatientInfo(){
        if let name = nameInputView.getContent(), let weightStr = weightInputView.getContent(), let weight = Int.init(weightStr), let heightStr = heightInputView.getContent(), let height = Int.init(heightStr), let birthDate = birthDateView.getDate(), let admissDate = goInDateView.getDate(), let leaveDate = goOutDateView.getDate(), let gender = genderSelectView.getContent(), let officeName = typeSelectView.getContent()
        {

            var officeID = -1
            for index in OSAppCenter.sharedInstance.officeDict.keys{
                if OSAppCenter.sharedInstance.officeDict[index] == officeName{
                    officeID = index
                    break
                }
            }
            
            var admissNote = ""
            if let text = self.admissDiagnosisTextView.text {
                admissNote = text
            }
            else{
                OSAppCenter.sharedInstance.InfoNotification(vc: self, title: "提示", message: "请填写病人入院诊断")
                return
            }
            var leaveNote = ""
            if let text = self.leaveDiagnosisTextView.text {
                leaveNote = text
            }
            else{
                OSAppCenter.sharedInstance.InfoNotification(vc: self, title: "提示", message: "请填写病人出院诊断")
                return
            }
            var comment = ""
            if let text = self.commentTextView.text {
                comment = text
            }
            else{
                OSAppCenter.sharedInstance.InfoNotification(vc: self, title: "提示", message: "请填写病人评价")
                return
            }

            // 创建病人
            if self.Flag == 0{

                
                let dict =
                    [
                        "doctorid" : OSAppCenter.sharedInstance.getCurrentUserId(),
                        "name":  name ,
                        "sex":  gender == "男" ? 1 : 0 ,
                        "height":  height ,
                        "birthday":  birthDate.toString() ,
                        "weight":  weight ,
                        "office":  officeID ,
                        "admissiondate":  admissDate.toString() ,
                        "leavedate":  leaveDate.toString() ,
                        "admissionnote":  admissNote ,
                        "comment":  comment,
                        "leavenote":  leaveNote ,
                    ] as [String : Any]

                print(dict)
                self.service.addPatientDetail(dict: dict, finish: { (status, error) in
                    if status == true{
                        print("添加病人成功")
                        OSAppCenter.sharedInstance.InfoNotification(vc: self, title: "提示", message: "病人添加成功", finishBlock: {
                            let _ = self.navigationController?.popViewController(animated: true)
                        })
                    }
                    else{
                        print("添加病人失败")
                        OSAppCenter.sharedInstance.InfoNotification(vc: self, title: "提示", message: "更新病人成功")
                    }
                })
            }
            // 更新病人
            else{
                let dict =
                    [
                        "patientid" : self.patientId,
                        "name":  name ,
                        "sex":  gender == "男" ? 1 : 0 ,
                        "height":  height ,
                        "birthday":  birthDate.toString() ,
                        "weight":  weight ,
                        "office":  officeID ,
                        "admissiondate":  admissDate.toString() ,
                        "leavedate":  leaveDate.toString() ,
                        "admissionnote":  admissNote ,
                        "comment":  comment,
                        "leavenote":  leaveNote ,
                    ] as [String : Any]
                print(dict)
                self.service.updatePatientDetail(dict: dict, finish: { (status, error) in
                    if status == true{
                        print("更新病人成功")
                        OSAppCenter.sharedInstance.InfoNotification(vc: self, title: "提示", message: "病人更新成功", finishBlock: {
                            let _ = self.navigationController?.popViewController(animated: true)
                        })

                    }
                    else{
                        print("更新病人失败")
                        OSAppCenter.sharedInstance.InfoNotification(vc: self, title: "提示", message: "病人更新失败")
                    }
                })
            }
            
            
        }

    }
    
    func fillData(){
        if self.Flag == 0{
            // 创建新病人
        }
        else{
//            填入病人原始信息
            self.service.getPatientDetail(id: self.patientId, finish: { (patient, error) in
                if let patient = patient{
                    self.patient = patient
                    
                    self.nameInputView.updateContent(text: self.patient.name)
                    // 生日
                    if let date = self.patient.birthDate{
                        self.birthDateView.updateDate(date: date)
                    }
//                    入院日期
                    if let date = self.patient.admissDate{
                        self.goInDateView.updateDate(date: date)
                    }
//                    出院日期
                    if let date = self.patient.leaveDate{
                        self.goOutDateView.updateDate(date: date)
                    }
//                    性别
                    if self.patient.sex == 0{
                        self.genderSelectView.updateContent(text: "女")
                    }
                    else if self.patient.sex == 1{
                        self.genderSelectView.updateContent(text: "男")
                    }
                    if self.patient.height != -1{
                        self.heightInputView.updateContent(text: String(self.patient.height))
                    }
                    if self.patient.weight != -1{
                        self.weightInputView.updateContent(text: String(self.patient.weight))
                    }
                    
                    self.commentTextView.text = self.patient.comment
                    self.admissDiagnosisTextView.text = self.patient.admissNote
                    self.leaveDiagnosisTextView.text = self.patient.leaveNote
                    
                }
            })
        }

    }

}
