//
//  CheckOutViewController.swift
//  wreaths
//
//  Created by TechnisarInc on 28/09/19.
//  Copyright © 2019 TechnisarInc. All rights reserved.
//

import UIKit
import DropDown

class CheckOutViewController: BaseViewController
{
    
    @IBOutlet weak var nameTF: UITextField!
    @IBOutlet weak var mobileTF: UITextField!
    @IBOutlet weak var emailTF: UITextField!
    @IBOutlet weak var addressTF: UITextField!
    @IBOutlet weak var cityTF: UITextField!
    @IBOutlet weak var zipCodeTF: UITextField!
    @IBOutlet var addressFields: [UITextField]!
    
    @IBOutlet weak var stateDropDown: UIButton!
    let chooseArticleDropDown = DropDown()
       lazy var dropDowns: [DropDown] = {
           return [
               self.chooseArticleDropDown
           ]
       }()
    
    //variable declaration
    var totalPrice = Int()
//    var cash = String()
//    var credit = String()
    var state = String()
    var qty = [Int]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    
    @IBAction func submitAction(_ sender: Any)
    {
        var isEmpty = false
        for t in 0..<addressFields.count
        {
            if addressFields[t].text!.count>0
            {
                isEmpty = false
            }
            else
            {
                isEmpty = true
                break
            }
        }
        
        if isEmpty == false
        {
            if state.count>0
            {
                 isEmpty = false
            }
            else
            {
                 isEmpty = true
            }
        }
        
        if isEmpty
        {
            self.alert_popup(title:"Please fill all the details", message:"")
        }
        else
        {
            //checking for phone validation
            if isValidPhone(phone:mobileTF.text!)
            {
                if isValidEmail(email:emailTF.text!)
                {
                    
                    for i in 0..<qty.count
                       {
                           self.cartObjects[i].dictionaryObject!["Qty"] = qty[i]
                       }
                    var carts = [[String:Any]]()
                    for c in 0..<self.cartObjects.count
                    {
                        carts.append(self.cartObjects[c].dictionaryObject!)
                    }
                    
                    let userDetails = ["Name":nameTF.text!,"Mobile":mobileTF.text!,"Email":emailTF.text!,"Address":addressTF.text!,"City":cityTF.text!,"State":state,"ZipCode":zipCodeTF.text!,"Price":totalPrice] as [String : Any]
                    cart = ["UserDetails":userDetails,
                            "OrderDetails":carts]
                    _ = db.collection("Orders").document(self.userData["FirstName"] as! String).collection("uOrders").getDocuments(){(querySnapshot, err) in
                               if let err = err {
                                   print("Error getting documents: \(err)")
                               } else {
                                self.db.collection("Orders").document(self.userData["FirstName"] as! String).setData(self.userData)
                                self.db.collection("Orders").document(self.userData["FirstName"] as! String).collection("uOrders").document("\((querySnapshot?.documents.count)!+1)").setData(self.cart)
                                                      
                                                      let alertView = UIAlertController(title: "", message: "Order Created Successfully", preferredStyle: .alert)
                                                      let action = UIAlertAction(title: "OK", style: .default, handler: { (alert) in
                                                          self.navigationController?.popToViewController(ofClass: DashBoardViewController.self)
                                                          
                                                      })
                                                      alertView.addAction(action)
                                                      self.present(alertView, animated: true, completion: nil)
                                   
                               }

                           }
                   
                }
                else
                {
                    self.alert_popup(title:"Enter valid email", message:"")
                }
            }
            else
            {
                self.alert_popup(title:"Enter valid mobile number", message:"")
            }
        }
    }
    
    func isValidPhone(phone: String) -> Bool {
        let phoneRegex = "^[0-9+]{0,1}+[0-9]{5,16}$"
        let phoneTest = NSPredicate(format: "SELF MATCHES %@", phoneRegex)
        return phoneTest.evaluate(with: phone)
    }
    
    func isValidEmail(email: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: email)
    }
    
    
    
    func setupChooseArticleDropDown(anchorView:UIButton,items:[String]) {
        chooseArticleDropDown.anchorView = anchorView
        chooseArticleDropDown.bottomOffset = CGPoint(x: 0, y: anchorView.bounds.height)
        chooseArticleDropDown.backgroundColor = .white
        chooseArticleDropDown.dataSource =  items
        chooseArticleDropDown.selectionAction = { [unowned self] (index,item) in
            print(self.index)
            print(item)
            anchorView.setTitle(item, for:.normal)
            self.state = item
            }
        }
        
        
    
    
    @IBAction func stateDropDown(_ sender: Any) {
        dropDowns.forEach { $0.dismissMode = .onTap }
        dropDowns.forEach { $0.direction = .bottom }
        let state = [ "AK - Alaska",
        "AL - Alabama",
        "AR - Arkansas",
        "AS - American Samoa",
        "AZ - Arizona",
        "CA - California",
        "CO - Colorado",
        "CT - Connecticut",
        "DC - District of Columbia",
        "DE - Delaware",
        "FL - Florida",
        "GA - Georgia",
        "GU - Guam",
        "HI - Hawaii",
        "IA - Iowa",
        "ID - Idaho",
        "IL - Illinois",
        "IN - Indiana",
        "KS - Kansas",
        "KY - Kentucky",
        "LA - Louisiana",
        "MA - Massachusetts",
        "MD - Maryland",
        "ME - Maine",
        "MI - Michigan",
        "MN - Minnesota",
        "MO - Missouri",
        "MS - Mississippi",
        "MT - Montana",
        "NC - North Carolina",
        "ND - North Dakota",
        "NE - Nebraska",
        "NH - New Hampshire",
        "NJ - New Jersey",
        "NM - New Mexico",
        "NV - Nevada",
        "NY - New York",
        "OH - Ohio",
        "OK - Oklahoma",
        "OR - Oregon",
        "PA - Pennsylvania",
        "PR - Puerto Rico",
        "RI - Rhode Island",
        "SC - South Carolina",
        "SD - South Dakota",
        "TN - Tennessee",
        "TX - Texas",
        "UT - Utah",
        "VA - Virginia",
        "VI - Virgin Islands",
        "VT - Vermont",
        "WA - Washington",
        "WI - Wisconsin",
        "WV - West Virginia",
        "WY - Wyoming"]
        setupChooseArticleDropDown(anchorView:sender as! UIButton,items:state)
        chooseArticleDropDown.show()
    }
    
}


extension UINavigationController {
    func popToViewController(ofClass: AnyClass, animated: Bool = true) {
        if let vc = viewControllers.filter({$0.isKind(of: ofClass)}).last {
            popToViewController(vc, animated: animated)
        }
    }
}

private var kAssociationKeyMaxLength: Int = 0

extension UITextField {
    
    @IBInspectable var maxLength: Int {
        get {
            if let length = objc_getAssociatedObject(self, &kAssociationKeyMaxLength) as? Int {
                return length
            } else {
                return Int.max
            }
        }
        set {
            objc_setAssociatedObject(self, &kAssociationKeyMaxLength, newValue, .OBJC_ASSOCIATION_RETAIN)
            addTarget(self, action: #selector(checkMaxLength), for: .editingChanged)
        }
    }
    
    @objc func checkMaxLength(textField: UITextField) {
        guard let prospectiveText = self.text,
            prospectiveText.count > maxLength
            else {
                return
        }
        
        let selection = selectedTextRange
        
        let indexEndOfText = prospectiveText.index(prospectiveText.startIndex, offsetBy: maxLength)
        let substring = prospectiveText[..<indexEndOfText]
        text = String(substring)
        
        selectedTextRange = selection
    }
}

