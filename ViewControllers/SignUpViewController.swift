//
//  SignUpViewController.swift
//  wreaths
//
//  Created by TechnisarInc on 21/09/19.
//  Copyright © 2019 TechnisarInc. All rights reserved.
//

import UIKit

class SignUpViewController: BaseViewController {
    
    //variable declarations
    var registrationData = [String:Any]()
    
    //IBOutlet's
    
    @IBOutlet weak var firstNameTF: UITextField!
    @IBOutlet weak var lastNameTF: UITextField!
    @IBOutlet weak var emailTF: UITextField!
    @IBOutlet weak var mobileTF: UITextField!
    @IBOutlet weak var passwordTF: UITextField!
    @IBOutlet weak var reTypePassword: UITextField!
    @IBOutlet var userFields: [UITextField]!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }
    
    
    //signUpAction
    @IBAction func signUpAction(_ sender: Any) {
        
        
        var isEmpty = false
        for t in 0..<userFields.count
        {
            if userFields[t].text!.count>0
            {
                isEmpty = false
            }
            else
            {
                isEmpty = true
                break
            }
        }
        
        if isEmpty
        {
            self.alert_popup(title:"Please fill all the details", message:"")
        }
        else
        {
            if isValidPhone(phone:mobileTF.text!)
            {
                if isValidEmail(email:emailTF.text!)
                {
                    if passwordTF.text == reTypePassword.text
                    {
                        registrationData = ["FirstName":firstNameTF.text!,
                                            "LastName" : lastNameTF.text!,
                                            "Email": emailTF.text!,
                                            "Mobile": mobileTF.text!,
                                            "Password" : passwordTF.text!
                        ]
                        
                        guard let email = emailTF.text else { return }
                        
                        
                        let docRef = db.collection("Users").whereField("Email", isEqualTo: email).limit(to: 1)
                        docRef.getDocuments { (querysnapshot, error) in
                            if error != nil {
                                print("Document Error: ", error!)
                            } else {
                                if let doc = querysnapshot?.documents, !doc.isEmpty {
                                    self.alert_popup(title:"User already exists", message:"")
                                }
                                else
                                {
                                    self.ref = self.db.collection("Users").addDocument(data:self.registrationData) { err in
                                        if let err = err {
                                            print("Error adding document: \(err)")
                                        } else {
                                            print("Document added with ID: \(self.ref!.documentID)")
                                            self.userData = self.registrationData
                                                                    self.userData["dID"] = self.ref!.documentID
                                                                           UserDefaults.standard.setValue(self.userData, forKey:"userData")
                                             self.performSegue(withIdentifier:"dashSegue", sender:nil)
                                        }
                                    }
                                    
                                }
                            }
                        }
                    }
                    else
                    {
                        self.alert_popup(title:"Password and Retype Password doesn't match", message:"")
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
    
}
