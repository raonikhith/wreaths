//
//  DashBoardViewController.swift
//  wreaths
//
//  Created by TechnisarInc on 25/09/19.
//  Copyright © 2019 TechnisarInc. All rights reserved.
//

import UIKit
import SwiftyJSON

class DashBoardViewController: BaseViewController {

    //IBOutlet's
    @IBOutlet weak var welcomeLbl: UILabel!
    
    @IBOutlet weak var totalSalesAmount: UILabel!
    @IBOutlet weak var commission: UILabel!
    //variable declaration's
    var orders = [JSON]()
    var orderDetails:JSON = JSON.null
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        self.title = "Wreath"
        
        //configurations
        configure_dash()
        
        labelAnnimation(_label: self.commission, _labelColor: UIColor.red)
        labelAnnimation(_label: self.totalSalesAmount, _labelColor: UIColor.green)
        
    }

    
    
    func configure_dash()
    {
        
        //hiding the back button
        navigationItem.hidesBackButton = true
        getUserOrders()
     
    }
    
    func labelAnnimation(_label:UILabel, _labelColor:UIColor){
        let labelCopy = _label.copyLabel()
        labelCopy.font = _label.font.withSize(20)
        var boundsSales = labelCopy.bounds
        boundsSales.size = labelCopy.intrinsicContentSize
        let scaleX1 = boundsSales.size.width / _label.frame.size.width
        let scaleY1 = boundsSales.size.height / _label.frame.size.height
        UIView.animate(withDuration: 2.0, animations: {
            self.totalSalesAmount.transform = CGAffineTransform(scaleX: scaleX1, y: scaleY1)
        }, completion: { done in
            _label.font = labelCopy.font
            _label.transform = .identity
            _label.bounds = boundsSales
            _label.textColor = _labelColor
        })
    }
    func getUserOrders()
    {
        _ = db.collection("Orders").document(self.userData["FirstName"] as! String).collection("uOrders").getDocuments(){(querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
            } else {
                if querySnapshot!.documents.count>0
                {
                for document in querySnapshot!.documents {
                    print("\(document.documentID) => \(document.data())")
                    var data = document.data()
                    data["dID"] = document.documentID
                    self.orders.append(JSON(data))
                }
                    var price = Int()
                           for i in 0..<self.orders.count
                           {
                               price += self.orders[i]["UserDetails"]["Price"].intValue
                           }
                           
                           print(price)
                    
                    if (price > 0 ){
                        self.welcomeLbl.text = #"""
                        Hello Mr \#(self.userData["FirstName"] as! String)
                        Total Amount of sales $ \#(price)
                        Total Amount of commission $ \#((price*40)/100)
                        """#
                        self.totalSalesAmount.text = "$\(price)"
                        self.commission.text = "$\((price*40)/100)"
                    }
                    else{
                        self.welcomeLbl.text = #"""
                        Hello Mr \#(self.userData["FirstName"] as! String)
                        Total Amount of sales $ \#(price)
                        Total Amount of commission $ \#(price)
                        """#
                        self.totalSalesAmount.text = "$\(price)"
                        self.commission.text = "$\(price)"
                    }
                }

                else
                {
                   
                   
                }
            }

        }
        
       
    }
    
    
    
    //method to createOrder the reports
    @IBAction func createOrder(_ sender: Any) {
        
    }
    
    //method to generate the reports
    @IBAction func generateReport(_ sender: Any) {
        
        self.performSegue(withIdentifier:"generateSegue", sender:nil)
    }
    
    
    //called when clicked on userICON on navi bar
    @IBAction func userAction(_ sender: Any) {
        
        let alert = UIAlertController(title: "Sign out?", message: "Hi \(self.userData["FirstName"] as! String) You can always access your content by signing back in",         preferredStyle: UIAlertController.Style.alert)

        alert.addAction(UIAlertAction(title: "Cancel", style: UIAlertAction.Style.default, handler: { _ in
            //Cancel Action
        }))
        alert.addAction(UIAlertAction(title: "Sign out",
                                      style: UIAlertAction.Style.destructive,
                                      handler: {(_: UIAlertAction!) in
                                        //Sign out action
                                        self.navigationController?.popToRootViewController(animated: true)
        }))
        self.present(alert, animated: true, completion: nil)
        
        
    }
    
}
extension UILabel {
    func copyLabel() -> UILabel {
        let label = UILabel()
        label.font = self.font
        label.frame = self.frame
        label.text = self.text
        return label
    }
}
