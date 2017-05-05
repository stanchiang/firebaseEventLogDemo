//
//  Document.swift
//  firebaseEventLogDemo
//
//  Created by Stanley Chiang on 5/4/17.
//  Copyright © 2017 Stanley Chiang. All rights reserved.
//

import Foundation
import Firebase

class Document {
    static let sharedInstance = Document()
    fileprivate init() {}
  
    let refDocument = FIRDatabase.database().reference().child("documents")
    
    func recordDocument(event:AnyObject) {
//        SEGAnalytics.shared().track(event.rawValue)
    }
    
}
