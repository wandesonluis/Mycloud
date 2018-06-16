//
//  ViewControllerForgotPass.swift
//  MyCloud
//
//  Created by MacOSSierra on 25/05/18.
//  Copyright © 2018 MacOSSierra. All rights reserved.
//

import UIKit
import FirebaseAuth

class ViewControllerForgotPass: UIViewController {
    
    @IBOutlet weak var txtEmail: UITextField!
    

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    @IBAction func btnSubmit(_ sender: Any) {
        if txtEmail.text != ""{
        
            Auth.auth().sendPasswordReset(withEmail: txtEmail.text!) { (error) in
                if error == nil {
                    self.showMessage(parm1: "Reset Email Sent!")
                }else{
                    self.showMessage(parm1: error as! String)
                }
                
            }
        }
        
    }
    
    
    func showMessage(parm1: String) {
        let alertController = UIAlertController(title: "MESSAGE", message:
            parm1, preferredStyle: UIAlertControllerStyle.alert)
        alertController.addAction(UIAlertAction(title: "Dismiss", style:
            UIAlertActionStyle.default,handler: nil))
        self.present(alertController, animated: true,completion: nil)
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
