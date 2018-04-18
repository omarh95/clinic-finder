//
//  ClinicTableViewCell.swift
//  Clinic Finder
//
//  Created by Hayek, Omar on 4/17/18.
//  Copyright © 2018 Hayek, Omar. All rights reserved.
//

import UIKit

class ClinicTableViewCell: UITableViewCell {
    
    @IBOutlet var clinicNameLabel: UILabel!
    @IBOutlet var clinicServicesLabel: UILabel!
    @IBOutlet var clinicDistanceLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
