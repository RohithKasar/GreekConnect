//
//  InviteViewController.swift
//  greekConnect
//
//  Created by Ellis Chang on 5/24/19.
//  Copyright © 2019 rohith.kasar. All rights reserved.
//

import UIKit
import Alamofire
import Firebase
import FirebaseDatabase


class InviteViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UIPickerViewDelegate, UIPickerViewDataSource, UITextFieldDelegate {
    
    var picker1 = UIPickerView()
    var picker2 = UIPickerView()
    
    var ref:DatabaseReference?
    @IBOutlet weak var exchangeName: UITextField!
    @IBOutlet weak var exchangeLocation: UITextField!
    @IBOutlet weak var exchangeTime: UITextField!
    @IBOutlet weak var exchangeOrg: UITextField!
    @IBOutlet weak var exchangeDescription: UITextView!
    
    @IBOutlet weak var exchangeImage: UIImageView!
    var users = [User]()
    var idArray = [String]()
    var sexyId = ""
    
    var orgList = ["", "Alpha Chi Omega", "Alpha Epsilon Omega",  "Alpha Epsilon Phi", "Alpha Epsilon Pi",
                   "Alpha Gamma Alpha", "Alpha Lamda Mu", "Alpha Omicron Pi", "Alpha Phi", "Beta Theta Pi",
                   "Chi Omega", "Delta Delta Delta", "Delta Gamma", "Delta Lambda Phi","Gamma Zeta Alpha",
                   "Kappa Alpha Theta", "Kappa Kappa Gamma", "Kappa Sigma", "Kappa Zeta Phi", "Lambda Chi Alpha",
                   "Lambda Phi Epsilon", "Lambda Theta Alpha", "Lambda Theta Nu", "Lambda Theta Phi", "Nu Alpha Kappa",
                   "Phi Delta Theta", "Phi Gamma Delta", "Phi Iota Alpha", "Phi Lambda Rho", "Phi Sigma Rho",
                   "Pi Alpha Phi", "Pi Beta Phi", "Pi Kappa Alpha", "Pi Kappa Phi", "Psi Chi Omega", "Sigma Alpha Epsilon",
                   "Sigma Alpha Mu", "Sigma Alpha Zeta", "Sigma Chi", "Sigma Kappa", "Sigma Nu", "Sigma Omicron Pi",
                   "Sigma Phi Epsilon", "Sigma Pi Alpha", "Tau Kappa Epsilon", "Triangle"]
    var timeOption = [["Mo", "01", "02", "03", "04", "05", "06", "07", "08", "09", "10", "11", "12"],
                      ["Day", "01", "02", "03", "04", "05", "06", "07", "08", "09", "10", "11", "12",
                       "13", "14", "15", "16", "17", "18", "19", "20", "21", "22", "23", "24",
                       "25", "26", "27", "28", "29", "30", "31"],
                      ["Hr", "01", "02", "03", "04", "05", "06", "07", "08", "09", "10", "11", "12"],
                      ["Min", "01", "02", "03", "04", "05", "06", "07", "08", "09", "10", "11", "12",
                       "13", "14", "15", "16", "17", "18", "19", "20", "21", "22", "23", "24",
                       "25", "26", "27", "28", "29", "30", "31", "32", "33", "34", "35", "36",
                       "37", "38", "39", "40", "41", "42", "43", "44", "45", "46", "47", "48",
                       "49", "50", "51", "52", "53", "54", "55", "56", "57", "58", "59"],
                      ["", "AM", "PM"]]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ref = Database.database().reference()
        //textFieldDidBeginEditing(currentTextField)
        // Do any additional setup after loading the view.
        
        picker1.delegate = self
        picker1.dataSource = self
        picker2.delegate = self
        picker2.dataSource = self
        
        picker1.tag = 0
        picker2.tag = 1
//
        exchangeOrg.inputView = picker1
        exchangeTime.inputView = picker2
        
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
        
        exchangeOrg.inputAccessoryView = toolBar
        exchangeTime.inputAccessoryView = toolBar
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
    
    @IBAction func inviteClicked(_ sender: Any) {
        guard let name = exchangeName.text else { return }
        guard let location = exchangeLocation.text else { return }
        guard let time = exchangeTime.text else { return }
        guard let org = exchangeOrg.text else { return }
        guard let description = exchangeDescription.text else {return}
        
        let currentId = Firebase.Auth.auth().currentUser?.uid ?? "bleep"
        
        DataService.instance.fetchUser { (paramUsers) in
            
            var currentUser = User(name: "ah", id: "id", org: "org", email: "email")
            for user in paramUsers {
                if (user.id == currentId) {
                    currentUser = user
                }
            }
            
            var currentOrg = Organization(name: "default", memberIds: [])
            DataService.instance.fetchOrgs(handler: { (paramOrgs) in
                
                for org in paramOrgs {
                    if (org.name == currentUser.org) {
                        currentOrg = org
                    }
                }
                
                print("current org is " + currentOrg.name)
                self.users = paramUsers
                //print(self.users.count)
                for user in self.users {
                    //print(user.org)
                    if (user.org == org || user.org == currentOrg.name) {
                        print("Matched up User = " + user.name)
                        DataService.instance.pushExchange(name: name, location: location, time: time, description: description, id: currentId, recipient: user.id, handler: { (paramSexyId) in
                            self.sexyId = paramSexyId
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
            })
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
        if (pickerView.tag == 0) {
            return 1
        }
        else if (pickerView.tag == 1) {
            return timeOption.count
        }
        else {
            return 0
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if (pickerView.tag == 0) {
            return orgList.count
        }
        else if (pickerView.tag == 1) {
            return timeOption[component].count
        }
        else {
            return 0
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if (pickerView.tag == 0) {
            return orgList[row]
        }
        else if (pickerView.tag == 1) {
            return timeOption[component][row]
        }
        else {
            return nil
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if (pickerView.tag == 0) {
            exchangeOrg.text = orgList[row]
        }
        else if (pickerView.tag == 1) {
            let month = timeOption[0][picker2.selectedRow(inComponent: 0)]
            let day = timeOption[1][picker2.selectedRow(inComponent: 1)]
            let hour = timeOption[2][picker2.selectedRow(inComponent: 2)]
            let minute = timeOption[3][picker2.selectedRow(inComponent: 3)]
            let period = timeOption[4][picker2.selectedRow(inComponent: 4)]
            exchangeTime.text = month + "/" + day + " " + hour + ":" + minute + " " + period
        }
        else {
            print("error in pickerview and textfield for tet")
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    @objc func donePressed(sender: UIBarButtonItem) {
        exchangeOrg.resignFirstResponder()
        exchangeTime.resignFirstResponder()
    }
    
    @objc func cancelPressed(sender: UIBarButtonItem) {
        if (exchangeOrg.text != nil) {
            exchangeOrg.text = ""
            exchangeOrg.resignFirstResponder()
        }
        else {
            exchangeOrg.resignFirstResponder()
            exchangeTime.resignFirstResponder()
        }
        
        if (exchangeTime.text != nil) {
            exchangeTime.text = ""
            exchangeTime.resignFirstResponder()
        }
        else {
            exchangeOrg.resignFirstResponder()
            exchangeTime.resignFirstResponder()
        }
    }
    
}
