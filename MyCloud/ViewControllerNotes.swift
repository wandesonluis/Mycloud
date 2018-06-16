//
//  ViewControllerNotes.swift
//  MyCloud
//
//  Created by MacOSSierra on 27/05/18.
//  Copyright © 2018 MacOSSierra. All rights reserved.
//

import UIKit
import FirebaseDatabase
import FirebaseAuth

class ViewControllerNotes: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var myNotes:[String] = []
    var revNotes: [String] = []
    
    var ref: DatabaseReference!
    var handle: DatabaseHandle!
    
    let userId = Auth.auth().currentUser!.uid
    
    @IBOutlet weak var txtNote: UITextField!
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        ref = Database.database().reference().child("notes").child(userId)

        loadNotes()
    }
    
    func loadNotes() {
        myNotes.removeAll()
        revNotes.removeAll()
        
        handle = ref.observe(.childAdded, with: { (snapShot) in
        if let item = snapShot.value as? String {
            self.myNotes.append(item)
            }
            self.ref.removeObserver(withHandle: self.handle!)
            self.revNotes = Array(self.myNotes.reversed())
            self.tableView.reloadData()
        })
    }
    
    @IBAction func btnNote(_ sender: Any) {
        myNotes.append(txtNote.text!)
        revNotes = Array(self.myNotes.reversed())
        tableView.reloadData()
        
        ref.childByAutoId().setValue(txtNote.text)
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return revNotes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = myNotes[indexPath.row]
        return cell
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
