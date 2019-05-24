//
//  Event.swift
//  greekConnect
//
//  Created by Rohith Kasar on 5/6/19.
//  Copyright © 2019 rohith.kasar. All rights reserved.
//

import Foundation

class Event {
    //MARK:-properties
    private var _name : String
    private var _location : String
    private var _time : String
    private var _description : String
    private var _poster : String
//    private var _going : String
//    private var _interested : String
//    private var _notGoing : String
    
    
    var name : String {
        return _name
    }
    
    var location : String {
        return _location
    }
    
    var time : String {
        return _time
    }
    
    var description : String {
        return _description
    }
    
    var poster : String {
        return _poster
    }
    
//    var going : String {
//        return _going
//    }
//
//    var interested : String {
//        return _interested
//    }
//
//    var notGoing : String {
//        return _notGoing
//    }
    
    
    
    
    init(name: String, location: String, time: String, description: String, poster: String) {
        //, going: String, interested: String, notGoing: String) {
        self._description = description
        self._location = location
        self._time = time
        self._name = name
        self._poster = poster
//        self._going = going
//        self._interested = interested
//        self._notGoing = notGoing
    }
    
}
