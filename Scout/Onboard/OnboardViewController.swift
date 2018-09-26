//
//  OnboardViewController.swift
//  Scout
//
//  Created by Dakota Kim on 9/26/18.
//  Copyright © 2018 theghost. All rights reserved.
//

import UIKit

class OnboardViewController: UIViewController {
    
    // IB Outlet
    @IBOutlet weak var buttonOutlet: UIButton!
    
    var isLogin = true // Default card will be login.
    
    // This will be a view inspired by Glassdoor's onboarding
    // forms for new/returning users. It will have a rounded card
    // with text fields on it and a button to swap between logging in
    // and registering. When swapping, the card will flip with a smooth
    // animation.

    override func viewDidLoad() {
        super.viewDidLoad()
        let cardView = CardView()
        print("How's it going?")
        // Do any additional setup after loading the view.
    }
    
    @objc func flipCard() {
        print("Man's not hot.")
    }
    
    // IB Action
    @IBAction func flipCard(_ sender: UIButton) {
        if isLogin {
            isLogin = false
            let image = UIImage(named: "button")
            buttonOutlet.setImage(image, for: .normal)
            UIView.transition(with: buttonOutlet, duration: 0.3, options: .transitionFlipFromLeft, animations: nil, completion: nil)
        } else {
            isLogin = true
            let image = UIImage(named: "button2")
            buttonOutlet.setImage(image, for: .normal)
            UIView.transition(with: buttonOutlet, duration: 0.3, options: .transitionFlipFromRight, animations: nil, completion: nil)
        }
    }
    
    @IBAction func dismissTapped(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
}
