//
//  OrderSummaryViewController.swift
//  wreaths
//
//  Created by TechnisarInc on 19/10/19.
//  Copyright © 2019 TechnisarInc. All rights reserved.
//

import UIKit
import SwiftyJSON

class OrderSummaryViewController: UIViewController {

    //IBOutLet's
    @IBOutlet weak var oId: UILabel!
    @IBOutlet weak var nameLbl: UILabel!
    @IBOutlet weak var mobileLbl: UILabel!
    @IBOutlet weak var emailLbl: UILabel!
    @IBOutlet weak var addressLbl: UILabel!
    
    @IBOutlet weak var totalLbl: UILabel!
    @IBOutlet weak var totalAmountLbl: UILabel!
    //variable declaration's
    var orderDetails = [String:Any]()
    var oderArrayItems:JSON = JSON.null
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        // Do any additional setup after loading the view.
        
        let userD = orderDetails["UserDetails"] as! [String:Any]
        
        let address =  "\(userD["Address"] as! String),\(userD["City"] as! String),\(userD["State"] as! String) ,\(userD["ZipCode"] as! String)"
        
        addressLbl.text = "Address :- \(address)"
        nameLbl.text = "Name :- \(userD["Name"] ?? "")"
        mobileLbl.text = "Mobile :- \(userD["Mobile"] ?? "")"
        emailLbl.text = "Email :- \(userD["Email"] ?? "")"
        
        oderArrayItems = JSON(orderDetails["OrderDetails"]!)
        print("###################", orderDetails)
        
        var price = Int()
        for i in 0..<self.oderArrayItems.count
        {
            price += self.oderArrayItems[i]["Qty"].intValue*self.oderArrayItems[i]["Price"].intValue
        }
        
        self.totalLbl.text = #"""
            Total
            """#
        
        self.totalAmountLbl.text = #"""
        $ \#(price)
        """#
        
//        totalAmountLbl.text = "$ \(price)"
    }
    

}


extension OrderSummaryViewController:UITableViewDelegate,UITableViewDataSource
{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.oderArrayItems.count
        
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier:"coCell") as! CreateOrderTableViewCell
        cell.pnameLbl.text = self.oderArrayItems[indexPath.row]["pName"].stringValue
        cell.qtyLbl.text =  "X"+self.oderArrayItems[indexPath.row]["Qty"].stringValue
        cell.priceLabel.text = "$ \(self.oderArrayItems[indexPath.row]["Qty"].intValue*self.oderArrayItems[indexPath.row]["Price"].intValue)"
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
