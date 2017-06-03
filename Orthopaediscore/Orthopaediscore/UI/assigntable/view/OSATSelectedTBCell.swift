//
//  OSATSelectedTBCell.swift
//  Orthopaediscore
//
//  Created by S.t on 2017/6/3.
//  Copyright © 2017年 S.t. All rights reserved.
//

import UIKit

class OSATSelectedTBCell: UITableViewCell {

    @IBOutlet var titleLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
    func updateTitle(title: String){
        self.titleLabel.text = title
    }
    
}
