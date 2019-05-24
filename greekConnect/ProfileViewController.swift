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
    
    @IBOutlet weak var orgName: UILabel!
    @IBOutlet weak var orgDescription: UILabel!
    @IBOutlet weak var memberList: UILabel!
    @IBOutlet weak var userName: UILabel!
    
    var users = [User]()
    var orgs = [Organization]()
    var memberArray = [String]()
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        var orgName = DummyUser.globalVariable.org
//        orgName = orgName.lowercased()
//        
//        
//        let sexyOrgName = orgName + ".png"
//        
//        let profileImageReference = Storage.storage().reference(withPath: "Image/\(sexyOrgName)")
//        profileImageReference.getData(maxSize: 1*1024*1024) { (data, error) in
//            if error != nil {
//                print("error occurred pulling image from storage")
//                self.profileImage.image = UIImage(named: "blank-profile-pic.jpg")
//            } else {
//                self.profileImage.image = UIImage(data: data!)
//            }
//        }
        
        
        
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
            
            let profileOrgName = currentUser.org.lowercased()
            let sexyOrgName = (profileOrgName) + ".png"
            
            let profileReference = Storage.storage().reference(withPath: "Images/\(sexyOrgName)")
            profileReference.getData(maxSize: 1*1024*1024) { (data, error) in
                if error != nil {
                    print("error occurred pulling image from storage " + DummyUser.globalVariable.name)
                    self.coverImage.image = UIImage(named: "blank-profile-pic.jpg")
                } else {
                    self.coverImage.image = UIImage(data: data!)
                }
            }
            
            var currentOrg = Organization(name: "default", memberIds: [])
            DataService.instance.fetchOrgs(handler: { (paramOrgs) in
                self.orgs = paramOrgs
                for org in self.orgs {
                    if (org.name == currentUser.org) {
                        currentOrg = org
                    }
                }


                
                for id in currentOrg.memberIds {
                    
                    
                    for user in self.users {
                        if (user.id == id) {
                            self.memberArray.append(user.name)
                        }
                    }
                }
                self.memberList.text?.append("\n")
                for member in self.memberArray {
                    self.memberList.text?.append(contentsOf: member + "\n")
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
