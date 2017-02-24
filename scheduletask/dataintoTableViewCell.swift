//
//  dataintoTableViewCell.swift
//  scheduletask
//
//  Created by Sierra 4 on 23/02/17.
//  Copyright © 2017 codebrew. All rights reserved.
//

import UIKit
import ObjectMapper

class dataintoTableViewCell: UITableViewCell {
    
    var change: Instructor!
    

    
    
    @IBOutlet weak var view: UIView!
    @IBOutlet weak var subject: UILabel!
    @IBOutlet weak var maintime: UILabel!
    @IBOutlet weak var home: UILabel!
    @IBOutlet weak var address: UILabel!
    @IBOutlet weak var time: UILabel!
    @IBOutlet weak var lblnumber: UILabel!
    @IBOutlet weak var lblquantity: UILabel!
    @IBOutlet weak var lblmoney: UILabel!
    @IBOutlet weak var number: UILabel!
    @IBOutlet weak var quantity: UILabel!
    @IBOutlet weak var money: UILabel!
    
       override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
