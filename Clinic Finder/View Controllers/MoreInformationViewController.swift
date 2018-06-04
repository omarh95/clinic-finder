//
//  MoreInformationViewController.swift
//  Clinic Finder
//
//  Created by Hayek, Omar on 5/8/18.
//  Copyright © 2018 Hayek, Omar. All rights reserved.
//

import UIKit

class MoreInformationViewController: UIViewController {

    @IBOutlet var clinicNameLabel: UILabel!
    
    @IBOutlet var clinicInfoTableView: UITableView!
    
    var selectedClinic: Clinic? {
        get { return ClinicsButler.sharedInstance.selectedClinic }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupClinicNameLabel()
        setupClinicInfoTableView()
    }
    
    private func setupClinicNameLabel() {
        clinicNameLabel.text = selectedClinic?.name
    }
    
    private func setupClinicInfoTableView() {
        clinicInfoTableView.delegate = self
        clinicInfoTableView.dataSource = self
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

extension MoreInformationViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .value2, reuseIdentifier: "clinic_info_cell")
        cell.textLabel?.text = "Phone Number"
        if let phoneNumber = selectedClinic?.phoneNumber {
            cell.detailTextLabel?.text = String(phoneNumber)
        } else {
            cell.detailTextLabel?.text = "N/A"
        }
        return cell
    }
}
