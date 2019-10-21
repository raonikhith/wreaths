//
//  OrdersViewController.swift
//  wreaths
//
//  Created by TechnisarInc on 19/10/19.
//  Copyright © 2019 TechnisarInc. All rights reserved.
//

import UIKit

class OrdersViewController: BaseViewController {
    
    //IBOutlet's
    @IBOutlet weak var oTableView: UITableView!
    
    //variable's declartion's
    var orders = [[String:Any]]()
    var orderDetails = [String:Any]()

    override func viewDidLoad() {
        super.viewDidLoad()

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
                    self.orders.append(data)
                    self.oTableView.reloadData()
                }
                }
                else
                {
                   
                   
                }
            }

        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let dvc = segue.destination as! OrderSummaryViewController
        dvc.orderDetails = orderDetails
    }
    
}

//Extensions
extension OrdersViewController:UITableViewDelegate,UITableViewDataSource
{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return orders.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier:"oCell") as! OrdersTableViewCell
        cell.textLabel?.text = "Order ID :- \(orders[indexPath.row]["dID"]!)"
        cell.selectionStyle = .none
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.orderDetails = orders[indexPath.row]
        self.performSegue(withIdentifier:"orderSummary", sender:nil)
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 54
    }
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.01
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0.01
    }
    
    
    
}

