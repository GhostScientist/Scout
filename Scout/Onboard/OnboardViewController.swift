//
//  OnboardViewController.swift
//  Scout
//
//  Created by Dakota Kim on 9/26/18.
//  Copyright © 2018 theghost. All rights reserved.
//

import UIKit
import Firebase

class OnboardViewController: UIViewController, UITextFieldDelegate {
    
    // IB Outlets
    let emailTextField: UITextField = {
        let e = UITextField()
            e.setBottomBorder(backgroundColor: UIColor.rgb(r: 173, g: 207, b: 96), borderColor: UIColor.white)
            e.backgroundColor = UIColor.rgb(r: 173, g: 207, b: 96)
            e.textColor = UIColor.white
        let placeholder = NSAttributedString(string: "email", attributes: [NSAttributedString.Key.foregroundColor: UIColor.white])
            e.attributedPlaceholder = placeholder
        let imageView = UIImageView(image: UIImage(named: "email"))
            imageView.transform = CGAffineTransform(scaleX: 0.75, y: 0.75)
            e.leftView = imageView
            e.leftViewMode = .unlessEditing
            e.keyboardType = .emailAddress
        return e
    }()
    
    let passwordTextField: UITextField = {
        let p = UITextField()
        let placeholder = NSAttributedString(string: "password", attributes: [NSAttributedString.Key.foregroundColor: UIColor.white])
            p.attributedPlaceholder = placeholder
            p.setBottomBorder(backgroundColor: UIColor.rgb(r: 173, g: 207, b: 96), borderColor: UIColor.white)
            p.textColor = UIColor.white
            p.isSecureTextEntry = true
        let imageView = UIImageView(image: UIImage(named: "lock"))
            imageView.transform = CGAffineTransform(scaleX: 0.75, y: 0.75)
            p.leftView = imageView
            p.leftViewMode = .unlessEditing

        return p
    }()
    
    let loginButton: UIButton = {
        let l = UIButton(type: UIButton.ButtonType.system)
            l.setTitleColor(UIColor.white, for: .normal)
            l.setTitle("Login", for: .normal)
            l.backgroundColor = UIColor(red: 125/255, green: 188/255, blue: 96/255, alpha: 1)
            l.layer.cornerRadius = 10
        return l
    }()
    
//    let icon: UIImageView = {
//        let i = UIImageView()
//        i.contentMode = .scaleAspectFill
//        i.layer.masksToBounds = true
//        i.image = UIImage(named: "scout")
//        return i
//    }()
    
    let haveAccountButton: UIButton = {
        let color = UIColor(red: 180/255, green: 150/255, blue: 120/255, alpha: 1)
        let font = UIFont.systemFont(ofSize: 16.0)
        let h = UIButton(type: UIButton.ButtonType.system)
        h.backgroundColor = UIColor.rgb(r: 173, g: 207, b: 96)
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
        self.tapToHideKeyboard()
        view.backgroundColor = UIColor.rgb(r: 173, g: 207, b: 96)
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.shadowImage = UIImage()
        setupTextFieldComponents()
    }

    
    @objc func presentRegistration() {
        // FIX: - Fix Onboarding presentation.
        
        let signupController = RegistrationViewController()
        navigationController?.pushViewController(signupController, animated: true)
    }
    
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    
    // UI Setup Functions

    fileprivate func setupTextFieldComponents() {
        setupEmailField()
        setupPasswordField()
        setupLoginButton()
        setupHaveAccountButton()
        setupForgotPasswordButton()
        //setupIcon()
    }
    
    fileprivate func setupEmailField() {
        view.addSubview(emailTextField)
        emailTextField.delegate = self
        emailTextField.anchors(top: nil, topPad: 0, bottom: nil, bottomPad: 0, left: view.leftAnchor, leftPad: 24, right: view.rightAnchor, rightPad: 24, height: 30, width: 0)
        emailTextField.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -50).isActive = true
    }
    
    fileprivate func setupPasswordField() {
        view.addSubview(passwordTextField)
        passwordTextField.delegate = self
        passwordTextField.anchors(top: emailTextField.bottomAnchor, topPad: 8, bottom: nil, bottomPad: 0, left: emailTextField.leftAnchor, leftPad: 0, right: emailTextField.rightAnchor, rightPad: 0, height: 30, width: 0)
    }
    
    fileprivate func setupLoginButton() {
        view.addSubview(loginButton)
        loginButton.anchors(top: passwordTextField.bottomAnchor, topPad: 12, bottom: nil, bottomPad: 0, left: passwordTextField.leftAnchor, leftPad: 0, right: passwordTextField.rightAnchor, rightPad: 0, height: 50, width: 0)
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
        //view.addSubview(icon)
        //icon.anchors(top: view.safeAreaLayoutGuide.topAnchor, topPad: 30, bottom: emailTextField.topAnchor, bottomPad: 30, left: view.leftAnchor, leftPad: 30, right: view.rightAnchor, rightPad: 30, height: 40, width: 40)
        
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == emailTextField {
            passwordTextField.becomeFirstResponder()
        } else if textField == passwordTextField {
            self.view.endEditing(true)
        }
        return false
    }
    
    @objc func loginTapped() {
        print("Current user is \(Auth.auth().currentUser?.email) with UID of \(Auth.auth().currentUser?.uid)")
        if let email = emailTextField.text, let password = passwordTextField.text {
            if checkValidPassword(password: password) && checkValidEmail(email: email) {
                Auth.auth().signIn(withEmail: email, password: password) { (result, error) in
                    if error != nil {
                        print("There was an error logging in. Please try again! Error: \(error?.localizedDescription)")
                    } else {
                        let appDelegate = UIApplication.shared.delegate as! AppDelegate
                        let mainStoryboard = UIStoryboard(name: "Main", bundle: nil)
                        let mapsVC = mainStoryboard.instantiateViewController(withIdentifier: "tabBar")
                        appDelegate.window = UIWindow(frame: UIScreen.main.bounds)
                        appDelegate.window?.makeKeyAndVisible()
                        appDelegate.window?.rootViewController = mapsVC
                    }
                }
            }
        }
//        let email = emailTextField.text!
//        let password = passwordTextField.text!
//        // TODO: - Check Passwords with Helper.check methods.
//        Networker.shared.createUserWith(email: email, password: password) {
//            // Completion handler to do stuff after the user is logged in.
//        }
        
        // Handle errors related to registration.
    }
    
    
}
