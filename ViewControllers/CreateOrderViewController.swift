//
//  CreateOrderViewController.swift
//  wreaths
//
//  Created by TechnisarInc on 25/09/19.
//  Copyright © 2019 TechnisarInc. All rights reserved.
//

import UIKit
import ValueStepper


class CreateOrderViewController: BaseViewController {
    
    //IBOutlet's
    @IBOutlet weak var productsList: UITableView!
    
    //Variable Declaration's
    var products = Array<Any>()
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Create Order"
        
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
                
                self.products.append(document.data())
            }
            print(self.products)
        self.productsList.reloadData()
        }
    }
      
    }
    
    @IBAction func cartAction(_ sender: ValueStepper) {
        let buttonPostion = (sender as AnyObject).convert((sender as AnyObject).bounds.origin, to:self.productsList)

        if let indexPath = productsList.indexPathForRow(at: buttonPostion) {
            let rowIndex =  indexPath.row
            if sender.value==0
            {
               
                
            }
            else
            {
                self.cartObjects.append(products[rowIndex] as! [String : Any])
            }
        }
        
        if self.cartObjects.count>0
        {
            show_checkout_button(show:true)
        }
        else
        {
            show_checkout_button(show:false)
        }
        
    }
    
 
    
    
    func show_checkout_button(show:Bool)
    {
        
        let roundButton = UIButton(type: .custom)
        roundButton.frame = CGRect(x:self.view.bounds.size.width-80,y:self.view.bounds.size.height-100, width:60, height:60)
        roundButton.setImage(UIImage(named:"arrow.png"), for:.normal)
        roundButton.backgroundColor = UIColor.orange
        roundButton.layer.cornerRadius = 60/2
        roundButton.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
            self.view.addSubview(roundButton)
        if show
        {
            roundButton.isHidden = false
        }
        else
        {
            roundButton.isHidden = true
        }
        
    }
    
   @objc func buttonAction(sender: UIButton!) {
    
    }
    
    
}


//MARK: Extensions

extension CreateOrderViewController:UITableViewDelegate,UITableViewDataSource
{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return products.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier:"prCell") as! ProductTableViewCell
        let product = self.products[indexPath.row] as! [String:Any]
        cell.pNameLbl.text = product["pName"] as? String
        cell.priceLbl.text = "$ \(product["Price"] as! String)"
        cell.selectionStyle = .none
        return cell
        
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 90
    }
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.01
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0.01
    }
    
    
}


