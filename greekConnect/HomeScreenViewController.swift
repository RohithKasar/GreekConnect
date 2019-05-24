//
//  HomeScreenViewController.swift
//  greekConnect
//
//  Created by Rohith Kasar on 4/28/19.
//  Copyright © 2019 rohith.kasar. All rights reserved.
//

import UIKit
import Firebase
//import FirebaseUI
import FirebaseAuth

class HomeScreenViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, PostCellDelegate {
    
    @IBOutlet weak var hamburgerButton: UIBarButtonItem!
    @IBOutlet weak var leadingConstraint: NSLayoutConstraint!
    @IBOutlet weak var trailingConstraint: NSLayoutConstraint!
    @IBOutlet weak var leadingShadowConstraint: NSLayoutConstraint!
    @IBOutlet weak var trailingShadowConstraint: NSLayoutConstraint!
    @IBOutlet weak var menuShadowView: UIView!
    @IBOutlet weak var profileImage: UIImageView!
    
//    @IBOutlet weak var goingLabel: UILabel!
//    @IBOutlet weak var interestedLabel: UILabel!
    
    @IBOutlet weak var tableView: UITableView!
    
    
    var events = [Event]()
    var users = [User]()
    
    var menuShow = false
//    var going = false
//    var interested = false
//    var notGoing = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        // Do any additional setup after loading the view.
        tableView.layer.masksToBounds = false
        tableView.layer.shadowOpacity = 0.9
        menuShadowView.backgroundColor = UIColor.black
        menuShadowView.layer.opacity = 0
        
        //profileImage.image = UIImage(named: "blank-profile-pic.jpg")
        
        
        //let orgName = cell.orgNameLabel.text?.lowercased()
        let orgName = DummyUser.globalVariable.org.lowercased()
        let sexyOrgName = (orgName) + ".png"
        
        let profileReference = Storage.storage().reference(withPath: "Images/\(sexyOrgName)")
        profileReference.getData(maxSize: 1*1024*1024) { (data, error) in
            if error != nil {
                print("error occurred pulling image from storage " + DummyUser.globalVariable.name)
                self.profileImage.image = UIImage(named: "blank-profile-pic.jpg")
            } else {
                self.profileImage.image = UIImage(data: data!)
            }
        }
        
        //self.profileImage.image = UIImage(named: "blank-profile-pic.jpg")
        profileImage.layer.cornerRadius = 32.5
        profileImage.clipsToBounds = true
        //goingLabel.isHidden = true
        //interestedLabel.isHidden = true
        
        DataService.instance.fetchEvents(handler: { (paramEvents) in
            
            let marapEvents = paramEvents.reversed()
            for event in marapEvents {
                if (event.isPrivate == false) {
                    //self.events.append(event)
                }
                
            }
            
            //self.events = paramEvents.reversed()
            self.tableView.reloadData()
            
            
        })
        
        DataService.instance.fetchUser(handler : { (paramUsers) in
            self.users = paramUsers
            self.tableView.reloadData()
            let currentId = Firebase.Auth.auth().currentUser?.uid ?? "bleep"
            var currentUser = User(name: "ah", id: "id", org: "org", email: "email")
            for user in self.users {
                if (user.id == currentId) {
                    currentUser = user
                }
            }
            
            
            let profileOrgName = currentUser.org.lowercased()
            
            let sexyOrgName = (profileOrgName) + ".png"
           
            
            let profileReference = Storage.storage().reference(withPath: "Images/\(sexyOrgName)")
            profileReference.getData(maxSize: 1*1024*1024) { (data, error) in
                if error != nil {
                    //print("error occurred pulling image from storage " + DummyUser.globalVariable.name)
                    self.profileImage.image = UIImage(named: "blank-profile-pic.jpg")
                } else {
                    self.profileImage.image = UIImage(data: data!)
                }
            }
            
        })

