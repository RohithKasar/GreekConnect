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
                let privacy = event.childSnapshot(forPath: "isPrivate").value as! String
                let eventId = event.childSnapshot(forPath: "eventId").value as! String
                var isPrivate = false
                if (privacy == "true1") {
                    //print(name)
                    isPrivate = true
                }
                

                let event : Event = Event(name: name, location: location, time: time, description: description, poster: poster,
                                          isPrivate: isPrivate, eventId: eventId)

                eventsArray.append(event)
        
                
            }
            
            handler(eventsArray)
        }
    }
    
    func pushEvent(name : String, location: String, time: String,
                   description: String, id: String, uploadComplete: @escaping (_ status: Bool) -> ()) {

    
        

            
        let eventId = REF_EVENTS.childByAutoId()
        let sexyId = eventId.description().dropFirst(49)
        
        let eventData : [String: Any?] = ["name" : name, "location" : location, "time": time, "description": description,
                                          "poster": id, "isPrivate": "false1", "eventId": sexyId ]
        eventId.updateChildValues(eventData as [AnyHashable : Any])
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
    
    func pushExchange(name: String, location: String, time: String, description: String, id: String, recipient: String,
                      uploadComplete: @escaping (_ status: Bool) -> ()) {
        
        let autoId = REF_EVENTS.childByAutoId()
        
        
        let sexyId = autoId.description().dropFirst(49)
        
        let eventData : [String: Any?] = ["name" : name, "location" : location, "time": time, "description": description, "poster": id, "isPrivate": "true1", "eventId":sexyId]
        
        autoId.updateChildValues(eventData as [AnyHashable : Any])
        REF_USER.child(recipient).child("personalEvents").updateChildValues([String(sexyId) : name])
        uploadComplete(true)
    }
    
    func fetchOrgs(handler: @escaping ( _ events: [Organization]) -> ()) {
        var orgArray = [Organization]()
        REF_ORGS.observeSingleEvent(of: .value) { (allOrgsSnapshot) in
            guard let allOrgsSnapshot = allOrgsSnapshot.children.allObjects as? [DataSnapshot] else { return }
            
            //loop through all orgs
            for org in allOrgsSnapshot {
                
                let name = org.childSnapshot(forPath: "name").value as! String
                var memberDict = [String:String]()
                
                // i only want the ids here
                memberDict = org.childSnapshot(forPath: "members").value as! [String:String]
                let members = Array(memberDict.keys)
                
                //let members = array of all user IDs
                
                let org : Organization = Organization(name: name, memberIds: members)
                
                
                orgArray.append(org)
                //print(orgArray.count)
            }
            
            handler(orgArray)
        }
        //at this point orgArray contains what we want which makes absolutely no sense
    }
    
    
    
    func fetchPrivateEvents(forUser userId : String, handler: @escaping (_ privateEvents: [String]) -> ()) {
        var eventIds = [String]()
        REF_USER.observeSingleEvent(of: .value) { (allUsersSnapshot) in
            guard let allUsersSnapshot = allUsersSnapshot.children.allObjects as? [DataSnapshot] else {return }
            for user in allUsersSnapshot {
                let id = user.childSnapshot(forPath: "id").value as! String
                if (id == userId) {
                    let memberDict = user.childSnapshot(forPath: "personalEvents").value as! [String:String]
                    eventIds = Array(memberDict.keys)
                }
            }
            
            //eventIds has what i want
            handler(eventIds)
        }
    }
    
    /*func getIds (forOrg paramOrg : String, handler: @escaping ( _ uidArray: [String]) -> ()) {
        REF_ORGS.observeSingleEvent(of: .value) { (orgSnapshot) in
            var idArray = [String]()
            guard let orgSnapshot = orgSnapshot.children.allObjects as? [DataSnapshot] else {return}
            for org in orgSnapshot {
                //let membersSnapshot = org.childSnapshot(forPath: "members") as? [DataSnapshot]
                //extract name from this org
                let name = org.childSnapshot(forPath: "name").value as! String
                if (name == paramOrg) {
                    idArray = org.childSnapshot(forPath: "members").value as! [String]
                }
            }
            handler(idArray)
        }
    }*/
    
    func pushUser(name : String, email : String, id : String,
                  uploadComplete: @escaping (_ status: Bool) -> ()) {
        let userData : [String: Any?] = ["name": name, "email":email, "id":id, "org":"temp", "personalEvents" : ["hib":"hob"]]
        
        REF_USER.child(id).updateChildValues(userData as [AnyHashable : Any])
        uploadComplete(true)
        
    }
    
}
