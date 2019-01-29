//
//  NativeContactCaller
//  Mooncascade
//
//  Created by Andrew on 29/01/2019.
//  Copyright © 2019 Andrew. All rights reserved.
//
import  UIKit
import ContactsUI
import Foundation

extension ViewController {
    func getNativeContactView(clickedIndexpath: IndexPath) {
        let fooBar = CNMutableContact()
        fooBar.givenName = workerMergedArrayWithHeaders[clickedIndexpath.section][clickedIndexpath.row].fname!
        fooBar.familyName = workerMergedArrayWithHeaders[clickedIndexpath.section][clickedIndexpath.row].lname!
        let homePhone = CNLabeledValue(label: CNLabelHome,value: CNPhoneNumber(stringValue: workerMergedArrayWithHeaders[clickedIndexpath.section][clickedIndexpath.row].phone ?? ""))
        fooBar.phoneNumbers = [homePhone]
        let homeEmail = CNLabeledValue(label:CNLabelWork, value:workerMergedArrayWithHeaders[clickedIndexpath.section][clickedIndexpath.row].email! as NSString)
        fooBar.emailAddresses = [homeEmail]
        let position = workerMergedArrayWithHeaders[clickedIndexpath.section][clickedIndexpath.row].position ?? ""
        fooBar.jobTitle = "Position: \(position)"
        if workerMergedArrayWithHeaders[clickedIndexpath.section][clickedIndexpath.row].projects != nil  {
            let projectArray = workerMergedArrayWithHeaders[clickedIndexpath.section][clickedIndexpath.row].projects
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

