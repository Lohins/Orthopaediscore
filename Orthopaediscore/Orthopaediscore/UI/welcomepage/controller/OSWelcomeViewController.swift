//
//  OSWelcomeViewController.swift
//  Orthopaediscore
//
//  Created by S.t on 2017/5/18.
//  Copyright © 2017年 S.t. All rights reserved.
//

import Material
import UIKit

class OSWelcomeViewController: UIViewController {

    
    // Widgets
    
    @IBOutlet var UsernameInput: TextField!
    
    @IBOutlet var PasswordInput: TextField!
    
    @IBOutlet var LoginButton: UIButton!
    
    @IBOutlet var RegisterButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        self.setupUI()
        // Do any additional setup after loading the view.
    }
    
    func setupUI(){
        self.LoginButton.layer.borderWidth = 1
        self.LoginButton.layer.borderColor = UIColor.white.cgColor
        self.LoginButton.layer.cornerRadius = 5

        self.RegisterButton.layer.borderWidth = 1
        self.RegisterButton.layer.borderColor = UIColor.white.cgColor
        self.RegisterButton.layer.cornerRadius = 5
        
        self.UsernameInput.placeholderNormalColor = UIColor.lightGray
        self.UsernameInput.placeholder = "Username"
        self.UsernameInput.placeholderActiveColor = UIColor.lightGray
        
        
        self.PasswordInput.placeholderNormalColor = UIColor.lightGray
        self.PasswordInput.placeholder = "Password"
        self.PasswordInput.placeholderActiveColor = UIColor.lightGray


    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func LoginAction(_ sender: Any) {
        
        let vc = OSMainViewController()
//        let vc = OSPatientViewController()
        
        self.present(vc, animated: true, completion: nil)
    }
    
    @IBAction func RegisterAction(_ sender: Any) {
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
