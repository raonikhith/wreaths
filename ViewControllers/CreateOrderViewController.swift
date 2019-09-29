//
//  CreateOrderViewController.swift
//  wreaths
//
//  Created by TechnisarInc on 25/09/19.
//  Copyright © 2019 TechnisarInc. All rights reserved.
//

import UIKit
import ValueStepper
import SwiftyJSON

class CreateOrderViewController: BaseViewController {
    
    //IBOutlet's
    @IBOutlet weak var productsList: UITableView!
    
    //Variable Declaration's
    var products = [JSON]()
    var roundButton = UIButton()
    var qty = [Int]()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Create Order"
        
        get_products()
        
        show_checkout_button()
        roundButton.isHidden = true
        
       
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
            print(self.products)
        self.productsList.reloadData()
        }
    }
      
    }
    
    @IBAction func cartAction(_ sender: ValueStepper) {
        let buttonPostion = (sender as AnyObject).convert((sender as AnyObject).bounds.origin, to:self.productsList)

        if let indexPath = productsList.indexPathForRow(at: buttonPostion) {
            let rowIndex =  indexPath.row
            cart_add_objects(sender: sender, rowIndex:rowIndex)
        }
        
        show_hide_checkout_button()
   
    }
    
    
    func cart_add_objects(sender:ValueStepper,rowIndex:Int)
    {
        if sender.value==0
        {
            qty.remove(at:self.cartObjects.indexOf(x:products[rowIndex])!)
            self.cartObjects.remove(element:products[rowIndex])
        }
        else
        {
            
            if self.cartObjects.contains(products[rowIndex])
            {
                qty[self.cartObjects.indexOf(x:products[rowIndex])!] = Int(sender.value)
            }
            else
            {
            qty.append(Int(sender.value))
            self.cartObjects.append(products[rowIndex])
            }
        }
    }
    
    
    func  show_hide_checkout_button()
    {
           if self.cartObjects.count>0
           {
               roundButton.isHidden = false
           }
           else
           {
               roundButton.isHidden = true
           }
    }
    
 
    func show_checkout_button()
    {
        
        roundButton = UIButton(type: .custom)
        roundButton.frame = CGRect(x:self.view.bounds.size.width-80,y:self.view.bounds.size.height-100, width:60, height:60)
        roundButton.setImage(UIImage(named:"arrow.png"), for:.normal)
        roundButton.backgroundColor = UIColor.orange
        roundButton.layer.cornerRadius = 60/2
        roundButton.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
        self.view.addSubview(roundButton)
        
    }
   @objc func buttonAction(sender: UIButton!)
   {
    for i in 0..<qty.count
    {
        self.cartObjects[i].dictionaryObject!["Qty"] = qty[i]
    }
    print(self.cartObjects.count)
    self.performSegue(withIdentifier:"cartSegue", sender:nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let vc = segue.destination as! CartViewController
        vc.cartObjects = self.cartObjects
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
        let product = self.products[indexPath.row]
        cell.pNameLbl.text = product["pName"].stringValue
        cell.priceLbl.text = "$ \(product["Price"].stringValue)"
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


