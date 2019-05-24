//
//  ProfileViewController.swift
//  greekConnect
//
//  Created by Ellis Chang on 5/2/19.
//  Copyright © 2019 rohith.kasar. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth

class ProfileViewController: UIViewController {

    
    @IBOutlet weak var coverImage: UIImageView!
    
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var orgName: UILabel!
    @IBOutlet weak var orgDescription: UILabel!
    @IBOutlet weak var memberList: UILabel!
    @IBOutlet weak var userName: UILabel!
    
    var users = [User]()
    var orgs = [Organization]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        DataService.instance.fetchUser { (paramUsers) in
            self.users = paramUsers
            let currentId = Firebase.Auth.auth().currentUser?.uid ?? "bleep"
            var currentUser = User(name: "ah", id: "id", org: "org", email: "email")
            for user in self.users {
                if (user.id == currentId) {
                    currentUser = user
                }
            }
            self.orgName.text = currentUser.org
            self.userName.text = currentUser.name
            
            var currentOrg = Organization(name: "default", memberIds: [])
            DataService.instance.fetchOrgs(handler: { (paramOrgs) in
                self.orgs = paramOrgs
                for org in self.orgs {
                    if (org.name == currentUser.org) {
                        currentOrg = org
                    }
                }
                print(currentUser.org)
                print("BOUTTA PRINT IDS")
                print(currentOrg.name)
                for id in currentOrg.memberIds {
                    
                    print("hello" + id)
                    //self.memberList.text?.append(contentsOf: id)
                }
            })
            
        }
        
//        DataService.instance.fetchOrgs(handler: { (paramOrgs) in
//            self.orgs = paramOrgs
//            for org in self.orgs {
//                if (org.na)
//        })
        
        
//        var memberArray = [String]()
//        DataService.instance.getIds(forOrg: currentUser.org, handler: { (paramMemberArray) in
//            memberArray = paramMemberArray
//        })
        
        
//        for member in memberArray {
//            memberList.text?.append(contentsOf: member + ", ")
//        }
        
        //if we can get fetchOrgs and fetchUsers to work, we can customize this profile page.
        //for some reason its not working here
        
        


//        print(orgs.count)
//        for org in orgs {
//           print(org.name)
//        }
        
        
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
