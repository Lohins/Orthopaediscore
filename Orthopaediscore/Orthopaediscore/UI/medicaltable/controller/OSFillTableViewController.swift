//
//  OSFillTableViewController.swift
//  Orthopaediscore
//
//  Created by S.t on 2017/6/3.
//  Copyright © 2017年 S.t. All rights reserved.
//

import UIKit

class OSFillTableViewController: UIViewController {

    
    @IBOutlet var linearScrollView: LinearScrollView!
    
    var questionViewList = [OSQuestionView]()
    
    var uniqueTable: OSUniqueTable!

    
    var dataList = [OSQuestion]()
    
    let service = OSTableNetService()
    
    init(table: OSUniqueTable) {
        super.init(nibName: nil, bundle: nil)
        self.uniqueTable = table
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupNav()
        self.updateData()
    }
    
    func setupNav(){
        self.title = "量表: " + self.uniqueTable.tableName
        self.navigationController?.navigationBar.barTintColor = BGCOLOR
        self.view.backgroundColor = BGCOLOR
        
        self.navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName:UIColor.white]
        
        let leftButton = UIButton.init(frame: CGRect.init(x: 0, y: 0, width: 30, height: 30))
        leftButton.bk_(whenTapped: {[weak self]()-> Void in
            if let weakSelf = self{
                let _ = weakSelf.navigationController?.popViewController(animated: true)
            }
        })
        leftButton.setImage(UIImage.init(named: "white_back_icon"), for: .normal)
        let leftBarButton = UIBarButtonItem.init(customView: leftButton)
        self.navigationItem.leftBarButtonItem = leftBarButton
    }
    
    func updateData(){
        self.service.getTableInfoBy(id: 1) { (list, err) in
            if let list = list{
                self.dataList = list
                
                self.updateUI()
            }
        }
    }
    
    func submitTable(){
        var questList = [Dictionary<String, Any>]()
        for question in self.questionViewList{
            if let dict = question.summary(){
                questList.append(dict)
            }
            else{
                return
            }
        }
        let dict = [
                    "patientid" : self.uniqueTable.patientId,
                    "subtableid" : self.uniqueTable.tableId,
                    "ticket" : self.uniqueTable.ticket,
                    "content" : questList
            ] as [String : Any]
        print(dict)
        self.service.submitTable(dict: dict) { (flag, error) in
            if flag == true{
                OSAppCenter.sharedInstance.InfoNotification(vc: self, title: "提示", message: "提交量表成功", finishBlock: {
                    let _ = self.navigationController?.popViewController(animated: true)
                })
            }
            else{
                OSAppCenter.sharedInstance.InfoNotification(vc: self, title: "提示", message: "提交量表失败")
            }
        }
    }
    
    func updateUI(){
        for quest in self.dataList{
            let view =  OSQuestionView.init(frame: CGRectZore, Question: quest)
            view.center = CGPoint.init(x: SCREENWIDTH / 2, y: SCREENHEIGHT / 2)

            self.linearScrollView.linear_addSubview(view, paddingTop: 10, paddingBottom: 10)
            self.questionViewList.append(view)
        }
        
        let buttonView = TableSubmitButton.factory()
        buttonView.tapBlock = { [weak self] () -> Void in
            if let weakSelf = self{
                weakSelf.submitTable()
            }
        }
        self.linearScrollView.linear_addSubview(buttonView, paddingTop: 10, paddingBottom: 10)

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    
    class TableSubmitButton: UIView{
        
        var tapBlock: (() -> Void)?
        
        class func factory() -> TableSubmitButton{
            return TableSubmitButton.init(frame: CGRect.init(x: 0, y: 0, width: SCREENWIDTH, height: 50))
            
        }
        
        override init(frame: CGRect) {
            super.init(frame: frame)
            self.setupUI()
        }
        
        required init?(coder aDecoder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
        
        func setupUI(){
            let button = UIButton.init(frame: CGRect.init(x: 0, y: 0, width: self.width, height: self.height))
            button.setTitle("确认提交", for: .normal)
            button.setTitleColor(UIColor.white, for: .normal)
            button.backgroundColor = UIColor.blue
            button.bk_(whenTapped: { [weak self] () -> Void in
                if let weakSelf = self{
                    if let blk = weakSelf.tapBlock{
                        blk()
                    }
                }
            })
            self.addSubview(button)
        }
    }

}
