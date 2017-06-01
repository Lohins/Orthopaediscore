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
    
    let CellIdentifier = "OSBriefTableViewCell"
    
    var dataList = [OSBriefTable]()
    
    let service = OSTableNetService()
    
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
    }
    
    func updateData(){
        self.service.getTableInfo { (list, err) in
            if let list = list{
                self.dataList = list
                self.contentTableView.reloadData()
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
        cell.updateContent(content: self.dataList[indexPath.section].subTable[indexPath.row].name)
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
