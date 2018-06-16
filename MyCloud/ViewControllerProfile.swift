//
//  ViewControllerProfile.swift
//  MyCloud
//
//  Created by MacOSSierra on 25/05/18.
//  Copyright © 2018 MacOSSierra. All rights reserved.
//

import UIKit
import FirebaseDatabase
import FirebaseAuth

class ViewControllerProfile: UIViewController {
    
    var ref: DatabaseReference!
    let userId = Auth.auth().currentUser!.uid
    
    @IBOutlet weak var txtEmail: UITextField!
    @IBOutlet weak var txtPassword: UITextField!
    @IBOutlet weak var txtPhone: UITextField!
    @IBOutlet weak var txtCity: UITextField!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        ref = Database.database().reference().child("users").child(userId)
        
        ref.observeSingleEvent(of: .value, with: { snapshot in
            
            if !snapshot.exists() { return }
            
            self.txtEmail.text = Auth.auth().currentUser?.email
            self.txtCity.text = snapshot.childSnapshot(forPath: "city").value as? String
            self.txtPhone.text = snapshot.childSnapshot(forPath: "phone").value as? String
        })
        
    }
    
    @IBAction func btnUpdate(_ sender: Any) {
        Auth.auth().currentUser?.updateEmail(to: txtEmail.text!)
        Auth.auth().currentUser?.updatePassword(to: txtPassword.text!)
        
        ref.child("phone").setValue(txtPhone.text)
        ref.child("city").setValue(txtCity.text)
        
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
