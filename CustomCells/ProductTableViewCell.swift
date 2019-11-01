//
//  ProductTableViewCell.swift
//  wreaths
//
//  Created by TechnisarInc on 25/09/19.
//  Copyright © 2019 TechnisarInc. All rights reserved.
//

import UIKit
import ValueStepper

class ProductTableViewCell: UITableViewCell {

    @IBOutlet weak var pNameLbl: UILabel!
    @IBOutlet weak var priceLbl: UILabel!
    
   
    
    @IBOutlet weak var stepperView: UIView!
    
    @IBOutlet weak var valueLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
   
}
