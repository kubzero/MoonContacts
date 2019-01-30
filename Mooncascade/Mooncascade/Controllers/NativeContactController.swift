//
//  NativeContactController.swift
//  Mooncascade
//
//  Created by Andrew on 30/01/2019.
//  Copyright © 2019 Andrew. All rights reserved.
//

import Foundation
import ContactsUI

extension UIViewController {
    func getNativeContactView(employee: EmployeeArray) {
        let contact = CNMutableContact()
        contact.givenName = employee.fname!
        contact.familyName = employee.lname!
        let homePhone = CNLabeledValue(label: CNLabelHome,value: CNPhoneNumber(stringValue: employee.phone ?? ""))
        contact.phoneNumbers = [homePhone]
        let homeEmail = CNLabeledValue(label:CNLabelWork, value:employee.email! as NSString)
        contact.emailAddresses = [homeEmail]
        let position = employee.position ?? ""
        contact.jobTitle = "Position: \(position)"
        if employee.projects != nil  {
            let projectArray = employee.projects
            let projectList = projectArray!.joined(separator: ", ")
            contact.note = "Projects: \(projectList)"
        }
        
        let store = CNContactStore()
        let controller = CNContactViewController(for: contact)
        controller.contactStore = store
        controller.allowsEditing = false
        controller.displayedPropertyKeys = [CNContactEmailAddressesKey, CNContactPhoneNumbersKey,CNContactGivenNameKey,CNContactFamilyNameKey,CNContactJobTitleKey,CNContactNoteKey]
        self.navigationController?.pushViewController(controller, animated: true)
        self.navigationController?.navigationBar.isHidden = false
    }
}
