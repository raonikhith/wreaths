//
//  CreateOrderTableViewCell.swift
//  wreaths
//
//  Created by TechnisarInc on 29/09/19.
//  Copyright © 2019 TechnisarInc. All rights reserved.
//

import UIKit

class CreateOrderTableViewCell: UITableViewCell {
    @IBOutlet weak var pnameLbl: UILabel!
    @IBOutlet weak var qtyLbl: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
