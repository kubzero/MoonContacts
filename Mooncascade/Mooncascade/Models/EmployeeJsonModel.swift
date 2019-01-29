//
//  EmployeeJsonModel.swift
//  Mooncascade
//
//  Created by Andrew on 22/01/2019.
//  Copyright © 2019 Andrew. All rights reserved.
//

import Foundation

struct employeeJsonModel: Codable {
    let employees: [Employee]
}

struct Employee: Codable {
    let fname, lname: String
    let position: String
    let contactDetails: ContactDetails
    let projects: [String]?
    
    enum CodingKeys: String, CodingKey {
        case fname, lname, position
        case contactDetails = "contact_details"
        case projects
    }
}

struct ContactDetails: Codable {
    let email: String
    let phone: String?
}
