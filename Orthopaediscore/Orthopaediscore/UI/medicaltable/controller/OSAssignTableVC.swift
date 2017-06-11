//
//  OSAssignTableVC.swift
//  Orthopaediscore
//
//  Created by S.t on 2017/6/1.
//  Copyright © 2017年 S.t. All rights reserved.
//

import UIKit

class OSAssignTableVC: UIViewController {

    @IBOutlet var contentTableView: UITableView!
    
    @IBOutlet var titleLabel: UILabel!
    
    let CellIdentifier = "OSBriefTableViewCell"
    
    var dataList = [OSBriefTable]()
    
    let service = OSTableNetService()
    
    var patientId : Int
    
    init(patientID : Int){
        self.patientId = patientID
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.contentTableView.delegate = self
        self.contentTableView.dataSource = self
        self.contentTableView.backgroundColor = UIColor.clear
        self.contentTableView.register(UINib.init(nibName: CellIdentifier, bundle: nil), forCellReuseIdentifier: CellIdentifier)
        self.contentTableView.tableFooterView = UIView.init(frame: CGRect.init(x: 0, y: 0, width: 0, height: 0))
        
        
        self.setupNav()
        self.updateData()
    }
    
    func setupNav(){
        
        
        self.edgesForExtendedLayout = UIRectEdge()
        self.title = "量表分配"
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
        
        
        let rightButton = UIButton.init(frame: CGRect.init(x: 0, y: 0, width: 50, height: 30))
        rightButton.setTitle("确定", for: .normal)
        rightButton.bk_(whenTapped: {[weak self]()-> Void in
            if let weakSelf = self{
                weakSelf.assignTables()
            }
        })
        rightButton.setTitleColor(UIColor.white, for: .normal)
        let rightBarButton = UIBarButtonItem.init(customView: rightButton)
        self.navigationItem.rightBarButtonItem = rightBarButton
    }
    
    func updateData(){
        // 获取 列表信息
        self.service.getTableInfo { (list, err) in
            if let list = list{
                self.dataList = list
                self.contentTableView.reloadData()
            }
        }
        
        // 获取 病人信息
        let patientService = OSPatientService()
        patientService.getPatientDetail(id: self.patientId, finish: { (patient, error) in
            if let patient = patient{
                self.titleLabel.text = "请为病人：\(patient.name) 分配量表。"
            }
        })
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // 分配量表
    func assignTables(){
        self.service.assignTableToPatient(withID: self.patientId, forTables: self.getSelections()) { (flag, error) in
            if flag == true{
                print("分配量表成功")
                OSAppCenter.sharedInstance.InfoNotification(vc: self, title: "提示", message: "分配量表成功", finishBlock: {
                    let _ = self.navigationController?.popViewController(animated: true)
                })
            }
            else{
                OSAppCenter.sharedInstance.InfoNotification(vc: self, title: "提示", message: "分配量表失败，请稍后再试。")
            }
        }
    }
    
    func getSelections() -> [Int]{
        var result = [Int]()
        for i in 0..<self.dataList.count{
            let mainT = self.dataList[i]
            for k in 0..<mainT.subTable.count{
                let indexPath = IndexPath.init(row: k, section: i)
                let cell = self.contentTableView.cellForRow(at: indexPath) as! OSBriefTableViewCell
                if cell.selection == true{
                    result.append(cell.tableId)
                }
            }
        }
        
        return result
    }
    


}

extension OSAssignTableVC :UITableViewDelegate , UITableViewDataSource{

    func numberOfSections(in tableView: UITableView) -> Int {
        return self.dataList.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.dataList[section].subTable.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CellIdentifier, for: indexPath) as! OSBriefTableViewCell
        let table = self.dataList[indexPath.section].subTable[indexPath.row]
        cell.updateContent(content: table.name, tableID: table.id)
        return cell
        
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return CGFloat(40)
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return OSBriefTableSectionHeader.Height
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = OSBriefTableSectionHeader.factory()
        view.updateTitle(title: self.dataList[section].name)
        return view
    }
}
