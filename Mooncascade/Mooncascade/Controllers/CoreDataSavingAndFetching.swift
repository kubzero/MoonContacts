//
//  CoreDataSavingAndFetching.swift
//  Mooncascade
//
//  Created by Andrew on 29/01/2019.
//  Copyright © 2019 Andrew. All rights reserved.
//

import Foundation
import UIKit
import CoreData
extension ViewController {
    
    func saveToCoreData(arrayWithData:[EmployeeArray]) {
        self.deleteAllCoredataPositions()
        DispatchQueue.main.async {
            for each in arrayWithData{
                let appDelegate = UIApplication.shared.delegate as! AppDelegate
                let context = appDelegate.persistentContainer.viewContext
                let entity = NSEntityDescription.entity(forEntityName: "ListOfFetchedWorkers", in: context)
                let newUser = NSManagedObject(entity: entity!, insertInto: context)
                newUser.setValue(each.fname!, forKey: "fname")
                newUser.setValue(each.lname!, forKey: "lname")
                newUser.setValue(each.position ?? nil, forKey: "position")
                newUser.setValue(each.email ?? nil, forKey: "email")
                newUser.setValue(each.phone ?? nil, forKey: "phone")
                newUser.setValue(each.projects ?? nil, forKey: "projects")
                do {
                    try context.save()
                } catch {
                    DispatchQueue.main.async {
                        self.errorMessageFunc(errorTitle: "Failed to save data", errorMessage: "")
                    }
                }
            }
        }
    }
    
    func deleteAllCoredataPositions(){
        DispatchQueue.main.async {
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            let context = appDelegate.persistentContainer.viewContext
            let DelAllReqVar = NSBatchDeleteRequest(fetchRequest: NSFetchRequest<NSFetchRequestResult>(entityName: "ListOfFetchedWorkers"))
            do {
                try context.execute(DelAllReqVar)
            }
            catch {
                DispatchQueue.main.async {
                    self.errorMessageFunc(errorTitle: "Failed to delete data", errorMessage: "\(error)")
                }
            }
        }
    }
    
    func showData (){
        DispatchQueue.main.async {
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            let context = appDelegate.persistentContainer.viewContext
            let request = NSFetchRequest<NSFetchRequestResult>(entityName: "ListOfFetchedWorkers")
            do {
                let result = try context.fetch(request)
                for data in result as! [NSManagedObject] {
                    self.workerMergedArray.append(EmployeeArray(fname: data.value(forKey: "fname") as? String, lname: data.value(forKey: "lname") as? String, position:  data.value(forKey: "position") as? String, email:  data.value(forKey: "email") as? String, phone:  data.value(forKey: "phone") as? String, projects:  data.value(forKey: "projects") as? Array, phonebook: nil))
                }
                for each in self.workerMergedArray {
                    self.sectionHeaderTitles.append(each.position!)
                }
                self.formateArray(arrayWithHeaders: self.sectionHeaderTitles, arrayWithData: self.workerMergedArray,phoneContactArray: self.phoneContacts )
                self.tableView.reloadData()
                self.refreshControl.endRefreshing()
            } catch {
                DispatchQueue.main.async {
                    self.errorMessageFunc(errorTitle: "Failed to load data from last connection", errorMessage: "")
                }
            }
        }
    }
}
