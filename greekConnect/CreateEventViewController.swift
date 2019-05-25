//
//  CreateEventViewController.swift
//  greekConnect
//
//  Created by Ellis Chang on 5/2/19.
//  Copyright © 2019 rohith.kasar. All rights reserved.
//

import UIKit
//import Alamofire
//import Firebase
//import FirebaseDatabase


class CreateEventViewController: UIViewController {
    
//, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UIPickerViewDelegate, UIPickerViewDataSource {
    
//    var picker = UIPickerView()
//
//    var ref:DatabaseReference?
//    @IBOutlet weak var exchangeName: UITextField!
//    @IBOutlet weak var exchangeLocation: UITextField!
//    @IBOutlet weak var exchangeTime: UITextField!
//    @IBOutlet weak var exchangeOrg: UITextField!
//    @IBOutlet weak var exchangeDescription: UITextView!
//
//    @IBOutlet weak var exchangeImage: UIImageView!
//    var users = [User]()
//
//    var orgList = ["", "Alpha Chi Omega", "Alpha Epsilon Omega",  "Alpha Epsilon Phi", "Alpha Epsilon Pi",
//                   "Alpha Gamma Alpha", "Alpha Lamda Mu", "Alpha Omicron Pi", "Alpha Phi", "Beta Theta Pi",
//                   "Chi Omega", "Delta Delta Delta", "Delta Gamma", "Delta Lambda Phi","Gamma Zeta Alpha",
//                   "Kappa Alpha Theta", "Kappa Kappa Gamma", "Kappa Sigma", "Kappa Zeta Phi", "Lambda Chi Alpha",
//                   "Lambda Phi Epsilon", "Lambda Theta Alpha", "Lambda Theta Nu", "Lambda Theta Phi", "Nu Alpha Kappa",
//                   "Phi Delta Theta", "Phi Gamma Delta", "Phi Iota Alpha", "Phi Lambda Rho", "Phi Sigma Rho",
//                   "Pi Alpha Phi", "Pi Beta Phi", "Pi Kappa Alpha", "Pi Kappa Phi", "Psi Chi Omega", "Sigma Alpha Epsilon",
//                   "Sigma Alpha Mu", "Sigma Alpha Zeta", "Sigma Chi", "Sigma Kappa", "Sigma Nu", "Sigma Omicron Pi",
//                   "Sigma Phi Epsilon", "Sigma Pi Alpha", "Tau Kappa Epsilon", "Triangle"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        ref = Database.database().reference()
        // Do any additional setup after loading the view.
        
//        picker.delegate = self
//        picker.dataSource = self
//
//        exchangeOrg.inputView = picker
//
//        let toolBar = UIToolbar(frame: CGRect(x: 0, y: self.view.frame.size.width, width: self.view.frame.size.height/6, height: 40.0))
//
//        toolBar.layer.position = CGPoint(x: self.view.frame.size.width/2, y: self.view.frame.size.height-20.0)
//        //toolBar.barStyle = UIBarStyle.blackTranslucent
//        //toolBar.tintColor = UIColor.white
//        //toolBar.backgroundColor = UIColor.black
//
//        let defaultButton = UIBarButtonItem(title: "Cancel", style: UIBarButtonItem.Style.plain, target: self, action: #selector(OrgPickerViewController.cancelPressed))
//        let doneButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.done, target: self, action: #selector(OrgPickerViewController.donePressed))
//        let flexSpace = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: self, action: nil)
//
//        let label = UILabel(frame: CGRect(x: 0, y: 0, width: self.view.frame.size.width / 3, height: self.view.frame.size.height))
//        label.font = UIFont(name: "Helvetica", size: 12)
//        label.backgroundColor = UIColor.clear
//        label.textColor = UIColor.blue
//        //label.text = "Select your organization"
//        label.textAlignment = NSTextAlignment.center
//
//        let textBtn = UIBarButtonItem(customView: label)
//
//        toolBar.setItems([defaultButton,flexSpace,textBtn,flexSpace,doneButton], animated: true)
//
//        exchangeOrg.inputAccessoryView = toolBar
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        AppDelegate.AppUtility.lockOrientation(.portrait)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        AppDelegate.AppUtility.lockOrientation(.all)
    }
    
    @IBAction func back(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func publicizeButton(_ sender: Any) {
        performSegue(withIdentifier: "publicizeSegue", sender: self)
    }
    
    @IBAction func inviteButton(_ sender: Any) {
        performSegue(withIdentifier: "inviteSegue", sender: self)
    }
    
//    @IBAction func inviteClicked(_ sender: Any) {
//        guard let name = exchangeName.text else { return }
//        guard let location = exchangeLocation.text else { return }
//        guard let time = exchangeTime.text else { return }
//        guard let org = exchangeOrg.text else { return }
//        guard let description = exchangeDescription.text else {return}
//
//        let id = Firebase.Auth.auth().currentUser?.uid ?? "bleep"
//
//
//        DataService.instance.fetchUser { (paramUsers) in
//            self.users = paramUsers
//            //print(self.users.count)
//            for user in self.users {
//                //print(user.org)
//                if (user.org == org) {
//
//                    DataService.instance.pushExchange(name: name, location: location, time: time, description: description, id: id, recipient: user.id, uploadComplete: { (isComplete) in
//                    })
//
//                    let storageRef = Storage.storage().reference().child("Event/\(name)")
//
//                    let imageData = self.exchangeImage.image?.jpegData(compressionQuality: 0.8)
//
//                    _ = storageRef.putData(imageData!, metadata: nil) { (metadata, error) in
//                        guard metadata != nil else {
//                            return
//                        }
//                        storageRef.downloadURL { (url, error) in
//                            guard url != nil else {
//                                return
//                            }
//                        }
//                    }
//                }
//            }
//        }
//        performSegue(withIdentifier: "postExchange", sender: self)
//    }
//    @IBAction func cancelClicked(_ sender: Any) {
//        dismiss(animated: true, completion: nil)
//    }
//
//
//    @IBAction func pictureClicked(_ sender: Any) {
//        let picker = UIImagePickerController()
//        picker.delegate = self
//        picker.allowsEditing = true
//
//        if UIImagePickerController.isSourceTypeAvailable(.camera) {
//            picker.sourceType = .camera
//        } else {
//            picker.sourceType = .photoLibrary
//        }
//
//        present(picker, animated: true, completion: nil)
//    }
//
//    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
//        let image = info[.editedImage] as! UIImage
//        let size = CGSize(width: 300, height: 300)
//        let scaledImage = image.af_imageScaled(to: size)
//        //print(scaledImage == nil)
//
//        exchangeImage.image = scaledImage
//
//        dismiss(animated: true, completion: nil)
//    }
//
//    func numberOfComponents(in pickerView: UIPickerView) -> Int {
//        return 1
//    }
//
//    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
//        return orgList.count
//    }
//
//    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
//        return orgList[row]
//    }
//
//    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
//        exchangeOrg.text = orgList[row]
//    }
//
//    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
//        self.view.endEditing(true)
//    }
//
//    @objc func donePressed(sender: UIBarButtonItem) {
//        //User.globalVariable.org = exchangeOrg.text ?? "yeet"
//
//        //FIX THESE TWO LINES
//
//        //DummyUser.globalVariable.org = exchangeOrg.text ?? "mooted"
//        //let org = exchangeOrg.text ?? "mooted"
//        //self.ref?.child("Organizations").child(org).setValue([id:email])
//
//        //addUserOrg(org)
//
//        //somehow update existing user?
//        exchangeOrg.resignFirstResponder()
//        //performSegue(withIdentifier: "firstLogInSegue", sender: self)
//    }
//
//    @objc func cancelPressed(sender: UIBarButtonItem) {
//        exchangeOrg.text = ""
//        exchangeOrg.resignFirstResponder()
//    }
}
