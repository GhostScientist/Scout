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

class AddViewController: UIViewController {
    
    // MARK: - IB Outlets
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var choosePhotoOutlet: UIButton!
    @IBOutlet weak var takePhotoOutlet: UIButton!
    
    // MARK: - Instance Variables
    var captureSession: AVCaptureSession?
    var videoPreviewLayer: AVCaptureVideoPreviewLayer?
    var capturePhotoOuput: AVCapturePhotoOutput?
    var locationManager = CLLocationManager()
    var userLocation: CLLocation?

    override func viewDidLoad() {
        super.viewDidLoad()
        cameraSetup()
        choosePhotoOutlet.layer.cornerRadius = 10.0
        takePhotoOutlet.layer.cornerRadius = 10.0
        imageView.layer.cornerRadius = 10.0
        imageView.layer.masksToBounds = true
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
    
    @IBAction func grabData(_ sender: UIButton) {
        Networker.shared.pullPublicSpots()
    }
    
    
    func setupUI() {
        setupImageView()
        setupButtons()
    }
    
    func setupImageView() {
        imageView.anchors(top: view.safeAreaLayoutGuide.topAnchor, topPad: 24, bottom: nil, bottomPad: 0, left: view.leftAnchor, leftPad: 12, right: view.rightAnchor, rightPad: 12, height: view.frame.height / 2, width: 0)
    }
    
    func setupButtons() {
        choosePhotoOutlet.anchors(top: imageView.bottomAnchor, topPad: 30, bottom: nil, bottomPad: 0, left: view.leftAnchor, leftPad: 12, right: view.rightAnchor, rightPad: 12, height: view.frame.height / 15, width: 0)
        choosePhotoOutlet.addTarget(self, action: #selector(choosePhotoTapped), for: .touchUpInside)
        takePhotoOutlet.anchors(top: choosePhotoOutlet.bottomAnchor, topPad: 30, bottom: nil, bottomPad: 0, left: view.leftAnchor, leftPad: 12, right: view.rightAnchor, rightPad: 12, height: view.frame.height / 15, width: 0)
        takePhotoOutlet.addTarget(self, action: #selector(takePhotoTapped), for: .touchUpInside)
    }
    
    @objc func choosePhotoTapped() {
        print("Hello, choose tapped")
        // Present a photo picker.
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
}

extension AddViewController : AVCapturePhotoCaptureDelegate {
    func photoOutput(_ output: AVCapturePhotoOutput, didFinishProcessingPhoto photo: AVCapturePhoto, error: Error?) {
        let image = photo.fileDataRepresentation()
        var imgManager = ImageManager()
        if let imageData = image {
            imgManager.upload(imageData)
        }
        
        // FIX: - Use serial queue.
        let url = imgManager.getURLFor(Storage.storage().reference().child("dummy.jpg"))
        var spot = Spot(locationName: "Dummy", description: "Dummy", tags: ["Dummy"], lat: (userLocation?.coordinate.latitude)!, long: (userLocation?.coordinate.longitude)!, photosURL: "")
        print(spot.photosURL)
        let networker = Networker()
        networker.postToPublicFirebase(spot)
    }

}
