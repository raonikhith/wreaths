//
//  BaseViewController.swift
//  wreaths
//
//  Created by TechnisarInc on 25/09/19.
//  Copyright © 2019 TechnisarInc. All rights reserved.
//

import UIKit
import Firebase
import SwiftyJSON

class BaseViewController: UIViewController {

    //db initialization
    let db = Firestore.firestore()

    //document reference value
    var ref: DocumentReference? = nil
    //userData object
     var userData = [String:Any]()
    //cart Objects
    var cartObjects = [JSON]()
    //cart Object
    var cart = [String:Any]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

     //initial configurations of the base
      configurations_base()
    }
    
    // this function will have the configurations for the base controller
    func configurations_base()
    {
        //checking if the userData is present and trying to get the values
          if UserDefaults.standard.object(forKey:"userData") != nil
              {
                  //getting the userData
                  userData = UserDefaults.standard.value(forKey:"userData") as! [String : Any]
              }
    }
    
    
    
    
    
    //the method to show alert pop-up
    func alert_popup(title:String,message:String)
    {
        let alertController = UIAlertController(title:title, message:message, preferredStyle: UIAlertController.Style.alert)

        alertController.addAction(UIAlertAction(title: "OK", style: .default) { (action:UIAlertAction!) in
                print("")
            })
        self.present(alertController, animated: true)
        
    }
    
    
    

}



extension Array where Element: Equatable{
    mutating func remove (element: Element) {
        if let i = self.firstIndex(of: element) {
            self.remove(at: i)
        }
    }
}

extension Array {
    func indexOf<T : Equatable>(x:T) -> Int? {
        for i in 0...self.count {
            if self[i] as! T == x {
                return i
            }
        }
        return nil
    }
}
