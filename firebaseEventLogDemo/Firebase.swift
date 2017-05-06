//
//  Firebase.swift
//  firebaseEventLogDemo
//
//  Created by Stanley Chiang on 5/6/17.
//  Copyright © 2017 Stanley Chiang. All rights reserved.
//

import Foundation
import Firebase

class Firebase {
    static let shared = Firebase()
    fileprivate init() {}
    
    let refDocument = FIRDatabase.database().reference().child("documents")
    
    func createDocument(name: String) {
        
    }
    
    func updateDocument(event:AnyObject) {
    
    }
    
}
