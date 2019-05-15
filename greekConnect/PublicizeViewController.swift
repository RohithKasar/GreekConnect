//
//  PublicizeViewController.swift
//  greekConnect
//
//  Created by Rohith Kasar on 5/6/19.
//  Copyright © 2019 rohith.kasar. All rights reserved.
//

import UIKit
import AlamofireImage
import Firebase
import FirebaseDatabase



class PublicizeViewController: UIViewController, UIImagePickerControllerDelegate,UINavigationControllerDelegate {
    
    var ref:DatabaseReference?
    @IBOutlet weak var nameField: UITextField!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var locationField: UITextField!
    @IBOutlet weak var timeField: UITextField!
    @IBOutlet weak var descriptionView: UITextView!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        ref = Database.database().reference()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func publishClicked(_ sender: Any) {
        
        
        guard let nameField = nameField.text else { return }
        guard let location = locationField.text else { return }
        guard let time = timeField.text else { return }
        guard let description = descriptionView.text else { return }
        let id = DummyUser.globalVariable.id
        
        
        
        //_ = Event(name: nameField , location: location, time: time, description: description, poster: posterName)
        
        
        
        DataService.instance.pushEvent(name: nameField, location: location, time: time, description: description, id: id) { (isComplete) in
            if isComplete {
                print("successfully updated an event to firebase")
                
            } else {
                print("there was an error uploading an event to firebase")
            }
        }
        
        
        //self.ref?.child("events").child(e.name).setValue(["location": e.location, "time": e.time, "description":e.description, "poster":User.globalVariable.id])
        
        //self.ref?.child()
        
        let storageRef = Storage.storage().reference().child("Event/\(nameField)")
        
        let imageData = self.imageView.image?.jpegData(compressionQuality: 0.8)
        
        _ = storageRef.putData(imageData!, metadata: nil) { (metadata, error) in
            guard metadata != nil else {
                // Uh-oh, an error occurred!
                return
            }
            // Metadata contains file metadata such as size, content-type.
            //let size = metadata.size
            // You can also access to download URL after upload.
            storageRef.downloadURL { (url, error) in
                guard let downloadURL = url else {
                    // Uh-oh, an error occurred!
                    return
                }
            }
        }
        
        //dismiss(animated: true, completion: nil)
        //perform segue to homeviewcontroller
        performSegue(withIdentifier: "PostPublish", sender: self)
    }
    
    @IBAction func cancelClicked(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func onPictureClicked(_ sender: Any) {
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.allowsEditing = true
        
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            picker.sourceType = .camera
        } else {
            picker.sourceType = .photoLibrary
        }
        
        present(picker, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let image = info[.editedImage] as! UIImage
        let size = CGSize(width: 300, height: 300)
        let scaledImage = image.af_imageScaled(to: size)
        //print(scaledImage == nil)
        
        imageView.image = scaledImage
        
        dismiss(animated: true, completion: nil)
        
    }
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}


