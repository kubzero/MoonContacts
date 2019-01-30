//
//  DetailViewController.swift
//  Mooncascade
//
//  Created by Andrew on 29/01/2019.
//  Copyright © 2019 Andrew. All rights reserved.
//

import UIKit
import ContactsUI

class DetailViewController: UIViewController {
    var workerArrayWithSections:[[EmployeeArray]] = []
    var nativeContactIndex:IndexPath = []
    var name:String = ""
    var email:String = ""
    var phone:String = ""
    var position:String = ""
    var projects:[String] = []
    var phonebook:Bool = false
    @IBOutlet var workerFullName: UILabel!
    @IBOutlet var workerPhone: UILabel!
    @IBOutlet var workerEmail: UILabel!
    @IBOutlet var workerPosition: UILabel!
    @IBOutlet var workerProjects: UILabel!
    @IBOutlet var nativeContactView: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        loadInfoToCells()
    }
    
    func loadInfoToCells() {
        workerFullName.text = name
        workerEmail.text = "Email: \(email.lowercased())"
        workerPhone.text = "Tel: \(phone.lowercased())"
        workerPosition.text = "Position: \(position.lowercased())"
        if !projects.isEmpty  {
            let joinedSting = projects.joined(separator:", ")
            workerProjects.text = "Finished projects: \(joinedSting)"
        } else  {
            workerProjects.text = ""
        }
        if phonebook == false {
            nativeContactView.isHidden = true
        } else {
            nativeContactView.isHidden = false
        }
        
    }
    @IBAction func openNativeContactView(_ sender: Any) {
        let employee = workerArrayWithSections[nativeContactIndex.section][nativeContactIndex.row]
        self.getNativeContactView(employee: employee)
    }
}
