//
//  CartViewController.swift
//  wreaths
//
//  Created by TechnisarInc on 28/09/19.
//  Copyright © 2019 TechnisarInc. All rights reserved.
//

import UIKit
import SwiftyJSON

class CartViewController: BaseViewController {
    
    @IBOutlet weak var TotalLbl: UILabel!
    @IBOutlet weak var totalPrice: UILabel!
    
  //  @IBOutlet weak var creditTf: UITextField!
    
   // @IBOutlet weak var cashTF: UITextField!
    
    
    var price = Int()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        for i in 0..<self.cartObjects.count
        {
            price += self.cartObjects[i]["Qty"].intValue*self.cartObjects[i]["Price"].intValue
        }
        totalPrice.text = "$ \(price)"
        
    }
    
    @IBAction func checkOut(_ sender: Any) {
        
//        let cash = Int(cashTF.text!)!
//        let credit = Int(creditTf.text!)!
//
//        if cashTF.text!.count>0&&creditTf.text!.count>0
//        {
//            if (cash+credit) == price
//            {
            self.performSegue(withIdentifier:"createSegue", sender:nil)
//            }
//            else
//            {
//                self.alert_popup(title:"Please enter proper cash/credit, doesn't match with total", message:"")
//            }
//        }
//        else
//        {
//            self.alert_popup(title:"Please enter cash/credit", message:"")
        }
 //   }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let vc = segue.destination as! CheckOutViewController
        vc.cartObjects = self.cartObjects
        vc.totalPrice = price
//        vc.cash = cashTF.text!
//        vc.credit = creditTf.text!
    }

}


extension CartViewController:UITableViewDelegate,UITableViewDataSource
{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.cartObjects.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier:"coCell") as! CreateOrderTableViewCell
        cell.pnameLbl.text = self.cartObjects[indexPath.row]["pName"].stringValue
        cell.qtyLbl.text =  "X"+self.cartObjects[indexPath.row]["Qty"].stringValue
        cell.priceLabel.text = "$ \(self.cartObjects[indexPath.row]["Qty"].intValue*self.cartObjects[indexPath.row]["Price"].intValue)"
        cell.selectionStyle = .none
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.01
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0.01
    }
    
}
