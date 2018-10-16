//
//  CameraViewController.swift
//  Scout
//
//  Created by Dakota Kim on 10/15/18.
//  Copyright © 2018 theghost. All rights reserved.
//

import UIKit

class CameraViewController: UIViewController {
    
    @IBOutlet weak var cameraPreview: UIImageView!
    @IBOutlet weak var shutterButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        shutterButton.titleLabel?.text = ""
        shutterButton.frame = CGRect(x: view.frame.width/2, y: 8 * (view.frame.height / 9), width: 50, height: 50)
        shutterButton.layer.cornerRadius = 0.5 * shutterButton.bounds.size.width
        shutterButton.clipsToBounds = true
        shutterButton.backgroundColor = UIColor.gray
        cameraPreview.image = UIImage()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func shutterPressed(_ sender: UIButton) {
    }
    
}
