//
//  ErrorMessageFunc.swift
//  Mooncascade
//
//  Created by Andrew on 28/01/2019.
//  Copyright © 2019 Andrew. All rights reserved.
//

import Foundation
import UIKit

extension ViewController {
    func errorMessageFunc(errorTitle:String,errorMessage:String){
        let alert = UIAlertController(title: errorTitle, message: errorMessage, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        self.present(alert, animated: true)
    }
}
