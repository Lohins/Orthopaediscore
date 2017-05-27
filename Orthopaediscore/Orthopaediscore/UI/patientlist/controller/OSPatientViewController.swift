//
//  OSPatientViewController.swift
//  Orthopaediscore
//
//  Created by YI ZHANG on 2017-05-27.
//  Copyright © 2017 S.t. All rights reserved.
//

import UIKit

let ID = "Cell"
class OSPatientViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    var tableData = [["Name":"男病人","Department":"骨科","Intime":"2017.02.03","Outtime":"2017.02.03","Information":"骨关节病","Gender":"Male.png"],["name":"女病人","Department":"骨科","Intime":"2017.02.03","Outtime":"2017.02.03","Information":"肱骨骨折","Gender":"Female.png"]]
    
    var tableView:UITableView?
    
    override func loadView() {
        super.loadView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //创建表视图
        var tableView = UITableView(frame: view.bounds, style: UITableViewStyle.plain)

        tableView.delegate = self
        tableView.dataSource = self

        tableView.register(UITableViewCell.classForCoder(), forCellReuseIdentifier: ID)

        self.view.addSubview(self.tableView!)
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1;
    }
    
    //返回表格行数
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.tableData.count
    }
    
    //单元格高度
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath)
        -> CGFloat {
            return 75
    }
    
    //创建各单元显示内容
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath)
        -> UITableViewCell
    {
        let cell:OSPatientTableViewCell = tableView.dequeueReusableCell(withIdentifier: ID)
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
    
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle,
                     forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .delete {
            tableData.remove(at: indexPath.row)
        
            tableView.deleteRows(at: [indexPath as IndexPath], with: UITableViewRowAnimation.fade)
        }
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
