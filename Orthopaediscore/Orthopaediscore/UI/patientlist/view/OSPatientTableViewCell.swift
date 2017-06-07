//
//  OSPatientTableViewCell.swift
//  Orthopaediscore
//
//  Created by YI ZHANG on 2017-05-27.
//  Copyright © 2017 S.t. All rights reserved.
//

import UIKit

class OSPatientTableViewCell: UITableViewCell {
    
    @IBOutlet weak var NameLabel: UILabel!
    @IBOutlet weak var DepLabel: UILabel!
    @IBOutlet weak var IntimeLabel: UILabel!
    @IBOutlet weak var OuttimeLabel: UILabel!
    @IBOutlet weak var InfoLabel: UILabel!
    @IBOutlet weak var GenderImage: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func update(patient: OSPatient){
        self.NameLabel.text = patient.name
        self.OuttimeLabel.text = patient.leaveDate?.toString()
        self.IntimeLabel.text = patient.admissDate?.toString()
        self.InfoLabel.text = patient.comment
        if let name = OSAppCenter.sharedInstance.officeDict[patient.office]{
            self.DepLabel.text = name
        }
    }
    
}
