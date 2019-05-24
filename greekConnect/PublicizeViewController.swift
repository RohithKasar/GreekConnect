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



class PublicizeViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UIPickerViewDelegate, UIPickerViewDataSource {
    
    var ref:DatabaseReference?
    @IBOutlet weak var nameField: UITextField!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var locationField: UITextField!
    @IBOutlet weak var timeField: UITextField!
    @IBOutlet weak var descriptionView: UITextView!

    var timeOption = [["", "01", "02", "03", "04", "05", "06", "07", "08", "09", "10", "11", "12"],
                       ["", "01", "02", "03", "04", "05", "06", "07", "08", "09", "10", "11", "12",
                        "13", "14", "15", "16", "17", "18", "19", "20", "21", "22", "23", "24",
                        "25", "26", "27", "28", "29", "30", "31"],
                       ["", "2019", "2020", "2021", "2022", "2023", "2024", "2025", "2026", "2027", "2028", "2029",
                        "2030", "2031", "2032", "2033", "2034", "2035", "2036", "2037", "2038", "2039", "2040"],
                       ["", "01", "02", "03", "04", "05", "06", "07", "08", "09", "10", "11", "12"],
                       ["", "01", "02", "03", "04", "05", "06", "07", "08", "09", "10", "11", "12",
                        "13", "14", "15", "16", "17", "18", "19", "20", "21", "22", "23", "24",
                        "25", "26", "27", "28", "29", "30", "31", "32", "33", "34", "35", "36",
                        "37", "38", "39", "40", "41", "42", "43", "44", "45", "46", "47", "48",
                        "49", "50", "51", "52", "53", "54", "55", "56", "57", "58", "59"],
                       ["", "AM", "PM"]]
    var picker = UIPickerView()

    override func viewDidLoad() {
        super.viewDidLoad()
        ref = Database.database().reference()
        // Do any additional setup after loading the view.
        
        picker.delegate = self
        picker.dataSource = self
        
        timeField.inputView = picker
        
        let toolBar = UIToolbar(frame: CGRect(x: 0, y: self.view.frame.size.width, width: self.view.frame.size.height/6, height: 40.0))
        
        toolBar.layer.position = CGPoint(x: self.view.frame.size.width/2, y: self.view.frame.size.height-20.0)
        //toolBar.barStyle = UIBarStyle.blackTranslucent
        //toolBar.tintColor = UIColor.white
        //toolBar.backgroundColor = UIColor.black
        
        let defaultButton = UIBarButtonItem(title: "Cancel", style: UIBarButtonItem.Style.plain, target: self, action: #selector(OrgPickerViewController.cancelPressed))
        let doneButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.done, target: self, action: #selector(OrgPickerViewController.donePressed))
        let flexSpace = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: self, action: nil)
        
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: self.view.frame.size.width / 3, height: self.view.frame.size.height))
        label.font = UIFont(name: "Helvetica", size: 12)
        label.backgroundColor = UIColor.clear
        label.textColor = UIColor.blue
        //label.text = "Select your organization"
        label.textAlignment = NSTextAlignment.center
        
        let textBtn = UIBarButtonItem(customView: label)
        
        toolBar.setItems([defaultButton,flexSpace,textBtn,flexSpace,doneButton], animated: true)
        
        timeField.inputAccessoryView = toolBar
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return timeOption.count
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return timeOption[component].count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return timeOption[component][row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        let month = timeOption[0][picker.selectedRow(inComponent: 0)]
        let day = timeOption[1][picker.selectedRow(inComponent: 1)]
        let year = timeOption[2][picker.selectedRow(inComponent: 2)]
        let hour = timeOption[3][picker.selectedRow(inComponent: 3)]
        let minute = timeOption[4][picker.selectedRow(inComponent: 4)]
        let period = timeOption[5][picker.selectedRow(inComponent: 5)]
        timeField.text = month + "/" + day + "/" + year + " " + hour + ":" + minute + " " + period
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    @objc func donePressed(sender: UIBarButtonItem) {
        //User.globalVariable.org = timeField.text ?? "yeet"
        
        //FIX THESE TWO LINES
        
        //DummyUser.globalVariable.org = timeField.text ?? "mooted"
        //let org = timeField.text ?? "mooted"
        //self.ref?.child("Organizations").child(org).setValue([id:email])
        
        //addUserOrg(org)
        
        //somehow update existing user?
        timeField.resignFirstResponder()
        //performSegue(withIdentifier: "firstLogInSegue", sender: self)
    }
    
    @objc func cancelPressed(sender: UIBarButtonItem) {
        timeField.text = ""
        timeField.resignFirstResponder()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(true, animated: true)
        self.navigationController?.isNavigationBarHidden = false
    }
    
    @IBAction func publishClicked(_ sender: Any) {
        guard let nameField = nameField.text else { return }
        guard let location = locationField.text else { return }
        guard let time = timeField.text else { return }
        guard let description = descriptionView.text else { return }
//        guard let going = "false" as Optional else { return }
//        guard let interested = "false" as Optional else { return }
//        guard let notGoing = "false" as Optional else { return }
        //let id = DummyUser.globalVariable.id
        let id = Firebase.Auth.auth().currentUser?.uid ?? "bleep"
        
        //_ = Event(name: nameField , location: location, time: time, description: description, poster: posterName)
     
        DataService.instance.pushEvent(name: nameField, location: location, time: time, description: description, id: id) { (isComplete) in
                                       //going: going, interested: interested, notGoing: notGoing) { (isComplete) in
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


