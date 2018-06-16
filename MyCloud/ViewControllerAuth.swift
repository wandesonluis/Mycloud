//
//  ViewControllerAuth.swift
//  MyCloud
//
//  Created by MacOSSierra on 25/05/18.
//  Copyright © 2018 MacOSSierra. All rights reserved.
//

import UIKit
import FirebaseAuth

class ViewControllerAuth: UIViewController {

    @IBOutlet weak var txtEmail: UITextField!
    @IBOutlet weak var txtPassword: UITextField!
    @IBOutlet weak var lblMessage: UILabel!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    @IBAction func btnLogin(_ sender: Any) {
        if txtEmail.text != "" && txtPassword.text != "" {
            Auth.auth().signIn(withEmail: txtEmail.text!, password: txtPassword.text!, completion: {(user,error) in
                if user != nil {
                    print("Login Ok")
                    self.performSegue(withIdentifier: "toNotes", sender: self)
                }else {
                    print(error ?? "Loing not Ok")
                    self.lblMessage.text = "invalid Password"
                }
            })
        }
        
    }
    @IBAction func btnSingUp(_ sender: Any) {
         Auth.auth().createUser(withEmail: txtEmail.text!, password: txtPassword.text!, completion: {(user,error) in
            if let myError = error?.localizedDescription {
                self.lblMessage.text = myError
            }
        })
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
