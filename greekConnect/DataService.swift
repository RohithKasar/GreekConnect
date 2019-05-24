//
//  DataService.swift
//  greekConnect
//
//  Created by Rohith Kasar on 5/9/19.
//  Copyright © 2019 rohith.kasar. All rights reserved.
//

import Foundation
import Firebase


let DB_BASE = Database.database().reference()

class DataService {
    
    static let instance = DataService()
    
    private var _REF_EVENTS = DB_BASE.child("events")
    private var _REF_USER = DB_BASE.child("Users")
    private var _REF_ORGS = DB_BASE.child("Organizations")
    
    var REF_EVENTS: DatabaseReference {
        return _REF_EVENTS
    }
    
    var REF_USER: DatabaseReference {
        return _REF_USER
    }
    
    var REF_ORGS : DatabaseReference {
        return _REF_ORGS
    }
    
    //API
    
    func fetchEvents(handler: @escaping ( _ events: [Event]) -> ()) {
        var eventsArray = [Event]()
        REF_EVENTS.observeSingleEvent(of: .value) { (allEventsSnapshot) in
            guard let allEventsSnapshot = allEventsSnapshot.children.allObjects as? [DataSnapshot] else { return }
            
            //loop through all events
            for event in allEventsSnapshot {
                let description = event.childSnapshot(forPath: "description").value as! String
                let location = event.childSnapshot(forPath: "location").value as! String
                let time = event.childSnapshot(forPath: "time").value as! String
                let name = event.childSnapshot(forPath: "name").value as! String
                let poster = event.childSnapshot(forPath: "poster").value as! String
//                let going = event.childSnapshot(forPath: "going").value as! String
//                let interested = event.childSnapshot(forPath: "interested").value as! String
//                let notGoing = event.childSnapshot(forPath: "notGoing").value as! String
                //let org = event.childSnapshot(forPath: "posterOrg").value as! String
                
                let event : Event = Event(name: name, location: location, time: time, description: description, poster: poster)
//                    ,
//                                          going: going, interested: interested, notGoing: notGoing)
                eventsArray.append(event)
                
            }
            
            handler(eventsArray)
        }
    }
    
    func pushEvent(name : String, location: String, time: String,
                   description: String, id: String, uploadComplete: @escaping (_ status: Bool) -> ()) {
//        , going: String,
//                   interested: String, notGoing: String, uploadComplete: @escaping (_ status: Bool) -> ()) {
    
        let eventData : [String: Any?] = ["name" : name, "location" : location, "time": time, "description": description, "poster": id]
//            , "going": going, "notGoing": notGoing, "interested": interested ]
            
            REF_EVENTS.childByAutoId().updateChildValues(eventData)
            uploadComplete(true)
    }
    
    func fetchUser(handler: @escaping ( _ events: [User]) -> ()) {
        var userArray = [User]()
        REF_USER.observeSingleEvent(of: .value) { (allUsersSnapshot) in
            guard let allUsersSnapshot = allUsersSnapshot.children.allObjects as? [DataSnapshot] else { return }
            
            //loop through all events
            for user in allUsersSnapshot {
                
                let email = user.childSnapshot(forPath: "email").value as! String
                let name = user.childSnapshot(forPath: "name").value as! String
                let id = user.childSnapshot(forPath: "id").value as! String
                let org = user.childSnapshot(forPath: "org").value as! String
                
                let user : User = User(name: name, id: id, org: org, email: email)
                userArray.append(user)
                
            }
            
            handler(userArray)
        }
    }
    
    /*func fetchOrgs(handler: @escaping ( _ events: [Organization]) -> ()) {
        var orgArray = [Organization]()
        REF_ORGS.observeSingleEvent(of: .value) { (allOrgsSnapshot) in
            guard let allOrgsSnapshot = allOrgsSnapshot.children.allObjects as? [DataSnapshot] else { return }
            
            //loop through all events
            for org in allOrgsSnapshot {
                
                let name = org.key
                
                let members = org.childSnapshot(forPath: "name") as! [String: String]
                
                let memberIds = Array(members.keys)
                
                
                let org : Organization = Organization(name: name, memberIds: memberIds)
                
                
                orgArray.append(org)
                
            }
            
            handler(orgArray)
        }
    }*/
    
    
    
    func pushUser(name : String, email : String, id : String,
                  org : String, uploadComplete: @escaping (_ status: Bool) -> ()) {
        let userData : [String: Any?] = ["name": name, "email":email, "id":id, "org":org]
        
        REF_USER.child(id).updateChildValues(userData)
        uploadComplete(true)
        
    }
    
}
