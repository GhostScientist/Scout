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
    @IBOutlet weak var cameraPreviewView: UIView!
    
    // MARK: - Instance Variables
    var captureSession: AVCaptureSession?
    var videoPreviewLayer: AVCaptureVideoPreviewLayer?
    var capturePhotoOuput: AVCapturePhotoOutput?
    var locationManager = CLLocationManager()
    var userLocation: CLLocation?

    override func viewDidLoad() {
        super.viewDidLoad()
        cameraSetup()
        
        capturePhotoOuput = AVCapturePhotoOutput()
        capturePhotoOuput?.isHighResolutionCaptureEnabled = true
        captureSession?.addOutput(capturePhotoOuput!)
        userLocation = locationManager.location
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
        cameraPreviewView.layer.addSublayer(videoPreviewLayer!)
        
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
    
    // MARK: - IB Action
    @IBAction func onTapPostDummy(_ sender: UIButton) {
//        guard let capturePhotoOutput = self.capturePhotoOuput else { return }
//
//        let photoSettings = AVCapturePhotoSettings()
//        photoSettings.isHighResolutionPhotoEnabled = true
//        photoSettings.isAutoStillImageStabilizationEnabled = true
//        photoSettings.flashMode = .auto
//
//        capturePhotoOutput.capturePhoto(with: photoSettings, delegate: self)
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
            print("Error signing out.")
        }
    }
    
    @IBAction func grabData(_ sender: UIButton) {
        Networker.shared.pullPublicSpots()
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
