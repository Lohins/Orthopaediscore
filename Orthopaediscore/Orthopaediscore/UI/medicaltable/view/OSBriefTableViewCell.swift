//
//  OSBriefTableViewCell.swift
//  Orthopaediscore
//
//  Created by S.t on 2017/6/1.
//  Copyright © 2017年 S.t. All rights reserved.
//

import UIKit

class OSBriefTableViewCell: UITableViewCell {

    @IBOutlet var checkIcon: UIImageView!
    
    @IBOutlet var contentLabel: UILabel!
    
    var selection: Bool = false
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func updateContent(content: String){
        self.contentLabel.text = content
    }
    
    @IBAction func tapAction(_ sender: Any) {
        if self.selection == true{
            self.selection = false
            self.checkIcon.image = nil
        }
        else{
            self.selection = true
            self.checkIcon.image = UIImage.init(named: "red_check_icon")
        }
        
    }
    
    
}
