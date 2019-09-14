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


class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    let photoPicker = UIImagePickerController()
    @IBOutlet var imageView: UIImageView!

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Delegate for photoPicker
        photoPicker.delegate = self
        photoPicker.sourceType = .photoLibrary
        photoPicker.allowsEditing = true

    }
    
    
    //Step3: Implement didfinishPickerMediawithinfo methods
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let userPickedImage = info[UIImagePickerController.InfoKey.editedImage] as? UIImage {
            
            guard let ciimage = CIImage(image: userPickedImage) else {
                fatalError("Probleam in converting UIImage into CIImage")
            }
            identifyImage(image: ciimage)
            imageView.image = userPickedImage
        }
        photoPicker.dismiss(animated: true, completion: nil)
    }
    

    //Mark- Machine learning code for image Processing
    
    func identifyImage(image: CIImage) {
        
        //Creating coreMl vision container, loading core ml model
        
        guard let model = try? VNCoreMLModel(for: animalImageClassifier().model) else {
            fatalError("Unable to make model VNCoreMlModel")
        }
        
        //Make a request
        
        let request = VNCoreMLRequest(model: model) { (request, error) in
            let classification = request.results?.first as? VNClassificationObservation
            
            if let detectedFlowerName = classification?.identifier.capitalized {
                self.navigationItem.title = detectedFlowerName
            }
        }
        
        let handler = VNImageRequestHandler(ciImage: image)
        do {
            try handler.perform([request])
        }
        catch {
            print(error)
        }
    }
    
    @IBAction func cameraTapped(_ sender: UIBarButtonItem) {
        present(photoPicker, animated: true, completion: nil)
        
    }
    
}

