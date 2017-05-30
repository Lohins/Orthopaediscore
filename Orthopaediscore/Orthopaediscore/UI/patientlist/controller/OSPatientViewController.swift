//
//  OSPatientViewController.swift
//  Orthopaediscore
//
//  Created by YI ZHANG on 2017-05-27.
//  Copyright © 2017 S.t. All rights reserved.
//

import UIKit
import BlocksKit


class OSPatientViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    let CellIdentifier = "OSPatientTableViewCell"

    var contentTableView : UITableView!
    
    var tableData = [["Name":"男病人","Department":"骨科","Intime":"2017.02.03","Outtime":"2017.02.03","Information":"骨关节病","Gender":"Male.png"],["Name":"女病人","Department":"骨科","Intime":"2017.02.03","Outtime":"2017.02.03","Information":"肱骨骨折","Gender":"Female.png"]]
    
    override func loadView() {
        super.loadView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setupNav()
        
        //创建表视图
        contentTableView = UITableView(frame: view.bounds, style: UITableViewStyle.plain)
        contentTableView.backgroundColor = UIColor.clear

        contentTableView.delegate = self
        contentTableView.dataSource = self
        contentTableView.register(UINib.init(nibName: CellIdentifier, bundle: nil), forCellReuseIdentifier: CellIdentifier)
        

        self.view.addSubview(self.contentTableView)
    }
    
    func setupNav(){
        self.view.backgroundColor = UIColor.init(floatValueRed: 24, green: 31, blue: 40, alpha: 1)
        self.navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName:UIColor.white]
        self.title = "患者列表"
        self.navigationItem.titleLabel.textColor = UIColor.white
        self.navigationController?.navigationBar.barTintColor = UIColor.init(floatValueRed: 24, green: 31, blue: 40, alpha: 1)
        self.navigationController?.navigationBar.backgroundColor = UIColor.init(floatValueRed: 24, green: 31, blue: 40, alpha: 1)
        
        let leftButton = UIButton.init(frame: CGRect.init(x: 0, y: 0, width: 30, height: 30))
        leftButton.bk_(whenTapped: {[weak self]()-> Void in
            if let weakSelf = self{
                weakSelf.navigationController?.dismiss(animated: true, completion: nil)
            }
        })
        leftButton.setImage(UIImage.init(named: "white_back_icon"), for: .normal)
        let leftBarButton = UIBarButtonItem.init(customView: leftButton)
        self.navigationItem.leftBarButtonItem = leftBarButton
        
        let rightButton = UIButton.init(frame: CGRect.init(x: 0, y: 0, width: 30, height: 30))
        rightButton.bk_(whenTapped: {[weak self]()-> Void in
            if let weakSelf = self{
                let vc = OSPatientDetailViewController()
                weakSelf.navigationController?.pushViewController(vc, animated: true)
            }
        })
        rightButton.setImage(UIImage.init(named: "add_icon"), for: .normal)
        let rightBarButton = UIBarButtonItem.init(customView: rightButton)
        self.navigationItem.rightBarButtonItem = rightBarButton
        
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1;
    }
    
    //返回表格行数
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.tableData.count
    }
    
    //单元格高度
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath)
        -> CGFloat {
            return 60
    }
    
    //创建各单元显示内容
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath)
        -> UITableViewCell
    {
        let cell:OSPatientTableViewCell = tableView.dequeueReusableCell(withIdentifier: CellIdentifier)
            as! OSPatientTableViewCell
        let item = tableData[indexPath.row]
        cell.NameLabel.text = item["Name"]
        cell.DepLabel.text = item["Department"]
        cell.IntimeLabel.text = item["Intime"]
        cell.OuttimeLabel.text = item["Outtime"]
        cell.InfoLabel.text = item["Information"]
        cell.GenderImage.image = UIImage(named:item["Gender"]!)
        return cell
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
//    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle,
//                   forRowAt indexPath: IndexPath) {
//        if editingStyle == .delete {
//            tableData.remove(at: indexPath.row)
//        
//            tableView.deleteRows(at: [indexPath as IndexPath], with: UITableViewRowAnimation.fade)
//        }
//    }
    
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let index = indexPath.row
        
        let editAction = UITableViewRowAction.init(style: .normal, title: "修改") { (action, indexPath) in
            
        }
        
        let deleteAction = UITableViewRowAction.init(style: .destructive, title: "删除") { [weak self] (action, indexPath) in
            if let weakSelf = self{
                weakSelf.tableData.remove(at: index)
                weakSelf.contentTableView.reloadData()
            }
        }
        
        return [ deleteAction, editAction]
    }
    
    
    


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}