        self.tableView.separatorStyle = UITableViewCell.SeparatorStyle.none
        tableView.allowsSelection = false
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = false
    }

    @IBAction func openSideMenu(_ sender: Any) {
        if (menuShow) {
            hamburgerButton.image = UIImage(named: "icons8-menu-50.png")
            
            leadingConstraint.constant = 0
            trailingConstraint.constant = 0
            leadingShadowConstraint.constant = 0
            trailingShadowConstraint.constant = 0
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
            leadingShadowConstraint.constant = 154
            trailingShadowConstraint.constant = 154
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
            performSegue(withIdentifier: "signOutSegue", sender: self)
        } catch {
            print(error)
        }
        //performSegue(withIdentifier: "signOutSegue", sender: self)

    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
 
        
        DataService.instance.fetchEvents(handler: { (paramEvents) in
            let marapEvents = paramEvents.reversed()
            self.events.removeAll()
            for event in marapEvents {
                if (event.isPrivate == false) {
                    self.events.append(event)
                }
                
            }
            self.tableView.reloadData()
        })
        
        DataService.instance.fetchUser(handler : { (paramUsers) in
            self.users = paramUsers
            self.tableView.reloadData()
            
        })
        self.tableView.reloadData()
        //at this point, even though we have fetched events w/ fetchEvents, the count is still 0.
        //however, if we are accessing events.count in another method, it is the correct value. how does that work?
        
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return events.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PostCell", for: indexPath) as! PostCell
        cell.delegate = self
        
        let event = events[indexPath.row]
        cell.eventNameLabel.text = event.name
        cell.descriptionLabel.text = "Description " + event.description
        cell.locationLabel.text = "Where: " + event.location
        cell.timeLabel.text = "When: " + event.time
        
        
        
        let key = event.poster
        //find the key in users and extract their username and org
        for user in users {
            if (user.id == key) {
                cell.userNameLabel.text = user.name
                cell.orgNameLabel.text = user.org
            }
        }
        
        let pathReference = Storage.storage().reference(withPath: "Event/\(event.name)")
        pathReference.getData(maxSize: 1*1024*1024) { (data, error) in
            if error != nil {
                cell.eventImage.image = UIImage(named: "poster-placeholder.jpg")
                
            } else {
                cell.eventImage.image = UIImage(data: data!)
            }
        }
        
        
        let orgName = cell.orgNameLabel.text?.lowercased()
        
        
        let sexyOrgName = (orgName ?? "oof") + ".png"
        
        let profileReference = Storage.storage().reference(withPath: "Images/\(sexyOrgName)")
        profileReference.getData(maxSize: 1*1024*1024) { (data, error) in
            if error != nil {
                
                cell.profileImage.image = UIImage(named: "blank-profile-pic.jpg")
            } else {
                cell.profileImage.image = UIImage(data: data!)
            }
        }
        
        
        cell.profileImage.layer.cornerRadius = 19.5
        cell.profileImage.clipsToBounds = true

        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 500
    }
    
    func goingPressed(_ sender: UIButton) {
        var indexPath = getCurrentCellIndexPath(sender)
        let event = self.events[(indexPath?.popLast())!]
        //print(indexPath?.popLast())
        
        let currentId = Firebase.Auth.auth().currentUser?.uid ?? "bleep"
        DataService.instance.REF_USER.child(currentId).child("personalEvents").updateChildValues([event.eventId : event.name])
        
        //HOW TO REMOVE AN EVENT FROM EVENT VIEW CONTROLLER
        //DataService.instance.REF_USER.child(currentId).child("personalEvents").child(event.eventId).removeValue()
        print("GOING CLICKED")
        self.tableView.reloadData()
    }
    
    func notGoingPressed(_ sender: UIButton) {
        
        
        var indexPath = getCurrentCellIndexPath(sender)
        let event = self.events[(indexPath?.popLast())!]
        //print(indexPath?.popLast())
        
        let currentId = Firebase.Auth.auth().currentUser?.uid ?? "bleep"
        //DataService.instance.REF_USER.child(currentId).child("personalEvents").updateChildValues([event.eventId : event.name])
        
        //HOW TO REMOVE AN EVENT FROM EVENT VIEW CONTROLLER
        print("Yeet")
        DataService.instance.REF_USER.child(currentId).child("personalEvents").child(event.eventId).removeValue()
        self.tableView.reloadData()
    }

    func interestedPressed(_ sender: UIButton) {
//        let indexPath = getCurrentCellIndexPath(sender)
//
//        let cell = tableView.dequeueReusableCell(withIdentifier: "PostCell", for: indexPath!) as! PostCell
//        cell.delegate = self
//        cell.going = false
//        cell.interested = true
//        cell.notGoing = false
//        cell.goingButton.isHidden = true
//        cell.goingButton.isEnabled = false
//        cell.interestedButton.isHidden = true
//        cell.interestedButton.isEnabled = false
//        cell.notGoingButton.isHidden = true
//        cell.notGoingButton.isEnabled = false
//        self.tableView.reloadData()
    }
    
    
    
    func getCurrentCellIndexPath(_ sender: UIButton) -> IndexPath? {
        let buttonPosition = sender.convert(CGPoint.zero, to: tableView)
        
        if let indexPath: IndexPath = tableView.indexPathForRow(at: buttonPosition) {
            
            return indexPath
        }
        return nil
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
