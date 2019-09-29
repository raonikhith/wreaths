//
//  LoginViewController.swift
//  wreaths
//
//  Created by TechnisarInc on 21/09/19.
//  Copyright © 2019 TechnisarInc. All rights reserved.
//

import UIKit

class LoginViewController: BaseViewController {
    
    //IBOutlet's
    @IBOutlet weak var emailTF: UITextField!
    @IBOutlet weak var passwordTF: UITextField!
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    
    //loginAction
    @IBAction func loginAction(_ sender: Any) {
        //user collection reference
        self.performSegue(withIdentifier:"dashSegue", sender:nil)
//        let userRef = db.collection("Users")
//        _  = userRef.whereField("Email", isEqualTo:emailTF.text!).whereField("Password", isEqualTo:passwordTF.text!).getDocuments() { (querySnapshot, err) in
//        if let err = err {
//            print("Error getting documents: \(err)")
//        } else {
//            if querySnapshot!.documents.count>0
//            {
//            for document in querySnapshot!.documents {
//                print("\(document.documentID) => \(document.data())")
//                //getting the userDetails and storing in defaults for further usage
//                self.userData = document.data()
//                self.userData["dID"] = document.documentID
//                UserDefaults.standard.setValue(self.userData, forKey:"userData")
//                //after successful login taking to dashboard
//                self.performSegue(withIdentifier:"dashSegue", sender:nil)
//            }
//            }
//            else
//            {
//                //if user is not found
//                self.alert_popup(title:"User Doesn't exists", message:"")
//            }
//        }
//
//    }
    }
        
    
    
}
