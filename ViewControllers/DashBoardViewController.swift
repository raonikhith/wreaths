//
//  DashBoardViewController.swift
//  wreaths
//
//  Created by TechnisarInc on 25/09/19.
//  Copyright © 2019 TechnisarInc. All rights reserved.
//

import UIKit
import SwiftyJSON
import UICircularProgressRing

class DashBoardViewController: BaseViewController {

    
    var crossFading: Bool {
        return crossFadeSwitch.isOn
    }
    let duration = 1.0
    let fontSizeSmall: CGFloat = 20
    let fontSizeBig: CGFloat = 100
    var isSmall: Bool = true
    //IBOutlet's
    @IBOutlet weak var crossFadeSwitch: UISwitch!
    @IBOutlet weak var welcomeLbl: UILabel!
    
    @IBOutlet weak var totalSalesAmount:UILabel!
    @IBOutlet weak var commission:UILabel!
    
    @IBOutlet weak var totalSum: UICircularProgressRing!
    
    @IBOutlet weak var commissionView: UICircularProgressRing!
    
    
    //variable declaration's
    var orders = [JSON]()
    var orderDetails:JSON = JSON.null
    var price = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        self.title = "Wreaths"
        
        //configurations
      
        
        labelAnnimation(_label: self.commission, _labelColor: UIColor.purple)
        labelAnnimation(_label: self.totalSalesAmount, _labelColor: UIColor.purple)
        //reset(self.commission)
    }

    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
            price = 0
          configure_dash()
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
        let scaleX1 = boundsSales.size.width/_label.frame.size.width
        let scaleY1 = boundsSales.size.height/_label.frame.size.height
        UIView.animate(withDuration: 1.0, animations: {
            self.totalSalesAmount.transform = CGAffineTransform(scaleX: scaleX1, y: scaleY1)
        }, completion: { done in
           _label.font = labelCopy.font
           _label.transform = .identity
           _label.bounds = boundsSales
           _label.textColor = _labelColor
           _label.isHighlighted = !_label.isHighlighted
        })
    }
    func getUserOrders()
    {
        
        self.orders.removeAll()
        var fortyVal = 0
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
                        fortyVal = ((price*40)/100)
                        
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
                    
                    let percent = (100*price)/3000
                    self.totalSum.value = CGFloat(percent)
                    
                    print(fortyVal)
//                    let fotyValue = (100*fortyVal)/3000
//                    self.commissionView.value = CGFloat(fotyValue)
                    
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
        //ordersSegue
        //generateSegue
self.performSegue(withIdentifier:"generateSegue", sender:nil)
        
    }
    
    
    @IBAction func generateReportAction(_ sender: Any) {
        self.performSegue(withIdentifier:"ordersSegue", sender:nil)
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
    


@IBAction func reset(_ sender: Any) {
    var bounds = self.commission.bounds
    self.commission.font = self.commission.font.withSize(fontSizeSmall)
    bounds.size = self.commission.intrinsicContentSize
    self.commission.bounds = bounds
    isSmall = true
}

@IBAction func animateFont(_ sender: Any) {
    if isSmall {
        if crossFading {
            enlargeWithCrossFade()
        } else {
            enlarge()
        }
    } else {
        if crossFading {
            shrinkWithCrossFade()
        } else {
            shrink()
        }
    }
    isSmall = !isSmall
}

func enlarge() {
    var biggerBounds = commission.bounds
    commission.font = commission.font.withSize(fontSizeBig)
    biggerBounds.size = commission.intrinsicContentSize
    
    commission.transform = scaleTransform(from: biggerBounds.size, to: commission.bounds.size)
    commission.bounds = biggerBounds
    
    UIView.animate(withDuration: duration) {
        self.commission.transform = .identity
    }
}

func enlargeWithCrossFade() {
    let labelCopy = commission.copyLabel()
    view.addSubview(labelCopy)
    
    var biggerBounds = commission.bounds
    commission.font = commission.font.withSize(fontSizeBig)
    biggerBounds.size = commission.intrinsicContentSize
    
    commission.transform = scaleTransform(from: biggerBounds.size, to: commission.bounds.size)
    let enlargeTransform = scaleTransform(from: commission.bounds.size, to: biggerBounds.size)
    commission.bounds = biggerBounds
    commission.alpha = 0.0
    
    UIView.animate(withDuration: duration, animations: {
        self.commission.transform = .identity
        labelCopy.transform = enlargeTransform
    }, completion: { done in
        labelCopy.removeFromSuperview()
    })
    
    UIView.animate(withDuration: duration / 2) {
        self.commission.alpha = 1.0
        labelCopy.alpha = 0.0
    }
}

func shrink() {
    let labelCopy = commission.copyLabel()
    var smallerBounds = labelCopy.bounds
    labelCopy.font = commission.font.withSize(fontSizeSmall)
    smallerBounds.size = labelCopy.intrinsicContentSize
    
    let shrinkTransform = scaleTransform(from: commission.bounds.size, to: smallerBounds.size)
    
    UIView.animate(withDuration: duration, animations: {
        self.commission.transform = shrinkTransform
    }, completion: { done in
        self.commission.font = labelCopy.font
        self.commission.transform = .identity
        self.commission.bounds = smallerBounds
    })
}

func shrinkWithCrossFade() {
    let labelCopy = commission.copyLabel()
    view.addSubview(labelCopy)
    
    var smallerBounds = commission.bounds
    commission.font = commission.font.withSize(fontSizeSmall)
    smallerBounds.size = commission.intrinsicContentSize
    
    commission.transform = scaleTransform(from: smallerBounds.size, to: commission.bounds.size)
    commission.alpha = 0.0
    
    let shrinkTransform = scaleTransform(from: commission.bounds.size, to: smallerBounds.size)
    
    UIView.animate(withDuration: duration, animations: {
        labelCopy.transform = shrinkTransform
        self.commission.transform = .identity
    }, completion: { done in
        self.commission.transform = .identity
        self.commission.bounds = smallerBounds
    })
    
    let percUntilFade = 0.8
    UIView.animate(withDuration: duration - (duration * percUntilFade), delay: duration * percUntilFade, options: .curveLinear, animations: {
        labelCopy.alpha = 0
        self.commission.alpha = 1
    }, completion: { done in
        labelCopy.removeFromSuperview()
    })
}

private func scaleTransform(from: CGSize, to: CGSize) -> CGAffineTransform {
    let scaleX = to.width / from.width
    let scaleY = to.height / from.height
    
    return CGAffineTransform(scaleX: scaleX, y: scaleY)
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
