//
//  ViewControllerImage.swift
//  MyCloud
//
//  Created by MacOSSierra on 27/05/18.
//  Copyright © 2018 MacOSSierra. All rights reserved.
//

import UIKit
import AVFoundation
import AVKit
import MobileCoreServices
import Firebase

class ViewControllerImage: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UIScrollViewDelegate {
    
    var refPics: DatabaseReference?
    var myImage = ""
    
    
    @IBOutlet weak var txtImageId: UITextField!
    @IBOutlet weak var scrowView: UIScrollView!
    @IBOutlet weak var myImageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.scrowView.minimumZoomScale = 1.0
        self.scrowView.maximumZoomScale = 6.0

    }
    
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return self.myImageView
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func btnDownload(_ sender: Any) {
        
        myImage = self.txtImageId.text!
        
        let imageURL = Storage.storage().reference(forURL: "gs://mycloud-cf7f2.appspot.com/").child("\(myImage).jpg")
        
        imageURL.downloadURL(completion: {(url, error) in
            if error != nil {
                print(error?.localizedDescription ?? "")
                return
            }
            URLSession.shared.dataTask(with: url!, completionHandler: {(data, response, error) in
                
                if error != nil{
                    print(error ?? "Error")
                    return
                }
                guard let imageData = UIImage(data: data!) else {return}
                DispatchQueue.main.sync {
                self.myImageView.image = imageData
                }
            
            }).resume()
            
        })
        
    }
    
    
    @IBAction func btnSaveImage(_ sender: Any) {
        myImage = self.txtImageId.text!
        
        //Save Firebase
        let storage = Storage.storage().reference(withPath: "myImages")
        let tempImageRef = storage.child("\(myImage).jpg")
        let metaData = StorageMetadata()
        metaData.contentType = "image/jpeg"
        tempImageRef.putData(UIImageJPEGRepresentation(myImageView.image!, 0.5)!, metadata: metaData, completion:
            {(data,error) in
                if error == nil {
                    self.showMessage(parm1: "Image Uploaded")
                } else {
                    self.showMessage(parm1: (error?.localizedDescription)!)
                }
        })
        
        //save local
        UIImageWriteToSavedPhotosAlbum(myImageView.image!, self, #selector(image(_:didFinishSavingWithError:contextInfo:)), nil)
    }
    @objc func image(_ image: UIImage, didFinishSavingWithError error: Error?, contextInfo: UnsafeRawPointer) {
        if let error = error {
            showMessage(parm1: error.localizedDescription)
        } else {
            showMessage(parm1: "Your image has been saved.")
        }
    }
    
    func showMessage(parm1: String) {
        let alertController = UIAlertController(title: "Message", message:
            parm1, preferredStyle: UIAlertControllerStyle.alert )
        alertController.addAction(UIAlertAction(title: "Ok", style:
            UIAlertActionStyle.default,handler: nil))
        
    }
    
    
    @IBAction func btnFromCamera(_ sender: Any) {
        let picker = UIImagePickerController()
        picker.allowsEditing = false
        picker.delegate = self
        picker.mediaTypes = [kUTTypeImage as String]
        picker.sourceType = UIImagePickerControllerSourceType.camera
        present(picker, animated: true, completion: nil)
        
        
    }
    
    @IBAction func btnFromLibrary(_ sender: Any) {
        let picker = UIImagePickerController()
        picker.allowsEditing = true
        picker.delegate = self
        picker.mediaTypes = [kUTTypeImage as String]
        picker.sourceType = UIImagePickerControllerSourceType.photoLibrary
        present(picker, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if let image = info[UIImagePickerControllerOriginalImage] as? UIImage{
            myImageView.image = image
        }
        self.dismiss(animated: true, completion: nil)
    }
    


  
    

}
