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
    var photosURL: [String]
}
