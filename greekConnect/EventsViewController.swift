//
//  EventsViewController.swift
//  greekConnect
//
//  Created by Ellis Chang on 5/2/19.
//  Copyright © 2019 rohith.kasar. All rights reserved.
//

import UIKit
import Firebase

class EventsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    var events = [Event]()
    var users = [User]()
    
    @IBOutlet weak var eventsTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        eventsTableView.delegate = self
        eventsTableView.dataSource = self

        eventsTableView.allowsSelection = false
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        DataService.instance.fetchEvents(handler: { (paramEvents) in
            self.events = paramEvents
            self.eventsTableView.reloadData()
        })
        
        DataService.instance.fetchUser { (paramUsers) in
            self.users = paramUsers
            self.eventsTableView.reloadData()
        }
    }
    
    
    @IBAction func back(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return events.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "EventCell") as! EventCell
        
        let event = events[indexPath.row]
        cell.nameLabel.text = event.name
        cell.descriptionLabel.text = event.description
        let location = event.location 
        cell.timeLabel.text = event.time + " at " + location
        
        //let key = event.poster
        //find the key in users and extract their username and org
        /*for user in users {
            if (user.id == key) {
                cell.userNameLabel.text = user.name
                cell.orgNameLabel.text = user.org
            }
        }*/
        
        let pathReference = Storage.storage().reference(withPath: "Event/\(event.name)")
        pathReference.getData(maxSize: 1*1024*1024) { (data, error) in
            if error != nil {
                print("error occurred pulling image from storage")
            } else {
                cell.posterImageView.image = UIImage(data: data!)
            }
        }
        /*
        cell.profileImage.image = UIImage(named: "blank-profile-pic.jpg")
        cell.profileImage.layer.cornerRadius = 19.5
        cell.profileImage.clipsToBounds = true
        */
        return cell
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
