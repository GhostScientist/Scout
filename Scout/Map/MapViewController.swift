//
//  FirstViewController.swift
//  Scout
//
//  Created by Dakota Kim on 9/23/18.
//  Copyright © 2018 theghost. All rights reserved.
//

import UIKit
import MapKit

class MapViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
    }
    
    var loginPresented = false
    
    override func viewDidAppear(_ animated: Bool) {
        if !loginPresented {
            let vc = storyboard?.instantiateViewController(withIdentifier: "Onboarding") as! OnboardViewController
            loginPresented = true
            present(vc, animated: true)
        }
    }


}

