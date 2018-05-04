//
//  ClinicTableViewCell.swift
//  Clinic Finder
//
//  Created by Hayek, Omar on 4/17/18.
//  Copyright © 2018 Hayek, Omar. All rights reserved.
//

import UIKit
import MapKit

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
        guard let selectedClinic = getSelectedClinic() else { return }
        if let phoneNumber = selectedClinic.phoneNumber {
            PhoneController.openPhoneApp(withPhoneNumber: phoneNumber)
        }
    }
    
    @IBAction func directionsButtonPressed(_ sender: Any) {
        guard let selectedClinic = getSelectedClinic() else { return }
        if let name = selectedClinic.name, let location = selectedClinic.location {
            MapController.openMap(forLocation: location, andName: name)
        }
    }
    
    private func getSelectedClinic() -> Clinic? {
        let tableView = self.superview as! UITableView
        guard let cellRowIndexPath = tableView.indexPath(for: self) else { return nil }
        return allClinics[cellRowIndexPath.row]
    }
    
}
