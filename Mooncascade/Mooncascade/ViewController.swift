//
//  ViewController.swift
//  Mooncascade
//
//  Created by Andrew on 22/01/2019.
//  Copyright © 2019 Andrew. All rights reserved.
//

import UIKit
import ContactsUI
import CoreData

class ViewController: UIViewController, CNContactPickerDelegate, UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate {
    
    @IBOutlet var tableView: UITableView!
    @IBOutlet var searchBar: UISearchBar!
    
    let tallinnWorkerList = "https://tallinn-jobapp.aw.ee/employee_list"
    let tartuWorkerList = "https://tartu-jobapp.aw.ee/employee_list"
    let contactPickerViewController = CNContactPickerViewController()
    let refreshControl = UIRefreshControl()
    let searchController = UISearchController(searchResultsController: nil)
    var counter = 0
    var workerMergedArray:[MainArray] = []
    var phoneContacts:[MainArray] = []
    var sectionHeaderTitles:[String] = []
    var workerMergedArrayWithHeaders:[[MainArray]] = []
    var indexPathForDetailView:IndexPath = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboardWhenTappedAround()
        searchBar.delegate = self
        searchBar.returnKeyType = UIReturnKeyType.search
        refreshControl.attributedTitle = NSAttributedString(string: "Loading data from server, please wait!")
        refreshControl.addTarget(self, action: #selector(refresh(sender:)), for: UIControl.Event.valueChanged)
        tableView.addSubview(refreshControl)
        contactPickerViewController.delegate = self
        fetchPhoneContacts()
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return sectionHeaderTitles.count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return sectionHeaderTitles[section]
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return workerMergedArrayWithHeaders[section].count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reusableCell", for: indexPath) as! ReusableCell
        cell.cellName.text = "\(workerMergedArrayWithHeaders[indexPath.section][indexPath.row].fname!) \(workerMergedArrayWithHeaders[indexPath.section][indexPath.row].lname!)"
        cell.cellButton.addTarget(self, action: #selector(ViewController.buttonClicked(sender:)), for: .touchUpInside)
        if workerMergedArrayWithHeaders[indexPath.section][indexPath.row].phonebook == true {
            cell.cellButton.isHidden = false
        } else {
            cell.cellButton.isHidden = true
        }
        return cell
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "toDetails") {
            let secondViewController = segue.destination as! DetailViewController
            secondViewController.name = workerMergedArrayWithHeaders[indexPathForDetailView.section][indexPathForDetailView.row].fname! + " " + workerMergedArrayWithHeaders[indexPathForDetailView.section][indexPathForDetailView.row].lname!
            secondViewController.email = workerMergedArrayWithHeaders[indexPathForDetailView.section][indexPathForDetailView.row].email!
            secondViewController.phone = workerMergedArrayWithHeaders[indexPathForDetailView.section][indexPathForDetailView.row].phone ?? ""
            secondViewController.position = workerMergedArrayWithHeaders[indexPathForDetailView.section][indexPathForDetailView.row].position  ?? ""
            secondViewController.phonebook = workerMergedArrayWithHeaders[indexPathForDetailView.section][indexPathForDetailView.row].phonebook  ?? false
            secondViewController.projects = workerMergedArrayWithHeaders[indexPathForDetailView.section][indexPathForDetailView.row].projects ?? []
            secondViewController.nativeContactIndex = indexPathForDetailView
            secondViewController.workerArrayWithSections = workerMergedArrayWithHeaders
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let indexPath = tableView.indexPathForSelectedRow!
        indexPathForDetailView = indexPath
        performSegue(withIdentifier: "toDetails", sender: self)
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        workerMergedArrayWithHeaders.removeAll()
        updateTable()
    }
    
    func updateTable() {
        var sortedData = workerMergedArray
        guard let text = searchBar.text?.lowercased() else { return }
        if text.count > 1 {
            sortedData = sortedData.filter { $0.lname!.lowercased().contains(text) || $0.fname!.lowercased().contains(text) || ($0.email?.contains(text))! || ($0.position?.lowercased().contains(text))!
            }
            formateArray(arrayWithHeaders: sectionHeaderTitles, arrayWithData: sortedData, phoneContactArray: phoneContacts)
            self.tableView.reloadData()
        } else  {
            formateArray(arrayWithHeaders: sectionHeaderTitles, arrayWithData: workerMergedArray , phoneContactArray: phoneContacts)
            self.tableView.reloadData()
        }
    }
    
    @objc func buttonClicked(sender : UIButton!) {
        let touchPoint = sender.convert(CGPoint.zero, to: self.tableView)
        let clickedButtonIndexPath = tableView.indexPathForRow(at: touchPoint)
        getNativeContactView(clickedIndexpath: clickedButtonIndexPath!)
    }
    
    @objc func refresh(sender:AnyObject) {
        counter = 0
        workerMergedArray.removeAll()
        sectionHeaderTitles.removeAll()
        workerMergedArrayWithHeaders.removeAll()
        fetchPhoneContacts()
        self.tableView.reloadData()
    }
}

extension Array {
    func filterDuplicates(includeElement: @escaping (_ lhs:Element, _ rhs:Element) -> Bool) -> [Element]{
        var results = [Element]()
        forEach { (element) in
            let existingElements = results.filter {
                return includeElement(element, $0)
            }
            if existingElements.count == 0 {
                results.append(element)
            }
        }
        return results
    }
}

extension UIViewController {
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}

