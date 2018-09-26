//
//  OnboardViewController.swift
//  Scout
//
//  Created by Dakota Kim on 9/26/18.
//  Copyright © 2018 theghost. All rights reserved.
//

import UIKit

class OnboardViewController: UIViewController {
    
    // This will be a view inspired by Glassdoor's onboarding
    // forms for new/returning users. It will have a rounded card
    // with text fields on it and a button to swap between logging in
    // and registering. When swapping, the card will flip with a smooth
    // animation.

    override func viewDidLoad() {
        super.viewDidLoad()
        let newCard = CardView()
        newCard.center.x = view.center.x
        newCard.center.y = view.center.y
        view.addSubview(newCard)
        print("How's it going?")
        // Do any additional setup after loading the view.
    }
    
    
}
