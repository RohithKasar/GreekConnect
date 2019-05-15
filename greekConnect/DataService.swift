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
    
    var REF_EVENTS: DatabaseReference {
        return _REF_EVENTS
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
                let poster = event.childSnapshot(forPath: "poster").value as! String
                let time = event.childSnapshot(forPath: "time").value as! String
                let name = event.childSnapshot(forPath: "name").value as! String
                
                let event : Event = Event(name: name, location: location, time: time, description: description, posterUid: poster)
                eventsArray.append(event)
                
            }
            
            handler(eventsArray)
        }
    }
    
    func pushEvent(name : String, location: String, time: String,
                           description: String, posterUid: String, uploadComplete: @escaping (_ status: Bool) -> ()) {
        let eventData : [String: Any?] = ["name" : name, "location" : location, "time": time, "description": description, "poster": posterUid]
        
        REF_EVENTS.childByAutoId().updateChildValues(eventData)
        uploadComplete(true)
    }
    
}
