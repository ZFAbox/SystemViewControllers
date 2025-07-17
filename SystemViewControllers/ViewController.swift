//
//  ViewController.swift
//  SystemViewControllers
//
//  Created by Федор Завьялов on 10.07.2025.
//

import UIKit
import SafariServices
import MessageUI

class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, MFMailComposeViewControllerDelegate {

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
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let selevtedImage = info[.originalImage] as? UIImage else { return }
    
        imageView.image = selevtedImage
        dismiss(animated: true)
    }
    
    @IBAction func emailButtonTapped(_ sender: Any) {
        guard MFMailComposeViewController.canSendMail() else {
            print("Your device could not send an e-mail!")
            return
        }
        let mailComposer = MFMailComposeViewController()
        mailComposer.delegate = self
        
        mailComposer.setSubject("Loaded Image")
        mailComposer.setBccRecipients(["deathwish-art@mail.ru"])
        mailComposer.setMessageBody("Image from the app", isHTML: false)
        if let image = imageView.image, let imageData = image.jpegData(compressionQuality: 0.9) {
            mailComposer.addAttachmentData(imageData, mimeType: "image/jpeg", fileName: "photo.jpg")
        }
        present(mailComposer, animated: true, completion: nil)
    }
    
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: (any Error)?) {
        dismiss(animated: true)
    }
    func mailComposeControllerDidFinish(_ controller: MFMailComposeViewController) {
        dismiss(animated: true)
    }
}

