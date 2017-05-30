//
//  OSMainViewController.swift
//  Orthopaediscore
//
//  Created by S.t on 2017/5/23.
//  Copyright © 2017年 S.t. All rights reserved.
//

import UIKit

class OSMainViewController: UIViewController, SectionNavDelegate {
    
    var managePatientSV: OSMainSectionView!
    var assignTableSV: OSMainSectionView!
    var beginVisitSV: OSMainSectionView!
    var statisticsSV: OSMainSectionView!

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setupUI()
    }
    
    
    func setupUI(){
        
        self.view.backgroundColor = UIColor.init(floatValueRed: 24, green: 31, blue: 40, alpha: 1)
        
        let margin_horizon = CGFloat(25)

        let offset = CGFloat(90)
        let section_width = SCREENWIDTH  - margin_horizon * 2
        let section_height = ( SCREENHEIGHT - offset - 4 * margin_horizon ) / 3
        
        print(SCREENWIDTH)
        print(SCREENHEIGHT)
        print(section_width)
        print(section_height)
        print(UIScreen.main.bounds)
        
        // 管理患者
        let sep_width = (section_width - margin_horizon) / 2
        managePatientSV = OSMainSectionView.init(frame: CGRect.init(x:  margin_horizon, y: offset + margin_horizon, width: sep_width, height: section_height))
        managePatientSV.update("管理患者", UIImage.init(named: "tmpicon")!)

        
        // 分配量表
        assignTableSV = OSMainSectionView.init(frame: CGRect.init(x:  managePatientSV.right + margin_horizon, y: offset + margin_horizon, width: sep_width, height: section_height))
        assignTableSV.update("分配量表", UIImage.init(named: "tmpicon")!)
        
        // 开始随访
        beginVisitSV = OSMainSectionView.init(frame: CGRect.init(x:  margin_horizon, y: managePatientSV.bottom + margin_horizon, width: section_width, height: section_height))
        beginVisitSV.update("开始随访", UIImage.init(named: "tmpicon")!)
        
        // 统计数据
        statisticsSV = OSMainSectionView.init(frame: CGRect.init(x:  margin_horizon, y: beginVisitSV.bottom + margin_horizon, width: section_width, height: section_height))
        statisticsSV.update("统计数据", UIImage.init(named: "tmpicon")!)

        
        managePatientSV.delegate = self
        assignTableSV.delegate = self
        beginVisitSV.delegate = self
        statisticsSV.delegate = self
        
        
        
        self.view.addSubview(managePatientSV)
        self.view.addSubview(assignTableSV)
        self.view.addSubview(beginVisitSV)
        self.view.addSubview(statisticsSV)
        
        
    }
    
    
    @IBAction func dismissAction(_ sender: Any) {
        
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func ManageAction(_ sender: Any) {
        
        let vc = OSPatientViewController()
        
        
        self.present(vc, animated: true, completion: nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func jumpToNext(relatedTo targetView: OSMainSectionView) {
        if targetView == self.managePatientSV{
            let vc = OSPatientViewController()
            let nav = UINavigationController.init(rootViewController: vc)
            self.present(nav, animated: true, completion: nil)
        }
        else if targetView == self.assignTableSV{
        
        }
        else if targetView == self.beginVisitSV{
        
        }
        else if targetView == self.statisticsSV{
        
        }
        else{
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
