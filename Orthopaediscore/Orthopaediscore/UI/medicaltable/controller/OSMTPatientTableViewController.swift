//
//  OSMTPatientTableViewController.swift
//  Orthopaediscore
//
//  Created by S.t on 2017/5/31.
//  Copyright © 2017年 S.t. All rights reserved.
//

import UIKit

class OSMTPatientTableViewController: UITableViewController {
    let CellIdentifier = "OSPatientTableViewCell"
    
    var patientList = [OSPatient]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupNav()
        
        testData()
        
        self.tableView.register(UINib.init(nibName: CellIdentifier, bundle: nil), forCellReuseIdentifier: CellIdentifier)
        self.tableView.backgroundColor = BGCOLOR
        self.tableView.tableFooterView = UIView.init(frame: CGRect.init())
        
    }
    
    func testData(){
        let dict = ["name": "李华",
                    "office" : 1,
                    "comment": "关节病",
                    "leavedate" : "2017-02-25T00:00:0",
                    "admissdate" : "2017-02-25T00:00:0"] as [String : Any]
        let dict2 = ["name": "小明",
                    "office" : 1,
                    "comment": "鼻炎",
                    "leavedate" : "2017-02-25T00:00:0",
                    "admissdate" : "2017-02-25T00:00:0"] as [String : Any]
        
        let patient1 = OSPatient.init(shortDict: dict as [String: Any])
        let patient2 = OSPatient.init(shortDict: dict2 as [String: Any])
        patientList.append(contentsOf : [patient1 , patient2])
        self.tableView.reloadData()

    }
    
    func setupNav(){
        self.title = "请选择患者"
        self.navigationController?.navigationBar.barTintColor = BGCOLOR
        self.view.backgroundColor = BGCOLOR
        
        self.navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName:UIColor.white]
        
        let leftButton = UIButton.init(frame: CGRect.init(x: 0, y: 0, width: 30, height: 30))
        leftButton.bk_(whenTapped: {[weak self]()-> Void in
            if let weakSelf = self{
                weakSelf.navigationController?.dismiss(animated: true, completion: nil)
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
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.patientList.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CellIdentifier, for: indexPath) as! OSPatientTableViewCell
        let patient = self.patientList[indexPath.row]
        cell.NameLabel.text = patient.name
        cell.DepLabel.text = "keshi"
        cell.IntimeLabel.text = patient.admissDate?.toString()
        cell.OuttimeLabel.text = patient.leaveDate?.toString()
        cell.InfoLabel.text = patient.comment
//        cell.GenderImage.image = UIImage(named:item["Gender"]!)
        
        cell.selectionStyle = .none

        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = OSAssignTableVC()
        
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
