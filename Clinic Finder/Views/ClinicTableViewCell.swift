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
    
    var allClinics: [Clinic] {
        get {
            return LoadClinicsButler.sharedInstance.allClinics
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    @IBAction func callButtonPressed(_ sender: Any) {
        let cellRow = (self.superview! as! UITableView).indexPath(for: self)?.row
        let selectedClinic = allClinics[cellRow!]
        if let url = URL(string: "tel://\(selectedClinic.phoneNumber!)"), UIApplication.shared.canOpenURL(url) {
            if #available(iOS 10, *) {
                UIApplication.shared.open(url)
            } else {
                UIApplication.shared.openURL(url)
            }
        } 
    }
    
    @IBAction func directionsButtonPressed(_ sender: Any) {
        print("pressed")
    }
}
