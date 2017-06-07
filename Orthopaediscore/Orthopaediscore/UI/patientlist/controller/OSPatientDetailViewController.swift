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
    
    var diagnosisTextView: UITextView!
    
    var patient: OSPatient = OSPatient.init()
    var patientId: Int
    var blk: (()-> Void)
    
    init(flag: Int, patientID: Int , finishBlk: @escaping ()-> Void){
        self.patientId = patientID
        self.blk = finishBlk
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
        self.typeSelectView = OSDropListView.init(frame: CGRect.init(x: 0, y: 0, width: SCREENWIDTH - 2 * margin, height: sectionHeight) , title: "科室", datalist: ["骨科" , "五官科" , "胸科"])
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
        let label = UILabel.init(frame: CGRect.init(x: 0, y: 0, width: 300, height: 30))
        label.text = "入院诊断 : "
        label.textColor = UIColor.white
        label.font = UIFont.init(name: "System-regular", size: 16)
        label.top = self.goOutDateView.bottom + margin
        label.left = margin
        
        self.diagnosisTextView = UITextView.init(frame: CGRect.init(x: 0, y: 0, width: SCREENWIDTH - 2 * margin, height: 200))
        self.diagnosisTextView.layer.cornerRadius = 10
        self.diagnosisTextView.top = label.bottom + margin
        self.diagnosisTextView.left = margin
        
        
        
        self.mainScrollView.addSubview(self.nameInputView)
        self.mainScrollView.addSubview(self.genderSelectView)
        self.mainScrollView.addSubview(self.birthDateView)
        self.mainScrollView.addSubview(self.weightInputView)
        self.mainScrollView.addSubview(self.heightInputView)
        self.mainScrollView.addSubview(self.typeSelectView)
        self.mainScrollView.addSubview(self.goInDateView)
        self.mainScrollView.addSubview(self.goOutDateView)
        self.mainScrollView.addSubview(label)
        self.mainScrollView.addSubview(self.diagnosisTextView)
        
        self.mainScrollView.contentSize = CGSize.init(width: SCREENWIDTH, height: self.diagnosisTextView.bottom + margin)
    }
    
    func fillData(){
        if self.patient.name == ""{
            
        }
    }

}
