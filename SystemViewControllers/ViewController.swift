//
//  ViewController.swift
//  SystemViewControllers
//
//  Created by Федор Завьялов on 10.07.2025.
//

import UIKit
import SafariServices

class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var imageView: UIImageView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func shareButtonTapped(_ sender: UIButton) {
        guard let image = imageView.image else { return }
        
        let activityViewController = UIActivityViewController(activityItems: [image, "You can do it!"], applicationActivities: nil)
        activityViewController.popoverPresentationController?.sourceView = sender
        present(activityViewController, animated: true)
    }
    
    
    @IBAction func safariButtonTapped(_ sender: Any) {
        guard let url = URL(string: "https://www.apple.com") else { return }
        let safariViewController = SFSafariViewController(url: url)
        present(safariViewController, animated: true)
    }
    
    @IBAction func cameraButtonTapped(_ sender: Any) {
        let imagePickerViewController = UIImagePickerController()
        imagePickerViewController.delegate = self
        let alert = UIAlertController(title: "Chose Image Source", message: "Вы должны выбрать изображение.", preferredStyle: .actionSheet)
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            let cameraAction = UIAlertAction(title: "Camera", style: .default) { _ in
                imagePickerViewController.sourceType = .camera
                self.present(imagePickerViewController, animated: true)
                print("You selected camera to take a picture.")
            }
            alert.addAction(cameraAction)
            
            let phpPicker = PHPickerViewController(configuration: )
        }
        if  UIImagePickerController.isSourceTypeAvailable(.photoLibrary) {
            let photoLibraryAction = UIAlertAction(title: "Library", style: .default) { _ in
                print("You open library to select image.")
                imagePickerViewController.sourceType = .photoLibrary
                self.present(imagePickerViewController, animated: true)
            }
            alert.addAction(photoLibraryAction)
        }
            
        alert.addAction(cancelAction)
        alert.popoverPresentationController?.sourceView = sender as? UIButton
        present(alert, animated: true)
    }
    
    @IBAction func emailButtonTapped(_ sender: Any) {
    }
}

