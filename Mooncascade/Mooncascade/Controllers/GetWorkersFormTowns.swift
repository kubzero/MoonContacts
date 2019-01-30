//
//  GetWorkersFormTowns.swift
//  Mooncascade
//
//  Created by Andrew on 29/01/2019.
//  Copyright © 2019 Andrew. All rights reserved.
//

import Foundation

extension ViewController {
    func getWorkersWromBothTowns(){
        fetchWorkerDatafrom(workerUrl: tallinnWorkerList) { workerlist in
            for each in (workerlist?.employees)! {
                self.workerMergedArray.append(EmployeeArray(fname: each.fname, lname: each.lname, position: each.position, email: each.contactDetails.email, phone: each.contactDetails.phone, projects: each.projects, phonebook: nil))
                self.sectionHeaderTitles.append(each.position)
            }
            if self.workerMergedArray.count == self.counter  {
                self.fetchWorkerDatafrom(workerUrl: self.tartuWorkerList) {  workerlist in
                    for each in (workerlist?.employees)! {
                        self.workerMergedArray.append(EmployeeArray(fname: each.fname, lname: each.lname, position: each.position, email: each.contactDetails.email, phone: each.contactDetails.phone, projects: each.projects, phonebook: nil))
                        self.sectionHeaderTitles.append(each.position)
                    }
                    //save workers to coredata
                    self.saveToCoreData(arrayWithData: self.workerMergedArray)
                    self.formateArray(arrayWithHeaders: self.sectionHeaderTitles, arrayWithData: self.workerMergedArray,phoneContactArray: self.phoneContacts )
                    DispatchQueue.main.async {
                        self.tableView.reloadData()
                        self.refreshControl.endRefreshing()
                    }
                }
            }
        }
    }
}
