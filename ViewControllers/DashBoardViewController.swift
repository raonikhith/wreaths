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
    
    
    @IBOutlet weak var firstImage: UIImageView!
    
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
        let flash = CABasicAnimation(keyPath: "opacity")
        flash.duration = 0.5
        flash.fromValue = 1
        flash.toValue = 0.1
        flash.timingFunction = CAMediaTimingFunction(name:
            CAMediaTimingFunctionName.easeInEaseOut)
        flash.autoreverses = true
        flash.repeatCount = 3
        self.firstImage.fadeTransition(0.4)
       // self.firstImage.text = "text"
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
extension UIView{
    func fadeTransition(_ duration:CFTimeInterval){
        let animation = CATransition()
        animation.timingFunction = CAMediaTimingFunction(name:
            CAMediaTimingFunctionName.easeInEaseOut)
        animation.type = CATransitionType.fade
        animation.duration = duration
        layer.add(animation, forKey: CATransitionType.fade.rawValue)
    }
}
