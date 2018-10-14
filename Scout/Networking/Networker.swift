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
    var scoutUser: User!
    // Every user will have a user id. This is integral to working with the backend.
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
    
    func post(_ spot: Spot) {
        
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
    
    func createUserWith(email: String, password: String, completion: () -> ()) {
        if isValidEmail(email) && isValidPassword(password) {
            Auth.auth().createUser(withEmail: email, password: password) { (auth, error) in
                if error == nil {
                    // User was created. Present user with initial view.
                    // TODO: - Look into persistent state for authentication.
                } else {
                    print("There was an error during registration.")
                }
            }
        }
    }
    
    func loginWith(_ email: String, _ password: String) {
        Auth.auth().signIn(withEmail: email, password: password) { (result, error) in
            if result?.user != nil {
                Networker.shared.scoutUser = result?.user
            }
            // TODO: - Persistent Login: I want users to be able to delete the app
            // and if they reinstall it they are already logged in.
            }
        }
    
    func isValidEmail(_ email: String) -> Bool {
        if email.count > 5 && email.contains("@") && email.contains(".") {
            return true
        }
        else {
            return false
        }
    }
    
    func isValidPassword(_ password: String) -> Bool {
        if password.count > 6 {
            return true
        }
        else {
            return false
        }
    }
    
}
