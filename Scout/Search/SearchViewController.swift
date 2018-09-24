//
//  SecondViewController.swift
//  Scout
//
//  Created by Dakota Kim on 9/23/18.
//  Copyright © 2018 theghost. All rights reserved.
//

import UIKit

class SearchViewController: UIViewController, UITextFieldDelegate {
    
    // MARK: - IB Outlets
    @IBOutlet weak var searchTextField: UITextField!
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.hideKeyboardWhenTappedAround()
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.dismissKeyboard()
        return true
    }
}

extension UIViewController {
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        view.addGestureRecognizer(tap)
        
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}

