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
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        var price = Int()
        for i in 0..<self.cartObjects.count
        {
            price += self.cartObjects[i]["Qty"].intValue*self.cartObjects[i]["Price"].intValue
        }
        totalPrice.text = "$ \(price)"
            
    }
    
    @IBAction func checkOut(_ sender: Any) {
        
        self.performSegue(withIdentifier:"createSegue", sender:nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
           let vc = segue.destination as! CheckOutViewController
           vc.cartObjects = self.cartObjects
       }

}


extension CartViewController:UITableViewDelegate,UITableViewDataSource
{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        self.cartObjects.count
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
