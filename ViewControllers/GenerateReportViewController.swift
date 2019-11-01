//
//  GenerateReportViewController.swift
//  wreaths
//
//  Created by NFCIndia on 31/10/19.
//  Copyright © 2019 NFCIndia. All rights reserved.
//

import UIKit
import SwiftyJSON

class GenerateReportViewController: BaseViewController {
    
    //variable declarations
    var ordersJson:JSON = JSON.null
    var orders = [JSON]()
    var products = [JSON]()
    var likeObjects = [[JSON]]()
    var documentsId = [String]()
    
    //IBOutlet's
    
    @IBOutlet weak var orderTableView: UITableView!
    
    @IBOutlet weak var scoutLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        scoutLabel.text = "SCOUT: \(self.userData["FirstName"] as! String)"
        get_products()
    }
    
    
    //this function is to get list of products
    func get_products()
    {
        _ = db.collection("Products").getDocuments { (snapshot, err) in
        if let err = err {
            print("Error getting documents: \(err)")
        } else {
            for document in snapshot!.documents {
                
                self.products.append(JSON(document.data()))
            }
            print("**********--------*********",self.products)
            self.toGetAllOrders()
        }
    }
    }
    

    
    func toGetAllOrders()
    {
        
            _ = db.collection("Orders").document(self.userData["FirstName"] as! String).collection("uOrders").getDocuments(){(querySnapshot, err) in
                     if let err = err {
                         print("Error getting documents: \(err)")
                     } else {
                         if querySnapshot!.documents.count>0
                         {
                             for document in querySnapshot!.documents {
                                 var data = document.data()
                                 data["dID"] = document.documentID
                                
                                let ara = data["OrderDetails"] as! Array<[String:Any]>
                            
                                for dict in ara
                                {
                                    self.orders.append(JSON(dict))
                                }
                             }
                    
                            
                print("****************************Orders",self.orders)
                for p in 0..<self.products.count
                {
                    var jsonVal = [JSON]()
                    for o in 0..<self.orders.count
                    {
                    if self.products[p]["pName"].stringValue == self.orders[o]["pName"].stringValue
                    {
                    jsonVal.append(self.orders[o])
                    }
                    }
                    if jsonVal.count>0
                    {
                    self.likeObjects.append(jsonVal)
                    }
                }
                        self.orderTableView.reloadData()
                    print("==========================>",self.likeObjects)
                    }
                    else
                    {
                             
                    }
                    }
                 }
           
        

    }
    
}

extension GenerateReportViewController:UITableViewDelegate,UITableViewDataSource{
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
      return  self.likeObjects.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.likeObjects[section].count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier:"gCell") as! GenerateReportTableViewCell
        
        cell.textLabel?.text = self.likeObjects[indexPath.section][indexPath.row]["pName"].stringValue
        cell.detailTextLabel?.text = "x"+self.likeObjects[indexPath.section][indexPath.row]["Qty"].stringValue+" = $\(self.likeObjects[indexPath.section][indexPath.row]["Qty"].intValue*self.likeObjects[indexPath.section][indexPath.row]["Price"].intValue)"
        cell.selectionStyle = .none
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let hView = UIView()
        hView.frame = CGRect(x: 0, y: 0, width:self.view.bounds.size.width, height:50)
        
        let hLabel = UILabel()
        hLabel.frame = CGRect(x:10, y: 0, width:self.view.bounds.size.width-20, height:50)
        hLabel.text = self.likeObjects[section][0]["pName"].stringValue
        hView.addSubview(hLabel)
        return hView
        
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }
    
    
}
