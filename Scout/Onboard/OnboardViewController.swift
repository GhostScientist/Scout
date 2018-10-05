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
    let emailTextField: UITextField = {
        let e = UITextField()
            e.backgroundColor = UIColor(red: 173/255, green: 207/255, blue: 96/255, alpha: 1)
        let placeholder = NSAttributedString(string: "email", attributes: [NSAttributedString.Key.foregroundColor: UIColor.white])
            e.attributedPlaceholder = placeholder
        return e
    }()
    
    let passwordTextField: UITextField = {
        let p = UITextField()
        let placeholder = NSAttributedString(string: "password", attributes: [NSAttributedString.Key.foregroundColor: UIColor.white])
            p.attributedPlaceholder = placeholder
            p.backgroundColor = UIColor(red: 173/255, green: 207/255, blue: 96/255, alpha: 1)
        return p
    }()
    
    let loginButton: UIButton = {
        let l = UIButton(type: UIButton.ButtonType.system)
            l.setTitleColor(UIColor.white, for: .normal)
            l.setTitle("Login", for: .normal)
            l.backgroundColor = UIColor.purple
        return l
    }()
    
    let haveAccountButton: UIButton = {
        let color = UIColor(red: 180/255, green: 150/255, blue: 120/255, alpha: 1)
        let font = UIFont.systemFont(ofSize: 16.0)
        let h = UIButton(type: UIButton.ButtonType.system)
        h.backgroundColor = UIColor(red: 173/255, green: 207/255, blue: 96/255, alpha: 1)
        let attributedString = NSMutableAttributedString(string: "Don't have an account? ", attributes: [NSMutableAttributedString.Key.foregroundColor: color, NSAttributedString.Key.font: font])
            h.setAttributedTitle(attributedString, for: .normal)
            h.setTitleColor(UIColor.white, for: .normal)
        attributedString.append(NSAttributedString(string: "Sign up", attributes: [NSAttributedString.Key.foregroundColor: UIColor.white, NSAttributedString.Key.font: font]))
        return h
    }()
    
    let forgotPassword: UIButton = {
        let f = UIButton(type: UIButton.ButtonType.system)
        let color = UIColor(red: 173/255, green: 207/255, blue: 96/255, alpha: 1)
        f.setTitleColor(UIColor.white, for: .normal)
        f.setTitle("Forgot Password?", for: .normal)
        f.backgroundColor = color
        return f
    }()
    
    // This will be a view inspired by Glassdoor's onboarding
    // forms for new/returning users. It will have a rounded card
    // with text fields on it and a button to swap between logging in
    // and registering. When swapping, the card will flip with a smooth
    // animation.

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setupTextFieldComponents()
    }
    
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    
    // IB Action

    fileprivate func setupTextFieldComponents() {
        setupEmailField()
        setupPasswordField()
        setupLoginButton()
        setupHaveAccountButton()
        setupForgotPasswordButton()
    }
    
    fileprivate func setupEmailField() {
        view.addSubview(emailTextField)
        
        emailTextField.translatesAutoresizingMaskIntoConstraints = false
        
        emailTextField.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor, constant: 24.0).isActive = true
        emailTextField.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor, constant: -24.0).isActive = true
        emailTextField.heightAnchor.constraint(equalToConstant: 30).isActive = true
        emailTextField.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
    }
    
    fileprivate func setupPasswordField() {
        setupConstraints(newView: passwordTextField, relativeTo: emailTextField)
    }
    
    fileprivate func setupLoginButton() {
        setupConstraints(newView: loginButton, relativeTo: passwordTextField)
    }
    
    fileprivate func setupHaveAccountButton() {
        view.addSubview(haveAccountButton)
        haveAccountButton.translatesAutoresizingMaskIntoConstraints = false
        haveAccountButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -24.0).isActive = true
        haveAccountButton.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -12).isActive = true
        haveAccountButton.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 12).isActive = true
        haveAccountButton.heightAnchor.constraint(equalToConstant: 30).isActive = true
    }
    
    func setupConstraints(newView: UIView, relativeTo: UIView) {
        view.addSubview(newView)
        newView.translatesAutoresizingMaskIntoConstraints = false
        newView.topAnchor.constraint(equalTo: relativeTo.bottomAnchor, constant: 8).isActive = true
        newView.rightAnchor.constraint(equalTo: relativeTo.rightAnchor, constant: 0).isActive = true
        newView.leftAnchor.constraint(equalTo: relativeTo.leftAnchor, constant: 0).isActive = true
        newView.heightAnchor.constraint(equalToConstant: 30).isActive = true
    }
    
    func setupForgotPasswordButton() {
        view.addSubview(forgotPassword)
        forgotPassword.translatesAutoresizingMaskIntoConstraints = false
        forgotPassword.topAnchor.constraint(equalTo: loginButton.bottomAnchor, constant: 8.0).isActive = true
        forgotPassword.leftAnchor.constraint(equalTo: loginButton.leftAnchor, constant: 0).isActive = true
        forgotPassword.rightAnchor.constraint(equalTo: loginButton.rightAnchor, constant: 0).isActive = true
        forgotPassword.heightAnchor.constraint(equalToConstant: 30).isActive = true
    }
    
}
