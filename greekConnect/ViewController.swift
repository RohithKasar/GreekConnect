//
//  ViewController.swift
//  greekConnect
//
//  Created by Rohith Kasar on 4/23/19.
//  Copyright © 2019 rohith.kasar. All rights reserved.
//

import UIKit

import FirebaseUI
import FirebaseDatabase

class ViewController: UIViewController {

    var ref:DatabaseReference?
    var user:User!
    
    override func viewDidLoad() {
        super.viewDidLoad()
            
        ref = Database.database().reference()
        // Do any additional setup after loading the view, typically from a nib.
    }

    /*@IBAction func logInPressed(_ sender: Any) {
        let authUI = FUIAuth.defaultAuthUI()
        
        guard authUI != nil else {
            return
        }
        
        authUI?.delegate = self
        authUI?.providers = [FUIEmailAuth()]
        
        let authViewController = authUI!.authViewController()
        
        present(authViewController, animated: true, completion: nil)
    }*/

    @IBAction func logInPressed(_ sender: Any) {
        let authUI = FUIAuth.defaultAuthUI()
        
        guard authUI != nil else {
            return
        }
        
        authUI?.delegate = self
        authUI?.providers = [FUIEmailAuth()]
        
        let authViewController = authUI!.authViewController()
        
        present(authViewController, animated: true, completion: nil)
    }
    
}

extension ViewController: FUIAuthDelegate {
    func authUI(_ authUI: FUIAuth, didSignInWith authDataResult: AuthDataResult?, error: Error?) {
        guard error == nil else {
            return
        }
        
        /*DataService.instance.pushEvent(name: nameField, location: location, time: time, description: description) { (isComplete) in
            if isComplete {
                print("successfully updated an event to firebase")
                
            } else {
                print("there was an error uploading an event to firebase")
            }
        }*/
        
//        let id = authUI.auth?.currentUser?.uid ?? "UserId"
//        let email = authUI.auth?.currentUser?.email ?? "email"
//        let name = authUI.auth?.currentUser?.displayName ?? "name"
//
//
//
//        DataService.instance.pushUser(name: name, email: email, id: id, org: "temp") { (isComplete) in
//            if isComplete {
//                print ("successfully updated a user to firebase")
//            } else {
//                print ("there was an error uploading a user to firebase")
//            }
//        }

        DummyUser.globalVariable.id = authUI.auth?.currentUser?.uid ?? "User"
        DummyUser.globalVariable.email = authUI.auth?.currentUser?.email ?? "email"
        /*User.globalVariable.name = authUI.auth?.currentUser?.displayName ?? "name"
        self.ref?.child("Users").child(User.globalVariable.id).setValue([authDataResult?.user.displayName ?? "Name": User.globalVariable.email]);*/
        
        if (authDataResult?.additionalUserInfo?.isNewUser ?? false) {
            
            let id = authUI.auth?.currentUser?.uid ?? "UserId"
            let email = authUI.auth?.currentUser?.email ?? "email"
            let name = authUI.auth?.currentUser?.displayName ?? "name"
            
            DataService.instance.pushUser(name: name, email: email, id: id) { (isComplete) in
                if isComplete {
                    print ("successfully updated a user to firebase")
                } else {
                    print ("there was an error uploading a user to firebase")
                }
            }
            performSegue(withIdentifier: "orgPickSegue", sender: self)
            
        } else {
            performSegue(withIdentifier: "logInSegue", sender: self)
        }
        
        
        
    }

    
    
}
