//
//  Networking.swift
//  Scout
//
//  Created by Dakota Kim on 9/23/18.
//  Copyright © 2018 theghost. All rights reserved.
//

import Foundation
import Firebase
import CoreLocation

final class Networker {
    // Using the Singleton design pattern for the Networker.
    static let shared = Networker()
    let database = Firestore.firestore()
    // Test to see if Git works properly now.
    
    // TODO: - Implement authentication
    
    // TODO: - Login
    
    // TODO: - Registration
    
    func postToPublicFirebase(_ spot: Spot) {
        database.collection("public").addDocument(data: [
            "locationName": spot.locationName,
            "description": spot.description,
            "tags": spot.tags,
            "lat": spot.lat,
            "long": spot.long,
            "photosURL": spot.photosURL
            ]) { err in
            if let err = err {
                print("Error writing document: \(err)")
            } else {
                print("Document successfully written!")
            }
        }
    }
    
    func deleteFromFirebase(_ spot: Spot) {
        
    }
    
    func getFromFirebase(_ spot: Spot) {
        
    }
    
    func updateDataFor(_ url: String) {
        let dummyRef = database.collection("Dummy").document("Test")
        dummyRef.updateData([
            "photosURL": [url]
        ]) { err in
            if let err = err {
                print("Error updating document: \(err)")
            } else {
                print("Document successfully updated")
            }
        }
    }
    
    func grabContributedPhotosFor(_ userID: String) {
        
    }
    
    func getSavedPhotosFor(_ userID: String) {
        
    }
    
    func pullPublicSpots() -> [Spot] {
        let spot = Spot(locationName: "Dummy", description: "Dummy", tags: ["Dummy"], lat: CLLocationDegrees(), long: CLLocationDegrees(), photosURL: "")
        
       
        
        database.collection("public").getDocuments { (querySnapshot, error) in
            if let err = error {
                print("Error retrieving public data: \(err)")
            } else {
                for document in querySnapshot!.documents {
                    print("\(document.documentID) => \(document.data())")
                }
            }
        }
        
        
        return [spot]
    }
    
}
