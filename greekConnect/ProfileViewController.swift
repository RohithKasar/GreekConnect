//
//  ProfileViewController.swift
//  greekConnect
//
//  Created by Ellis Chang on 5/2/19.
//  Copyright © 2019 rohith.kasar. All rights reserved.
//

import UIKit
import Firebase
class ProfileViewController: UIViewController {

    
    @IBOutlet weak var coverImage: UIImageView!
    
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var orgName: UILabel!
    @IBOutlet weak var orgDescription: UILabel!
    @IBOutlet weak var memberList: UILabel!
    @IBOutlet weak var userName: UILabel!
    
    var users = [User]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        DataService.instance.fetchUser { (paramUsers) in
            self.users = paramUsers
        }
        
        let currentId = Firebase.Auth.auth().currentUser?.uid ?? "bleep"
        
        var currentUser = User(name: "name", id: "id", org: "org", email: "email")
        
        for user in users {
            if (user.id == currentId) {
                currentUser = user
            }
        }
        
        orgName.text = currentUser.org
        userName.text = currentUser.name
        
        
        
        
        
        
        // Do any additional setup after loading the view.
    }
    
    @IBAction func back(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
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
