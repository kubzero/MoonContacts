//
//  FormateAndRestructFunc.swift
//  Mooncascade
//
//  Created by Andrew on 29/01/2019.
//  Copyright © 2019 Andrew. All rights reserved.
//

import Foundation

extension ViewController {
    func formateArray(arrayWithHeaders:[String],arrayWithData:[EmployeeArray], phoneContactArray:[EmployeeArray]) {
        var arrayWithWorkersAndButtonState:[EmployeeArray] = []
        //append and sort according to group
        for eachWorker in arrayWithData {
            if phoneContactArray.contains(EmployeeArray(fname: eachWorker.fname, lname: eachWorker.lname, position: nil, email: nil, phone: nil, projects: nil, phonebook: nil)) {
                arrayWithWorkersAndButtonState.append(EmployeeArray(fname: eachWorker.fname, lname: eachWorker.lname, position: eachWorker.position, email: eachWorker.email, phone: eachWorker.phone, projects: eachWorker.projects, phonebook: true))
            } else {
                arrayWithWorkersAndButtonState.append(EmployeeArray(fname: eachWorker.fname, lname: eachWorker.lname, position: eachWorker.position, email: eachWorker.email, phone: eachWorker.phone, projects: eachWorker.projects, phonebook: false))
            }
        }
        //clean for uniq elements.
        let uniqueArrayWithWorkers = Array(Set(arrayWithWorkersAndButtonState))
        //Remvoe not unique Header values
        let arrayWithUniqueHeaders = Array(Set(arrayWithHeaders))
        self.sectionHeaderTitles = arrayWithUniqueHeaders.sorted { $0 < $1 }
        
        var androidPos = [EmployeeArray]()
        var iosPos = [EmployeeArray]()
        var testPos = [EmployeeArray]()
        var salePos = [EmployeeArray]()
        var otherPos = [EmployeeArray]()
        var pmPos = [EmployeeArray]()
        var webPos = [EmployeeArray]()
        
        for each in uniqueArrayWithWorkers {
            switch each.position! {
            case "ANDROID":
                androidPos.append(EmployeeArray(fname: each.fname, lname: each.lname, position: each.position, email: each.email, phone: each.phone, projects: each.projects,phonebook: each.phonebook))
            case "IOS":
                iosPos.append(EmployeeArray(fname: each.fname, lname: each.lname, position: each.position, email: each.email, phone: each.phone, projects: each.projects,phonebook: each.phonebook))
            case "OTHER":
                otherPos.append(EmployeeArray(fname: each.fname, lname: each.lname, position: each.position, email: each.email, phone: each.phone, projects: each.projects,phonebook: each.phonebook))
            case "PM":
                pmPos.append(EmployeeArray(fname: each.fname, lname: each.lname, position: each.position, email: each.email, phone: each.phone, projects: each.projects,phonebook: each.phonebook))
            case "SALES":
                salePos.append(EmployeeArray(fname: each.fname, lname: each.lname, position: each.position, email: each.email, phone: each.phone, projects: each.projects,phonebook: each.phonebook))
            case "TESTER":
                testPos.append(EmployeeArray(fname: each.fname, lname: each.lname, position: each.position, email: each.email, phone: each.phone, projects: each.projects,phonebook: each.phonebook))
            case "WEB":
                webPos.append(EmployeeArray(fname: each.fname, lname: each.lname, position: each.position, email: each.email, phone: each.phone, projects: each.projects,phonebook: each.phonebook))
            default:
                print("one contact is out of positions")
            }
        }
        //Sort by last name all workers
        let allPositions = [androidPos,iosPos,otherPos,pmPos,salePos,testPos,webPos]
        let sortedPositions = allPositions.map { $0.sorted(by: { ($0.lname ?? "") < ($1.lname ?? "") } ) }
        workerMergedArrayWithHeaders.append(contentsOf: sortedPositions)
    }
}

