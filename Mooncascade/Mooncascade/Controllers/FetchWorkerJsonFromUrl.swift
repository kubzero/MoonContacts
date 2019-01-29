//
//  FetchJsonFromUrl.swift
//  Mooncascade
//
//  Created by Andrew on 22/01/2019.
//  Copyright © 2019 Andrew. All rights reserved.
//
import Foundation
import CoreData
extension ViewController {
    
    func fetchWorkerDatafrom(workerUrl:String,completion: @escaping (employeeJsonModel?) -> Void) {
        guard let url = URL(string: workerUrl) else { return }
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            if error != nil {
                DispatchQueue.main.async {
                    self.errorMessageFunc(errorTitle: "No Internet connection", errorMessage: "Trying to get data from last successful connection")
                    self.refreshControl.endRefreshing()
                    self.showData()
                }
            }
            guard let data = data, let _ = response else { return }
            do {
                let workerlist = try JSONDecoder().decode(employeeJsonModel.self, from: data)
                self.counter += workerlist.employees.count
                completion(workerlist)
            } catch  {
            }
            }.resume()
    }
}
