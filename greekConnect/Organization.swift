//
//  Organization.swift
//  greekConnect
//
//  Created by Rohith Kasar on 5/15/19.
//  Copyright © 2019 rohith.kasar. All rights reserved.
//


import Foundation

class Organization {
    //MARK:-properties
    
    private var _name : String
    private var _memberIds : [String]
    
    var memberIds : [String] {
        return _memberIds
    }
    var name : String {
        return _name
    }
    
    init (name : String, memberIds : [String]) {
        self._memberIds = memberIds
        self._name = name
    }
}
