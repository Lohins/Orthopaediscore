//
//  OSMainViewController.swift
//  Orthopaediscore
//
//  Created by S.t on 2017/5/23.
//  Copyright © 2017年 S.t. All rights reserved.
//

import UIKit

class OSMainViewController: UIViewController {

    
    
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
        let sectionView1 = OSMainSectionView.init(frame: CGRect.init(x:  margin_horizon, y: offset + margin_horizon, width: sep_width, height: section_height))
        sectionView1.update("管理患者", UIImage.init(named: "tmpicon")!)
        
        // 分配量表
        let sectionView2 = OSMainSectionView.init(frame: CGRect.init(x:  sectionView1.right + margin_horizon, y: offset + margin_horizon, width: sep_width, height: section_height))
        sectionView2.update("分配量表", UIImage.init(named: "tmpicon")!)
        
        // 开始随访
        let sectionView3 = OSMainSectionView.init(frame: CGRect.init(x:  margin_horizon, y: sectionView1.bottom + margin_horizon, width: section_width, height: section_height))
        sectionView3.update("开始随访", UIImage.init(named: "tmpicon")!)
        
        // 统计数据
        let sectionView4 = OSMainSectionView.init(frame: CGRect.init(x:  margin_horizon, y: sectionView3.bottom + margin_horizon, width: section_width, height: section_height))
        sectionView4.update("统计数据", UIImage.init(named: "tmpicon")!)


        
        self.view.addSubview(sectionView1)
        self.view.addSubview(sectionView2)
        self.view.addSubview(sectionView3)
        self.view.addSubview(sectionView4)
        
        
    }
    
    
    @IBAction func dismissAction(_ sender: Any) {
        
        self.dismiss(animated: true, completion: nil)
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

}
