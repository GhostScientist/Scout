//
//  Spot.swift
//  Scout
//
//  Created by Dakota Kim on 9/26/18.
//  Copyright © 2018 theghost. All rights reserved.
//

import UIKit
import CoreLocation

struct Spot {
    var locationName: String
    var description: String
    var tags: [String]
    var lat: CLLocationDegrees
    var long: CLLocationDegrees
    var photoURL: String
    
    init(firebaseDictionary: [String:Any]) {
        self.locationName = firebaseDictionary["location"] as! String
        self.description = firebaseDictionary["description"] as! String
        self.tags = firebaseDictionary["tags"] as! [String]
        self.lat = firebaseDictionary["lat"] as! CLLocationDegrees
        self.long = firebaseDictionary["long"] as! CLLocationDegrees
        self.photoURL = firebaseDictionary["photosURL"] as! String
    }
    
    init(locationName: String, description: String, tags: [String], lat: CLLocationDegrees, long: CLLocationDegrees, photosURL: String) {
        self.locationName = locationName
        self.description = description
        self.tags = tags
        self.lat = lat
        self.long = long
        self.photoURL = photosURL
    }
}
