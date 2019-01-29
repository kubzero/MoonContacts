//
//  TableViewCell.swift
//  Mooncascade
//
//  Created by Andrew on 23/01/2019.
//  Copyright © 2019 Andrew. All rights reserved.
//

import UIKit

class ReusableCell: UITableViewCell {
    
    @IBOutlet var cellName: UILabel!
    @IBOutlet var cellButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
