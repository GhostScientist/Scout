//
//  SecondViewController.swift
//  Scout
//
//  Created by Dakota Kim on 9/23/18.
//  Copyright © 2018 theghost. All rights reserved.
//

import UIKit

class SearchViewController: UIViewController, UITextFieldDelegate {
    
    // Users will be able to search based on tags.
    // For example, if they lived on the North Shore of MA and searched for
    // #spooky then they might be presented with the Willows or the Hawthorne hotel.
    
    // MARK: - IB Outlets
    // TODO: - Get TextField to dismiss when return is tapped; App 
    @IBOutlet weak var searchTextField: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()
        searchTextField.delegate = self
        // Do any additional setup after loading the view, typically from a nib.
        self.tapToHideKeyboard()
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }
}


