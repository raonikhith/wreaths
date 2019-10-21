//
//  PKButton.swift
//  Basok
//
//  Created by DsquareTechLabs on 23/12/16.
//  Copyright © 2016 DsquareTechLabs. All rights reserved.
//

import UIKit

class PKButton: UIButton {

    override func awakeFromNib() {
        super.awakeFromNib()
                
}

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        layer.borderWidth = 1.0
        layer.borderColor = UIColor(red:0.90, green:0.90, blue:0.90, alpha:1.0).cgColor
        layer.cornerRadius = 5.0
        clipsToBounds = true
        contentEdgeInsets = UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8)
        setTitleColor(.black, for: .normal)
        setTitleColor(.black, for: .highlighted)
        
}
}
