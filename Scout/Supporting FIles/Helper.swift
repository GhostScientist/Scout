//
//  Helper.swift
//  Scout
//
//  Created by Dakota Kim on 9/26/18.
//  Copyright © 2018 theghost. All rights reserved.
//

import UIKit

// Temporary files to populate the collection view.

func generateRandomData() -> [[UIColor]] {
    let numberOfRows = 20
    let numberOfItemsPerRow = 15
    
    return (0..<numberOfRows).map { _ in
        return (0..<numberOfItemsPerRow).map { _ in UIColor.randomColor() }
    }
}

// TODO: - Implement validity checks

func checkValidEmail(email: String) -> Bool {
    if email.contains("@") && email.contains(".") && email.count > 5 {
        return true
    }
    return false
}

func checkValidPassword(password: String) -> Bool {
    if password.count > 8 {
        return true
    }
    return false
}

extension UIColor {
    
    class func randomColor() -> UIColor {
        
        let hue = CGFloat(arc4random() % 100) / 100
        let saturation = CGFloat(arc4random() % 100) / 100
        let brightness = CGFloat(arc4random() % 100) / 100
        
        return UIColor(hue: hue, saturation: saturation, brightness: brightness, alpha: 1.0)
    }
    
    static func rgb(r: CGFloat, g: CGFloat, b: CGFloat) -> UIColor {
        return UIColor(displayP3Red: r / 255, green: g / 255, blue: b / 255, alpha: 1.0)
    }
}

extension UITextField {
    func setBottomBorder(backgroundColor: UIColor, borderColor: UIColor) {
        self.layer.backgroundColor = backgroundColor.cgColor
        self.layer.shadowOffset = CGSize(width: 0.0, height: 1.0)
        self.layer.shadowOpacity = 1.0
        self.layer.shadowRadius = 0.0
        self.layer.shadowColor = borderColor.cgColor
    }
}

extension UIViewController {
    func tapToHideKeyboard() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKey))
        tap.cancelsTouchesInView = false
        self.view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKey() {
        view.endEditing(true)
    }
}

