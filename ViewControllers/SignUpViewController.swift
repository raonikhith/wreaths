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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }
    
    
    //signUpAction
    @IBAction func signUpAction(_ sender: Any) {
        
        
        registrationData = ["FirstName":firstNameTF.text!,
                            "LastName" : lastNameTF.text!,
                            "Email": emailTF.text!,
                            "Mobile": mobileTF.text!,
                            "Password" : passwordTF.text!
                            ]
        ref = db.collection("Users").addDocument(data:registrationData) { err in
            if let err = err {
                print("Error adding document: \(err)")
            } else {
                print("Document added with ID: \(self.ref!.documentID)")
            }
        }
        
        
    }
    
  
    

}
