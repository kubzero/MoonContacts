//
//  testArray.swift
//  Mooncascade
//
//  Created by Andrew on 22/01/2019.
//  Copyright © 2019 Andrew. All rights reserved.
//

import Foundation
struct MainArray: Codable,Equatable, Hashable  {
    static func == (first: MainArray, second: MainArray) -> Bool {
        return first.fname?.lowercased() == second.fname?.lowercased() && first.lname?.lowercased() == second.lname?.lowercased()
    }
    
    let fname:String?
    let lname:String?
    let position:String?
    let email: String?
    let phone: String?
    let projects: [String]?
    let phonebook: Bool?
    
    init(fname: String? = nil,lname: String? = nil,position: String? = nil,email: String? = nil,phone: String? = nil,projects: [String]? = nil, phonebook: Bool? = nil) {
        
        self.fname = fname
        self.lname = lname
        self.position = position
        self.email = email
        self.phone = phone
        self.projects = projects
        self.phonebook = phonebook
    }
}
