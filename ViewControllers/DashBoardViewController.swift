//
//  DashBoardViewController.swift
//  wreaths
//
//  Created by TechnisarInc on 25/09/19.
//  Copyright © 2019 TechnisarInc. All rights reserved.
//

import UIKit

class DashBoardViewController: BaseViewController {

    //IBOutlet's
    @IBOutlet weak var welcomeLbl: UILabel!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        self.title = "Wreath"
        
        //configurations
        configure_dash()

    }

    
    
    func configure_dash()
    {
        
        //hiding the back button
        navigationItem.hidesBackButton = true
        
        self.welcomeLbl.text = #"""
            Hello Mr \#(self.userData["FirstName"] as! String)
            Total Amount of sales
            Total Amount of commission
            """#
        
    }
    
    
    
    //method to createOrder the reports
    @IBAction func createOrder(_ sender: Any) {
        
    }
    
    //method to generate the reports
    @IBAction func generateReport(_ sender: Any) {
        
    }
    
    //method to generate the reports
    @IBAction func logout(_ sender: Any) {
        
    }
}
