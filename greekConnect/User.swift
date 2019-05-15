//
//  User.swift
//  greekConnect
//
//  Created by Rohith Kasar on 5/15/19.
//  Copyright © 2019 rohith.kasar. All rights reserved.
//

import Foundation

class User {
    //MARK:-properties
    
    private var _id: String
    private var _email : String
    private var _org : String
    private var _name : String
    
    
    var name : String {
        return _name
    }
    
    var id : String {
        return _id
    }
    
    var email : String {
        return _email
    }
    
    var org : String {
        return _org
    }
    
    
    
    
    init(name: String, id: String, org: String, email: String) {
        self._name = name
        self._id = id;
        self._org = org;
        self._email = email;
        
    }
    
}
