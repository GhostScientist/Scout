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
    var coordinate: CLLocationCoordinate2D
    var title: String?
    
    init(coordinate: CLLocationCoordinate2D, title: String?) {
        self.coordinate = coordinate
        self.title = title
        super.init()  // initialise super class
    }
        
    var region: MKCoordinateRegion {
        let span = MKCoordinateSpan(latitudeDelta: 1.0, longitudeDelta: 1.0)  // 1 degree is approx 111kms
        return MKCoordinateRegion(center: coordinate, span: span)
    }
        
    }

class MapViewController: UIViewController, CLLocationManagerDelegate {
    
    // Properties
    
    var locationManager = CLLocationManager()
    var userLocation: CLLocation?
    
    // MARK: - IB Outlet
    
    @IBOutlet weak var mapView: MKMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        locationManager.requestWhenInUseAuthorization()
        locationManager.delegate = self
        userLocation = locationManager.location
        let currentCoordinate = CLLocationCoordinate2D(latitude: userLocation!.coordinate.latitude, longitude: userLocation!.coordinate.longitude)
        let locationAnnotation = cityAnnotation(coordinate: currentCoordinate, title: "Current Location")
        mapView.addAnnotation(locationAnnotation)
        mapView.setRegion(locationAnnotation.region, animated: true)
    }
    
    var loginPresented = false
    
    override func viewDidAppear(_ animated: Bool) {
//        if !loginPresented {
//            let vc = storyboard?.instantiateViewController(withIdentifier: "Onboarding") as! OnboardViewController
//            loginPresented = true
//            present(vc, animated: true)
//        }
    }


}

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
