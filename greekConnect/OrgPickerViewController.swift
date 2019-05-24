//
//  ViewController.swift
//  testPickerView
//
//  Created by Ellis Chang on 4/25/19.
//  Copyright © 2019 echang41@gmail.com. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase
import FirebaseAuth

class OrgPickerViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    var org = ""
    var id = DummyUser.globalVariable.id
    var email = DummyUser.globalVariable.email
    var ref:DatabaseReference?
    var organization = ["placeholder"]
    var fratList = ["", "Alpha Epsilon Omega, Eta","Alpha Epsilon Pi", "Alpha Lamda Mu", "Beta Theta Pi", "Delta Lambda Phi",
                    "Gamma Zeta Alpha", "Kappa Sigma", "Lambda Chi Alpha", "Lambda Theta Phi", "Lambda Phi Epsilon",
                    "Phi Delta Theta", "Phi Gamma Delta", "Pi Kappa Alpha", "Pi Kappa Phi", "Nu Alpha Kappa",
                    "Phi Iota Alpha", "Pi Alpha Phi", "Psi Chi Omega", "Sigma Alpha Epsilon", "Sigma Alpha Mu",
                    "Sigma Chi", "Sigma Nu", "Sigma Phi Epsilon", "Tau Kappa Epsilon", "Triangle"]
    var sorList = ["", "Alpha Chi Omega", "Alpha Epsilon Phi", "Alpha Gamma Alpha", "Alpha Omicron Pi", "Alpha Phi",
                   "Chi Omega", "Delta Delta Delta", "Delta Gamma", "Kappa Alpha Theta", "Kappa Kappa Gamma",
                   "Kappa Zeta Phi", "Lambda Theta Alpha", "Lambda Theta Nu", "Phi Lambda Rho", "Phi Sigma Rho",
                   "Pi Beta Phi", "Sigma Alpha Zeta", "Sigma Kappa", "Sigma Omicron Pi", "Sigma Pi Alpha"]
    var picker = UIPickerView()
    var test = ""
    
    @IBOutlet weak var orgTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ref = Database.database().reference()
        
        // Do any additional setup after loading the view.
        if (org.elementsEqual("frat")) {
            organization = fratList
        } else {
            organization = sorList
        }
        
        picker.delegate = self
        picker.dataSource = self
        
        orgTextField.inputView = picker
        
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
        
        orgTextField.inputAccessoryView = toolBar
    }
    
    @objc func donePressed(sender: UIBarButtonItem) {
        var orgArray = [Organization]()
        
//        print("adslfghjiwreuighlfjkndlsjeiwaoruygflhbjvdsfkh;erwu[pty;'")
//        print(orgArray.count)
        //unfortunately at this point orgArray is empty
        //if it were not empty, we would be able to handle adding to an existing org vs creating a new org
        
        
        
        DummyUser.globalVariable.org = orgTextField.text ?? "mooted"
        let passedOrg = orgTextField.text ?? "mooted"
        //DataService.instance.REF_USER.childByAutoId(DummyUser.globalVariable.id)
        DataService.instance.REF_USER.child(DummyUser.globalVariable.id).updateChildValues(["org" : passedOrg])
        var inside = false
        
        DataService.instance.fetchOrgs(handler: { (paramOrgs) in
            orgArray = paramOrgs
            for org in orgArray {
                if (org.name == passedOrg) {
                    inside = true;
                    
                }
            }
            if (!inside) {
                let autoId = DataService.instance.REF_ORGS.child(passedOrg)
                autoId.child("name").setValue(passedOrg)
                autoId.child("members").updateChildValues([self.id:self.email])
            } else {
                Database.database().reference().child("Organizations").child(passedOrg).child("members").updateChildValues([self.id:self.email])
            }
            
        })
        
//        for org in orgArray {
//            if (org.name == passedOrg) {
//                inside = true;
//                passedOrg = org.name
//
//                //org.memberIds.append
//            }
//        }
//        if (!inside) {
//            //let autoId = DataService.instance.REF_ORGS.child(passedOrg)
//            let autoId = DataService.instance.REF_ORGS.childByAutoId()
//            autoId.child("name").setValue(passedOrg)
//            autoId.child("members").updateChildValues([id:email])
//        } else {
//            //how to add to an existing org????????
//            //Database.database().reference().child("Organizations").child(passedOrg).child("members").updateChildValues([id:email])
//
//        }
        
        
        
        
        orgTextField.resignFirstResponder()
        performSegue(withIdentifier: "firstLogInSegue", sender: self)
    }
    
    @objc func cancelPressed(sender: UIBarButtonItem) {
        orgTextField.text = ""
        orgTextField.resignFirstResponder()
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return organization.count;
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return organization[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        orgTextField.text = organization[row]
    }    
}
