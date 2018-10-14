//
//  FirstViewController.swift
//  Scout
//
//  Created by Dakota Kim on 9/23/18.
//  Copyright © 2018 theghost. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

final class cityAnnotation: NSObject, MKAnnotation {
    
    // The cityAnnotation class is
    var coordinate: CLLocationCoordinate2D
    var title: String?
    
    init(coordinate: CLLocationCoordinate2D, title: String?) {
        self.coordinate = coordinate
        self.title = title
        super.init()  // initialise super class
    }
        
    var region: MKCoordinateRegion {
        // Computed Property
        let span = MKCoordinateSpan(latitudeDelta: 1.0, longitudeDelta: 1.0)  // 1 degree is approx 111kms
        // The above span is 1 degree difference in lat and long. I only want values within this range.
        // The user could scroll around the map to find places further away.
        return MKCoordinateRegion(center: coordinate, span: span)
    }
}

class MapViewController: UIViewController, CLLocationManagerDelegate {
    
    
    // The MapViewController will pull all public entries from Firebase.
    // V1 will be very inefficient, but that's okay because I don't expect many users at first.
    // Unless I can figure out the math to grab only the values within a certain radius.
    // 1 degree in lat/long is about 69 miles.
    // So should I save them under their Lat/Long in firebase? A collection for each digit?
    // Properties
    
    var locationManager = CLLocationManager()
    var userLocation: CLLocation?
    
    // MARK: - IB Outlet
    
    @IBOutlet weak var mapView: MKMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        DispatchQueue.main.async {
            // Serial Queue to prevent race condition.
            self.locationManager.requestWhenInUseAuthorization() // completion handler with success would be better.
            self.setUpLocationServices()
        }
    }
    
    func setUpLocationServices() {
        // This will run only after the user has granted access.
        locationManager.delegate = self
        userLocation = locationManager.location
        let currentCoordinate = CLLocationCoordinate2D(latitude: userLocation!.coordinate.latitude, longitude: userLocation!.coordinate.longitude)
        let locationAnnotation = cityAnnotation(coordinate: currentCoordinate, title: "Current Location")
        mapView.addAnnotation(locationAnnotation)
        mapView.setRegion(locationAnnotation.region, animated: true)
        mapView.isScrollEnabled = false
    }
    
    var loginPresented = false
    // TODO: - How to create a persistent login state. UserDefaults?
    
    
}

// Superfluous extension?

extension MapViewController: MKMapViewDelegate {
    func Map(_ Map: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        if let cityAnnotation = Map.dequeueReusableAnnotationView(withIdentifier: MKMapViewDefaultAnnotationViewReuseIdentifier) as? MKMarkerAnnotationView {
            cityAnnotation.animatesWhenAdded = true
            cityAnnotation.titleVisibility = .adaptive
            cityAnnotation.subtitleVisibility = .adaptive
            
            return cityAnnotation
        }
        return nil
    }
}
