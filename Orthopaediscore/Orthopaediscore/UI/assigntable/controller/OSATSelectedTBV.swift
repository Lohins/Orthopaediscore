//
//  OSATSelectedTBV.swift
//  Orthopaediscore
//
//  Created by S.t on 2017/6/3.
//  Copyright © 2017年 S.t. All rights reserved.
//

import UIKit

class OSATSelectedTBV: UITableViewController {
    let CellIdentifier = "OSATSelectedTBCell"
    
    var targetPatient: OSPatient!
    var tableList = [OSUniqueTable]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setupNav()
        
        self.tableView.register(UINib.init(nibName: CellIdentifier, bundle: nil), forCellReuseIdentifier: CellIdentifier)
        self.tableView.tableFooterView = UIView.init(frame: CGRectZore)
    }
    
    init(patient: OSPatient){
        super.init(nibName: nil, bundle: nil)
        self.targetPatient = patient
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.updateData()
    }
    
    func updateData(){
        
        let service = OSTableNetService()
        
        service.getUnfinishedTableBy(patientId: self.targetPatient.id) { (list, error) in
            if let list = list {
                self.tableList = list
                self.tableView.reloadData()
            }
        }
        
        
    }
    
    func setupNav(){
        
        self.view.backgroundColor = UIColor.init(floatValueRed: 24, green: 30, blue: 40, alpha: 1)
        self.tableView.backgroundColor = UIColor.clear
        
        self.title = "患者：" + self.targetPatient.name
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

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.tableList.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CellIdentifier , for: indexPath) as! OSATSelectedTBCell
        
        let table = self.tableList[indexPath.row]
        
        cell.updateTitle(title: table.tableName)
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let table = self.tableList[indexPath.row]
        
        let vc = OSFillTableViewController.init(table: table)
        
        
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
 

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
