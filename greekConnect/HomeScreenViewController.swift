//
//  HomeScreenViewController.swift
//  greekConnect
//
//  Created by Rohith Kasar on 4/28/19.
//  Copyright © 2019 rohith.kasar. All rights reserved.
//

import UIKit
import FirebaseUI
//import FirebaseAuth

class HomeScreenViewController: UIViewController {
    
    @IBOutlet weak var hamburgerButton: UIBarButtonItem!
    @IBOutlet weak var leadingConstraint: NSLayoutConstraint!
    @IBOutlet weak var trailingConstraint: NSLayoutConstraint!
    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var menuShadowView: UIView!
    
    var menuShow = false
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        mainView.layer.shadowOpacity = 0.9
        menuShadowView.backgroundColor = UIColor.black
        menuShadowView.layer.opacity = 0
    }

    @IBAction func openSideMenu(_ sender: Any) {
        if (menuShow) {
            hamburgerButton.image = UIImage(named: "icons8-menu-50.png")
            
            leadingConstraint.constant = 0
            trailingConstraint.constant = 0
            UIView.animate(withDuration: 0.2, animations: {
                self.view.layoutIfNeeded()
            })
            
            UIView.animate(withDuration: 0.3) {
                self.menuShadowView.layer.opacity = 0
            }
            
        } else {
            hamburgerButton.image = UIImage(named: "icons8-menu-filled-50.png")
            
            leadingConstraint.constant = 154
            trailingConstraint.constant = 154
            UIView.animate(withDuration: 0.2, animations: {
                self.view.layoutIfNeeded()
            })
            
            UIView.animate(withDuration: 0.3) {
                self.menuShadowView.layer.opacity = 0.40
            }
        }
        menuShow = !menuShow
    }
    
    @IBAction func postScreen(_ sender: Any) {
        performSegue(withIdentifier: "postSegue", sender: self)
    }
    
    @IBAction func profileScreen(_ sender: Any) {
        performSegue(withIdentifier: "profileSegue", sender: self)
    }
    
    @IBAction func eventsPage(_ sender: Any) {
        performSegue(withIdentifier: "eventsSegue", sender: self)
    }
    
    @IBAction func signOut(_ sender: Any) {
        do {
            try Auth.auth().signOut()
            //performSegue(withIdentifier: "signOutSegue", sender: self)
        } catch let logoutError {
            print(logoutError)
        }
        //performSegue(withIdentifier: "signOutSegue", sender: self)

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
