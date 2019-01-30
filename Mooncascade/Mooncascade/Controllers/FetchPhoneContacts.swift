//
//  FetchPhoneContacts.swift
//  Mooncascade
//
//  Created by Andrew on 23/01/2019.
//  Copyright © 2019 Andrew. All rights reserved.
//

import Foundation
import ContactsUI

extension ViewController {
    
    func fetchPhoneContacts(){
        let store = CNContactStore()
        store.requestAccess(for: .contacts) { (granted, err) in
            if let err = err {
                DispatchQueue.main.async {
                    self.errorMessageFunc(errorTitle: "Cannot get contacts", errorMessage: "\(err)")
                }
            }
            if granted {
                print("Access to contacts granted")
                let keys = [CNContactGivenNameKey,CNContactFamilyNameKey,CNContactPhoneNumbersKey]
                let request = CNContactFetchRequest(keysToFetch: keys as [CNKeyDescriptor])
                do {
                    try store.enumerateContacts(with: request, usingBlock: { (contact, stop) in
                        self.phoneContacts.append(EmployeeArray(fname: contact.givenName, lname: contact.familyName, position: nil, email: nil, phone: contact.phoneNumbers.first?.value.stringValue, projects: nil, phonebook: nil))
                    })
                }catch {
                    DispatchQueue.main.async {
                        self.errorMessageFunc(errorTitle: "Failed to enumerate contacts", errorMessage: "")
                    }
                }
            } else  {
                DispatchQueue.main.async {
                    self.errorMessageFunc(errorTitle: "Access denide", errorMessage: "")
                }
            }
        }
        self.getWorkersWromBothTowns()
    }
}
