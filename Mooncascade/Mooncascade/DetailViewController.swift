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
    var workerArrayWithSections:[[MainArray]] = []
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
        getNativeContacts(clickedIndexpath: nativeContactIndex)
    }
}
extension DetailViewController {
    func getNativeContacts(clickedIndexpath: IndexPath) {
        let fooBar = CNMutableContact()
        fooBar.givenName = workerArrayWithSections[clickedIndexpath.section][clickedIndexpath.row].fname!
        fooBar.familyName = workerArrayWithSections[clickedIndexpath.section][clickedIndexpath.row].lname!
        let homePhone = CNLabeledValue(label: CNLabelHome,value: CNPhoneNumber(stringValue: workerArrayWithSections[clickedIndexpath.section][clickedIndexpath.row].phone ?? ""))
        fooBar.phoneNumbers = [homePhone]
        let homeEmail = CNLabeledValue(label:CNLabelWork, value:workerArrayWithSections[clickedIndexpath.section][clickedIndexpath.row].email! as NSString)
        fooBar.emailAddresses = [homeEmail]
        let position = workerArrayWithSections[clickedIndexpath.section][clickedIndexpath.row].position ?? ""
        fooBar.jobTitle = "Position: \(position)"
        if workerArrayWithSections[clickedIndexpath.section][clickedIndexpath.row].projects != nil  {
            let projectArray = workerArrayWithSections[clickedIndexpath.section][clickedIndexpath.row].projects
            let projectList = projectArray!.joined(separator: ", ")
            fooBar.note = "Projects: \(projectList)"
        }
        let store = CNContactStore()
        let controller = CNContactViewController(for: fooBar)
        controller.contactStore = store
        controller.allowsEditing = false
        controller.displayedPropertyKeys = [CNContactEmailAddressesKey, CNContactPhoneNumbersKey,CNContactGivenNameKey,CNContactFamilyNameKey,CNContactJobTitleKey,CNContactNoteKey]
        self.navigationController?.pushViewController(controller, animated: true)
        self.navigationController?.navigationBar.isHidden = false
    }
}
