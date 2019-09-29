//
//  CheckOutViewController.swift
//  wreaths
//
//  Created by TechnisarInc on 28/09/19.
//  Copyright © 2019 TechnisarInc. All rights reserved.
//

import UIKit

class CheckOutViewController: BaseViewController
{
    
    @IBOutlet weak var nameTF: UITextField!
    @IBOutlet weak var mobileTF: UITextField!
    @IBOutlet weak var emailTF: UITextField!
    @IBOutlet weak var addressTF: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
      
    }
    

    @IBAction func submitAction(_ sender: Any)
    {
        var carts = [[String:Any]]()
              for c in 0..<self.cartObjects.count
              {
                  carts.append(self.cartObjects[c].dictionaryObject!)
              }
        let userDetails = ["Name":nameTF.text,"Mobile":mobileTF.text,"Email":emailTF.text,"Address":addressTF.text]
         cart = ["UserDetails":userDetails,
                "OrderDetails":carts]
                 
        db.collection("Orders").document(self.userData["FirstName"] as! String).setData(userData)
        db.collection("Orders").document(self.userData["FirstName"] as! String).collection("uOrders").document().setData(cart)
        
        let alertView = UIAlertController(title: "", message: "Order Created Successfully", preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .default, handler: { (alert) in
            self.navigationController?.popToViewController(ofClass: DashBoardViewController.self)

        })
        alertView.addAction(action)
        self.present(alertView, animated: true, completion: nil)
        
    }
    

}


extension UINavigationController {
  func popToViewController(ofClass: AnyClass, animated: Bool = true) {
    if let vc = viewControllers.filter({$0.isKind(of: ofClass)}).last {
      popToViewController(vc, animated: animated)
    }
  }
}
