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
    var eventIds = [String]()
    var privateEvents = [Event]()
    
    @IBOutlet weak var eventsTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        eventsTableView.delegate = self
        eventsTableView.dataSource = self
        eventsTableView.allowsSelection = false
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        let currentUser = Auth.auth().currentUser?.uid ?? "bleep"
        DataService.instance.fetchPrivateEvents(forUser: currentUser) { (paramPrivateEvents) in
            self.eventIds = Array(paramPrivateEvents.keys).reversed()
            
            DataService.instance.fetchEvents(handler: { (paramEvents) in
                self.events = paramEvents
                
                for event in self.events {
                    for eventId in self.eventIds {
                        if (eventId == event.eventId) {
                            self.privateEvents.append(event)
                        }
                    }
                }
                
                self.eventsTableView.reloadData()
            })
            
        }
        
        DataService.instance.fetchUser { (paramUsers) in
            self.users = paramUsers
            self.eventsTableView.reloadData()
        }
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
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return privateEvents.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "EventCell") as! EventCell
        
        let event = privateEvents[indexPath.row]
        cell.nameLabel.text = event.name
        cell.descriptionLabel.text = event.description
        let location = event.location 
        cell.timeLabel.text = event.time + " at " + location

        let pathReference = Storage.storage().reference(withPath: "Event/\(event.name)")
        pathReference.getData(maxSize: 1*1024*1024) { (data, error) in
            if error != nil {
                //print("error occurred pulling image from storage")
            } else {
                cell.posterImageView.image = UIImage(data: data!)
            }
        }
        
        return cell
    }


}
