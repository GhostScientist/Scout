//
//  RegistrationViewController.swift
//  Scout
//
//  Created by Dakota Kim on 10/11/18.
//  Copyright © 2018 theghost. All rights reserved.
//

import UIKit
import Firebase

class RegistrationViewController: UIViewController, UITextFieldDelegate {
    
    // TODO: - Tomorrow
    // 1. Rethink posting flow.
    // 2. Post Dummy data with user logged in.
    
    // Outlets
    let haveAccountButton: UIButton = {
        let color = UIColor.rgb(r: 173, g: 207, b: 96)
        let textColor = UIColor.rgb(r: 240, g: 215, b: 96)
        let font = UIFont.systemFont(ofSize: 16.0)
        let h = UIButton(type: UIButton.ButtonType.system)
        h.backgroundColor = color
        let attributedString = NSMutableAttributedString(string: "Already have an account? ", attributes: [NSMutableAttributedString.Key.foregroundColor: textColor, NSAttributedString.Key.font: font])
        h.setAttributedTitle(attributedString, for: .normal)
        h.setTitleColor(UIColor.white, for: .normal)
        attributedString.append(NSAttributedString(string: "Sign In", attributes: [NSAttributedString.Key.foregroundColor: UIColor.white, NSAttributedString.Key.font: font]))
        h.addTarget(self, action: #selector(presentSignIn), for: .touchUpInside)
        return h
    }()
    
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
    
    let confirmPasswordTextField: UITextField = {
        let p = UITextField()
        let placeholder = NSAttributedString(string: "confirm password", attributes: [NSAttributedString.Key.foregroundColor: UIColor.white])
        p.attributedPlaceholder = placeholder
        p.setBottomBorder(backgroundColor: UIColor.rgb(r: 173, g: 207, b: 96), borderColor: UIColor.white)
        p.textColor = UIColor.white
        p.isSecureTextEntry = true
        
        return p
    }()
    
    let signupButton: UIButton = {
        let s = UIButton(type: UIButton.ButtonType.system)
        s.setTitleColor(UIColor.white, for: .normal)
        s.setTitle("Sign Up", for: .normal)
        s.backgroundColor = UIColor(red: 125/255, green: 188/255, blue: 96/255, alpha: 1)
        s.layer.cornerRadius = 10
        s.addTarget(self, action: #selector(signupTapped), for: .touchUpInside)
        return s
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.tapToHideKeyboard()
        view.backgroundColor = UIColor.rgb(r: 173, g: 207, b: 96)
        setupUI()
        navigationController?.navigationBar.tintColor = UIColor.white
        // Do any additional setup after loading the view.
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    @objc func presentSignIn() {
        navigationController?.popViewController(animated: true)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == emailTextField {
            passwordTextField.becomeFirstResponder()
        } else if textField == passwordTextField {
            confirmPasswordTextField.becomeFirstResponder()
        } else if textField == confirmPasswordTextField {
            self.view.endEditing(true)
        }
        return false
    }
    
    func setupHaveAccountButton() {
        view.addSubview(haveAccountButton)
        haveAccountButton.anchors(top: nil, topPad: 0, bottom: view.safeAreaLayoutGuide.bottomAnchor, bottomPad: 8, left: view.leftAnchor, leftPad: 0, right: view.rightAnchor, rightPad: 0, height: 30, width: 0)
    }
    
    func setupUI() {
        setupEmailField()
        setupPassField()
        setupConfirmField()
        setupHaveAccountButton()
        setupSignUpButton()
    }
    
    func setupEmailField() {
        view.addSubview(emailTextField)
        emailTextField.delegate = self
        emailTextField.anchors(top: nil, topPad: 0, bottom: nil, bottomPad: 0, left: view.leftAnchor, leftPad: 24, right: view.rightAnchor, rightPad: 24, height: 30, width: 0)
        emailTextField.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -50).isActive = true
    }
    
    func setupPassField() {
        view.addSubview(passwordTextField)
        passwordTextField.delegate = self
        passwordTextField.anchors(top: emailTextField.bottomAnchor, topPad: 8, bottom: nil, bottomPad: 0, left: emailTextField.leftAnchor, leftPad: 0, right: emailTextField.rightAnchor, rightPad: 0, height: 30, width: 0)
    }
    
    func setupConfirmField() {
        view.addSubview(confirmPasswordTextField)
        confirmPasswordTextField.anchors(top: passwordTextField.bottomAnchor, topPad: 12, bottom: nil, bottomPad: 0, left: passwordTextField.leftAnchor, leftPad: 0, right: passwordTextField.rightAnchor, rightPad: 0, height: 30, width: 0)
    }
    
    func setupSignUpButton() {
        view.addSubview(signupButton)
        signupButton.anchors(top: confirmPasswordTextField.bottomAnchor, topPad: 8, bottom: nil, bottomPad: 0, left: confirmPasswordTextField.leftAnchor, leftPad: 0, right: confirmPasswordTextField.rightAnchor, rightPad: 0, height: 50, width: 0)
        signupButton.addTarget(self, action: #selector(signupTapped), for: .touchUpInside)
    }

    @objc func signupTapped() {
        if let email = emailTextField.text, let password = passwordTextField.text, let confirm = confirmPasswordTextField.text {
            if password == confirm && checkValidPassword(password: password) && checkValidEmail(email: email) {
                Auth.auth().createUser(withEmail: email, password: password) { (result, error) in
                    if error != nil {
                        print("There was an error creating your account. Please try again. Error: \(error?.localizedDescription)")
                    } else {
                        print("Success! User's information is: \(result?.user.email) \(result?.user.displayName) \(result?.user.uid)")
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
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
