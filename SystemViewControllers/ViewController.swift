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
        let imageickerViewController = UIImagePickerController()
        imageickerViewController.delegate = self
        let alert = UIAlertController(title: "Chose Image Source", message: "Вы должны выбрать изображение.", preferredStyle: .actionSheet)
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        let cameraAction = UIAlertAction(title: "Camera", style: .default) { _ in
            print("You selected camera to take a picture.")
        }
        let photoLibraryAction = UIAlertAction(title: "Library", style: .default) { _ in
            print("You open library to select image.")
        }
        alert.addAction(cancelAction)
        alert.addAction(cameraAction)
        alert.addAction(photoLibraryAction)
        alert.popoverPresentationController?.sourceView = sender as? UIButton
        present(alert, animated: true)
    }
    
    @IBAction func emailButtonTapped(_ sender: Any) {
    }
}

