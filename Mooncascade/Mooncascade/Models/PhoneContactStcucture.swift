//
//  PhoneContactStcucture.swift
//  Mooncascade
//
//  Created by Andrew on 23/01/2019.
//  Copyright © 2019 Andrew. All rights reserved.
//

import Foundation

struct PhoneContactStructure: Codable {
    let name:String?
    let lastname:String?
    let phoneNr:String?
   
    init(name: String? = nil,lastname: String? = nil,phoneNr: String? = nil) {
        self.name = name
        self.lastname = lastname
        self.phoneNr = phoneNr
    }
}
