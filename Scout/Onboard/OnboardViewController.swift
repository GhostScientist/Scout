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
            e.textColor = UIColor.white
        let placeholder = NSAttributedString(string: "email", attributes: [NSAttributedString.Key.foregroundColor: UIColor.white])
            e.attributedPlaceholder = placeholder
        return e
    }()
    
    let passwordTextField: UITextField = {
        let p = UITextField()
        let placeholder = NSAttributedString(string: "password", attributes: [NSAttributedString.Key.foregroundColor: UIColor.white])
            p.attributedPlaceholder = placeholder
            p.backgroundColor = UIColor(red: 173/255, green: 207/255, blue: 96/255, alpha: 1)
            p.textColor = UIColor.white
            p.isSecureTextEntry = true
        return p
    }()
    
    let loginButton: UIButton = {
        let l = UIButton(type: UIButton.ButtonType.system)
            l.setTitleColor(UIColor.white, for: .normal)
            l.setTitle("Login", for: .normal)
            l.backgroundColor = UIColor(red: 125/255, green: 188/255, blue: 96/255, alpha: 1)
        return l
    }()
    
    let icon: UIImageView = {
        let i = UIImageView()
        i.contentMode = .scaleAspectFill
        i.layer.masksToBounds = true
        i.image = UIImage(named: "scout")
        return i
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
        h.addTarget(self, action: #selector(presentRegistration), for: .touchUpInside)
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
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setupTextFieldComponents()
        self.navigationController?.navigationBar.backIndicatorImage = UIImage()
        //self.navigationBar.shadowImage = UIImage()
    }
    
    @objc func presentRegistration() {
        // FIX: - Fix Onboarding presentation. I want transparent navigation bars.
        
        let signupController = RegistrationViewController()
        self.navigationController?.pushViewController(signupController, animated: true)
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
        setupIcon()
    }
    
    fileprivate func setupEmailField() {
        view.addSubview(emailTextField)
        emailTextField.anchors(top: nil, topPad: 0, bottom: nil, bottomPad: 0, left: view.leftAnchor, leftPad: 24, right: view.rightAnchor, rightPad: 24, height: 30, width: 0)
        emailTextField.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
    }
    
    fileprivate func setupPasswordField() {
        view.addSubview(passwordTextField)
        passwordTextField.anchors(top: emailTextField.bottomAnchor, topPad: 8, bottom: nil, bottomPad: 0, left: emailTextField.leftAnchor, leftPad: 0, right: emailTextField.rightAnchor, rightPad: 0, height: 30, width: 0)
    }
    
    fileprivate func setupLoginButton() {
        view.addSubview(loginButton)
        loginButton.anchors(top: passwordTextField.bottomAnchor, topPad: 8, bottom: nil, bottomPad: 0, left: passwordTextField.leftAnchor, leftPad: 0, right: passwordTextField.rightAnchor, rightPad: 0, height: 50, width: 0)
        loginButton.addTarget(self, action: #selector(loginTapped), for: .touchUpInside)
    }
    
    fileprivate func setupHaveAccountButton() {
        view.addSubview(haveAccountButton)
        haveAccountButton.anchors(top: nil, topPad: 0, bottom: view.safeAreaLayoutGuide.bottomAnchor, bottomPad: 8, left: view.leftAnchor, leftPad: 12, right: view.rightAnchor, rightPad: 12, height: 30, width: 0)
    }
    
    func setupForgotPasswordButton() {
        view.addSubview(forgotPassword)
        forgotPassword.anchors(top: loginButton.bottomAnchor, topPad: 8, bottom: nil, bottomPad: 0, left: loginButton.leftAnchor, leftPad: 0, right: loginButton
            .rightAnchor, rightPad: 0, height: 30, width: 0)
    }
    
    func setupIcon() {
        view.addSubview(icon)
        icon.anchors(top: view.safeAreaLayoutGuide.topAnchor, topPad: 30, bottom: emailTextField.topAnchor, bottomPad: 30, left: view.leftAnchor, leftPad: 30, right: view.rightAnchor, rightPad: 30, height: 40, width: 40)
        
    }
    
    @objc func loginTapped() {
        let email = emailTextField.text!
        let password = passwordTextField.text!
        // TODO: - Check Passwords with Helper.check methods.
        Networker.shared.createUserWith(email: email, password: password) {
            // Completion handler to do stuff after the user is logged in.
        }
        
        // Handle errors related to registration.
    }
    
}
