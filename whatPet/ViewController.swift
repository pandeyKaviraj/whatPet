//
//  ViewController.swift
//  whatPet
//
//  Created by KAVIRAJ PANDEY on 14/09/19.
//  Copyright © 2019 KAVIRAJ PANDEY. All rights reserved.
//

import UIKit
import CoreML
import Vision


class ViewController: UIViewController {
    
    //Outlets section
    
    @IBOutlet var imageView: UIImageView!

    override func viewDidLoad() {
        super.viewDidLoad()

    }

    
    //Action for camera button
    
    @IBAction func cameraTapped(_ sender: UIBarButtonItem) {
        print("Camera is woking!")
        
    }
    
}

