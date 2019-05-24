//
//  CreateEventViewController.swift
//  greekConnect
//
//  Created by Ellis Chang on 5/2/19.
//  Copyright © 2019 rohith.kasar. All rights reserved.
//

import UIKit
import Alamofire
import Firebase
import FirebaseDatabase


class CreateEventViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UIPickerViewDelegate, UIPickerViewDataSource {
    
    

    var ref:DatabaseReference?
    @IBOutlet weak var exchangeName: UITextField!
    @IBOutlet weak var exchangeLocation: UITextField!
    @IBOutlet weak var exchangeTime: UITextField!
    @IBOutlet weak var exchangeOrg: UITextField!
    @IBOutlet weak var exchangeDescription: UITextView!
    
    @IBOutlet weak var exchangeImage: UIImageView!
    var users = [User]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ref = Database.database().reference()
        // Do any additional setup after loading the view.
    }
    
    
    
    @IBAction func back(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func inviteClicked(_ sender: Any) {
        guard let name = exchangeName.text else { return }
        guard let location = exchangeLocation.text else { return }
        guard let time = exchangeTime.text else { return }
        guard let org = exchangeOrg.text else { return }
        guard let description = exchangeDescription.text else {return}
        
        let id = Firebase.Auth.auth().currentUser?.uid ?? "bleep"
        
        
        DataService.instance.fetchUser { (paramUsers) in
            self.users = paramUsers
            //print(self.users.count)
            for user in self.users {
                //print(user.org)
                if (user.org == org) {
                    
                    DataService.instance.pushExchange(name: name, location: location, time: time, description: description, id: id, recipient: user.id, uploadComplete: { (isComplete) in
                    })
                    
                    let storageRef = Storage.storage().reference().child("Event/\(name)")
                    
                    let imageData = self.exchangeImage.image?.jpegData(compressionQuality: 0.8)
                    
                    _ = storageRef.putData(imageData!, metadata: nil) { (metadata, error) in
                        guard metadata != nil else {
                            return
                        }
                        storageRef.downloadURL { (url, error) in
                            guard url != nil else {
                                return
                            }
                        }
                    }
                }
            }
        }
        performSegue(withIdentifier: "postExchange", sender: self)
    }
    @IBAction func cancelClicked(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    
    @IBAction func pictureClicked(_ sender: Any) {
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
        
        exchangeImage.image = scaledImage
        
        dismiss(animated: true, completion: nil)
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        //ELLIS FIX THIS
        return 10
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        //ELLIS FIX THIS
        return 10
    }

}
