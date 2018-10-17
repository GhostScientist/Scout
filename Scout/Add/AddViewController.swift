//
//  AddViewController.swift
//  Scout
//
//  Created by Dakota Kim on 9/23/18.
//  Copyright © 2018 theghost. All rights reserved.
//

import UIKit
import AVFoundation
import CoreLocation
import Firebase

class AddViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITextViewDelegate {
    
    // MARK: - IB Outlets
    
    @IBOutlet weak var imageView: UIImageView!
    
    
    let descriptionTextView : UITextView = {
        let t = UITextView()
        t.text = ""
        t.backgroundColor = UIColor.white
        t.layer.cornerRadius = 10.0
        t.layer.masksToBounds = true
        t.font = UIFont.systemFont(ofSize: 15.0)
        return t
    }()
    
    let postButton : UIButton = {
        let post = UIButton()
        post.setTitle("Post", for: .normal)
        post.titleLabel?.font = UIFont.boldSystemFont(ofSize: 24.0)
        post.setTitleColor(UIColor.black, for: .normal)
        post.backgroundColor = UIColor.white
        post.layer.masksToBounds = true
        post.addTarget(self, action: #selector(postTapped), for: .touchUpInside)
        return post
    }()
    
    // MARK: - Instance Variables
    var captureSession: AVCaptureSession?
    var videoPreviewLayer: AVCaptureVideoPreviewLayer?
    var capturePhotoOuput: AVCapturePhotoOutput?
    var locationManager = CLLocationManager()
    var userLocation: CLLocation?
    let imagePicker = UIImagePickerController()

    override func viewDidLoad() {
        super.viewDidLoad()
        imagePicker.delegate = self
        locationManager.delegate = self
        imageView.layer.cornerRadius = 10.0
        imageView.layer.masksToBounds = true
        descriptionTextView.delegate = self
        imageView.image = UIImage(named: "camera")
        
        capturePhotoOuput = AVCapturePhotoOutput()
        capturePhotoOuput?.isHighResolutionCaptureEnabled = true
        captureSession?.addOutput(capturePhotoOuput!)
        userLocation = locationManager.location
        setupUI()
        // Do any additional setup after loading the view.
    }
    
    func cameraSetup() {
        let captureDevice = AVCaptureDevice.default(for: AVMediaType.video)
        
        do {
            let input = try AVCaptureDeviceInput(device: captureDevice!)
            captureSession = AVCaptureSession()
            captureSession?.addInput(input)
        } catch {
            print(error)
        }
        
        videoPreviewLayer = AVCaptureVideoPreviewLayer(session: captureSession!)
        videoPreviewLayer?.videoGravity = AVLayerVideoGravity.resizeAspectFill
        videoPreviewLayer?.frame = view.layer.bounds
        imageView.layer.addSublayer(videoPreviewLayer!)
        
        captureSession?.startRunning()
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    
    
    func setupUI() {
        setupImageView()
        tapToSelectPhotographMethod()
    }

    
    
    func tapToSelectPhotographMethod() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(AddViewController.presentChoices))
        imageView.isUserInteractionEnabled = true
        imageView.addGestureRecognizer(tap)
    }
    
    
    @objc func presentChoices() {
        let ac = UIAlertController(title: "Post a Spot", message: nil, preferredStyle: .actionSheet)
        let choosePhotoAction = UIAlertAction(title: "Choose Photo", style: .default) { (action) in
            print("Choose Tapped.")
            self.imagePicker.allowsEditing = false
            self.imagePicker.sourceType = .photoLibrary
            self.imageView.layer.sublayers?.forEach {
                $0.removeFromSuperlayer()
            }
            self.present(self.imagePicker, animated: true)
            
        }
        let takePhotoAction = UIAlertAction(title: "Take Photo", style: .default) { (action) in
            print("Take Photo Tapped.")
            if UIImagePickerController.isSourceTypeAvailable(.camera) {
                self.imagePicker.sourceType = .camera
                self.present(self.imagePicker, animated: true)
            }
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .destructive, handler: nil)
        ac.addAction(cancelAction)
        ac.addAction(choosePhotoAction)
        ac.addAction(takePhotoAction)
        present(ac, animated: true)
    }
    
    
    func setupImageView() {
        imageView.anchors(top: view.safeAreaLayoutGuide.topAnchor, topPad: 24, bottom: nil, bottomPad: 0, left: view.leftAnchor, leftPad: 12, right: view.rightAnchor, rightPad: 12, height: 4 * (view.frame.height / 7), width: 0)
    }
    

    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let chosenImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            imageView.contentMode = .scaleAspectFit
            imageView.image = chosenImage
        }
        imageView.anchors(top: view.safeAreaLayoutGuide.topAnchor, topPad: 24, bottom: nil, bottomPad: 0, left: view.leftAnchor, leftPad: 12, right: view.rightAnchor, rightPad: 12, height:(view.frame.height / 3), width: 0)
        view.addSubview(descriptionTextView)
        descriptionTextView.anchors(top: imageView.bottomAnchor, topPad: 8, bottom: nil, bottomPad: 0, left: imageView.leftAnchor, leftPad: 0, right: imageView.rightAnchor, rightPad: 0, height: 80, width: 0)
        
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
    @objc func takePhotoTapped() {
        print("Hello, take photo tapped.")
        // Push a camera view onto the Nav controller stack.
        do {
            try Auth.auth().signOut()
            print("Signed out.")
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            let mainStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let onboardingVC = mainStoryboard.instantiateViewController(withIdentifier: "Onboarding")
            appDelegate.window = UIWindow(frame: UIScreen.main.bounds)
            appDelegate.window?.makeKeyAndVisible()
            appDelegate.window?.rootViewController = onboardingVC
        } catch {
            print("Error logging out.")
        }
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        //textView.translatesAutoresizingMaskIntoConstraints = true
        //textView.sizeToFit()
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        view.addSubview(postButton)
        postButton.layer.cornerRadius = 10.0
        postButton.anchors(top: descriptionTextView.bottomAnchor, topPad: 8, bottom: nil, bottomPad: 0, left: descriptionTextView.leftAnchor, leftPad: 20, right: descriptionTextView.rightAnchor, rightPad: 20, height: 50, width: 0)
       
    }
    
    func textViewDidChange(_ textView: UITextView) {
        //textView.sizeToFit()
    }
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        if(text == "\n") {
            textView.resignFirstResponder()
            return false
        }
            else {let currentText = textView.text ?? ""
            guard let stringRange = Range(range, in: currentText) else { return false }
            
            let changedText = currentText.replacingCharacters(in: stringRange, with: text)
            
            return changedText.count <= 180
        }
    }
    
    @objc func postTapped() {
        let imgManager = ImageManager()
        if let imageData = imageView.image?.jpegData(compressionQuality: 0.65), let location = locationManager.location {
            imgManager.upload(imageData) { (url) in
                let spot = Spot(locationName: "Dummy", description: self.descriptionTextView.text, tags: ["Bussy"], lat: location.coordinate.latitude, long: location.coordinate.longitude, photosURL: url)
                Networker.shared.postForUser(spot)
            }
        }
        // When user taps post, the details of the location, description, any tags, image URL
        // will be used to build a spot object to post to Firebase.
        // User taps post -> Image data is uploaded to Firebase Storage -> Download URL is passed via
        //      completion handler -> Download URL and other data is used to build a new Spot -> Upload to Firebase
        
    }
    
}

extension AddViewController : AVCapturePhotoCaptureDelegate {
    func photoOutput(_ output: AVCapturePhotoOutput, didFinishProcessingPhoto photo: AVCapturePhoto, error: Error?) {
//        let image = photo.fileDataRepresentation()
//        var imgManager = ImageManager()
//        if let imageData = image {
//            imgManager.upload(imageData) { (url) in
//                //Networker.shared.upload
//            }
//        }
        
        // FIX: - Use serial queue.
//        let url = imgManager.getURLFor(Storage.storage().reference().child("dummy.jpg"))
//        var spot = Spot(locationName: "Dummy", description: "Dummy", tags: ["Dummy"], lat: (userLocation?.coordinate.latitude)!, long: (userLocation?.coordinate.longitude)!, photosURL: "")
//        print(spot.photoURL)
//        let networker = Networker()
//        networker.postToPublicFirebase(spot)
    }

}

extension AddViewController: CLLocationManagerDelegate {
    
}
