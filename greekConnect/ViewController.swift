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
        
        User.globalVariable.id = authUI.auth?.currentUser?.uid ?? "User"
        self.ref?.child("Users").child(User.globalVariable.id).setValue(authDataResult?.user.displayName ?? "Name")
        
        if (authDataResult?.additionalUserInfo?.isNewUser ?? false) {

            performSegue(withIdentifier: "orgPickSegue", sender: self)
            
        } else {
            performSegue(withIdentifier: "logInSegue", sender: self)
        }
    }

    
    
}
