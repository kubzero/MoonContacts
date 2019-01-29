//
//  FormateAndRestructFunc.swift
//  Mooncascade
//
//  Created by Andrew on 29/01/2019.
//  Copyright © 2019 Andrew. All rights reserved.
//

import Foundation

extension ViewController {
    
    func formateArray(arrayWithHeaders:[String],arrayWithData:[MainArray], phoneContactArray:[MainArray]) {
        var arrayWithWorkersAndButtonState:[MainArray] = []
        //save workers to coredata
        self.saveToCoreData(arrayWithData: arrayWithData)
        //append and sort according to group
        for eachWorker in arrayWithData {
            if phoneContactArray.contains(MainArray(fname: eachWorker.fname, lname: eachWorker.lname, position: nil, email: nil, phone: nil, projects: nil, phonebook: nil)) {
                arrayWithWorkersAndButtonState.append(MainArray(fname: eachWorker.fname, lname: eachWorker.lname, position: eachWorker.position, email: eachWorker.email, phone: eachWorker.phone, projects: eachWorker.projects, phonebook: true))
            } else {
                arrayWithWorkersAndButtonState.append(MainArray(fname: eachWorker.fname, lname: eachWorker.lname, position: eachWorker.position, email: eachWorker.email, phone: eachWorker.phone, projects: eachWorker.projects, phonebook: false))
            }
        }
        //clean for uniq elements.
        let uniqueArrayWithWorkers = Array(Set(arrayWithWorkersAndButtonState))
        //Remvoe not unique Header values
        let arrayWithUniqueHeaders = Array(Set(arrayWithHeaders))
        self.sectionHeaderTitles = arrayWithUniqueHeaders.sorted { $0 < $1 }
        
        var androidPos = [MainArray]()
        var iosPos = [MainArray]()
        var testPos = [MainArray]()
        var salePos = [MainArray]()
        var otherPos = [MainArray]()
        var pmPos = [MainArray]()
        var webPos = [MainArray]()
        
        for each in uniqueArrayWithWorkers {
            switch each.position! {
            case "ANDROID":
                androidPos.append(MainArray(fname: each.fname, lname: each.lname, position: each.position, email: each.email, phone: each.phone, projects: each.projects,phonebook: each.phonebook))
            case "IOS":
                iosPos.append(MainArray(fname: each.fname, lname: each.lname, position: each.position, email: each.email, phone: each.phone, projects: each.projects,phonebook: each.phonebook))
            case "OTHER":
                otherPos.append(MainArray(fname: each.fname, lname: each.lname, position: each.position, email: each.email, phone: each.phone, projects: each.projects,phonebook: each.phonebook))
            case "PM":
                pmPos.append(MainArray(fname: each.fname, lname: each.lname, position: each.position, email: each.email, phone: each.phone, projects: each.projects,phonebook: each.phonebook))
            case "SALES":
                salePos.append(MainArray(fname: each.fname, lname: each.lname, position: each.position, email: each.email, phone: each.phone, projects: each.projects,phonebook: each.phonebook))
            case "TESTER":
                testPos.append(MainArray(fname: each.fname, lname: each.lname, position: each.position, email: each.email, phone: each.phone, projects: each.projects,phonebook: each.phonebook))
            case "WEB":
                webPos.append(MainArray(fname: each.fname, lname: each.lname, position: each.position, email: each.email, phone: each.phone, projects: each.projects,phonebook: each.phonebook))
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

