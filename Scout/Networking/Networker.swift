//
//  Networking.swift
//  Scout
//
//  Created by Dakota Kim on 9/23/18.
//  Copyright © 2018 theghost. All rights reserved.
//

import Foundation
import Firebase

final class Networker {
    // Using the Singleton design pattern for the Networker.
    static let shared = Networker()
    let database = Firestore.firestore()
    // Test to see if Git works properly now.
    
    func postToFirebase(_ spot: Spot) {
        
    }
    
    func deleteFromFirebase(_ spot: Spot) {
        
    }
    
    func getFromFirebase(_ spot: Spot) {
        
    }
    
    func updateDataFor(_ spot: Spot) {
        
    }
    
    func grabContributedPhotosFor(_ userID: String) {
        
    }
    
    func getSavedPhotosFor(_ userID: String) {
        
    }
}
