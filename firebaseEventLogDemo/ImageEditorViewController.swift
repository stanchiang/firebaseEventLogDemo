//
//  ImageEditorViewController.swift
//  PhotoChallenge
//
//  Created by Freddy Hernandez on 1/4/16.
//  Copyright © 2016 Freddy Hernandez. All rights reserved.
//

import UIKit

protocol ImageEditorDelegate : class {

	func imageEditorDidCancel()
}

class ImageEditorViewController: UIViewController {
	
	
	var captionableImageView: CaptionableImageView!
	var saveButton: UIButton!
    var newButton: UIButton!
	var textField: UITextField!
    
	weak var delegate: ImageEditorDelegate?
	var originalImage: UIImage!
	var tapRecognizer:UITapGestureRecognizer?
	

    override func viewDidLoad() {
        super.viewDidLoad()
		
        self.view.backgroundColor = UIColor.white
        
        captionableImageView = CaptionableImageView(frame: self.view.bounds)
        self.view.addSubview(captionableImageView)
        
        saveButton = UIButton(frame: CGRect(x: 0, y: self.view.frame.maxY - 50, width: 50, height: 50))
        saveButton.setTitle("Save", for: .normal)
        saveButton.setTitleColor(UIColor.white, for: .normal)
        saveButton.backgroundColor = UIColor.blue
        saveButton.addTarget(self, action: #selector(save(_:)), for: .touchUpInside)
        self.view.addSubview(saveButton)
        
        newButton = UIButton(frame: CGRect(x: self.view.frame.maxX - 50, y: self.view.frame.maxY - 50, width: 50, height: 50))
        newButton.setTitle("New", for: .normal)
        newButton.setTitleColor(UIColor.white, for: .normal)
        newButton.backgroundColor = UIColor.green
        newButton.addTarget(self, action: #selector(insertCaption(_:)), for: .touchUpInside)
        self.view.addSubview(newButton)
        
        textField = UITextField(frame: CGRect(origin: self.view.center, size: CGSize(width: self.view.frame.width, height: 50)))
        textField.center = self.view.center
        textField.isEnabled = false
        textField.delegate = self
        self.view.addSubview(textField)
        
		tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(ImageEditorViewController.dismissKeyboard))
		tapRecognizer?.cancelsTouchesInView = false
		view.addGestureRecognizer(tapRecognizer!)

    }
	
	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
		originalImage = UIImage(named: "IMG_4302")
		//Update the image
		captionableImageView.image = originalImage
		captionableImageView.originalImage = originalImage
	}
	
	func cancel(_ sender: AnyObject) {
		delegate?.imageEditorDidCancel()
		captionableImageView.removeCaptions()
	}
	
	func insertCaption(_ sender: UIButton) {
		self.view.bringSubview(toFront: textField)
		textField.becomeFirstResponder()
		textField.isHidden = false
        textField.isEnabled = true
        textField.backgroundColor = UIColor.lightGray
	}
	
	func save(_ sender: UIButton) {
		
		saveButton.isEnabled = false
		UIImageWriteToSavedPhotosAlbum(captionableImageView.currentImage, self, #selector(ImageEditorViewController.image(_:didSaveWithError:contextInfo:)), nil)
	}
	
	func share(_ sender: UIBarButtonItem) {
		
		let activityController = UIActivityViewController(activityItems: [captionableImageView.currentImage], applicationActivities: nil)
		present(activityController, animated: true, completion: nil)
	}
	
	func image(_ image:UIImage, didSaveWithError error:NSError, contextInfo:UnsafeRawPointer) {
		
		if error.code == 0 {
			saveButton.isEnabled = true
			self.showSavedPhotoAlert()
		} else {
			print("Error Code: \(error.code) Error User Info: \(error.userInfo)")
		}
		
	}
	
	func dismissKeyboard() {
		view.endEditing(true)
	}
	
	func showSavedPhotoAlert() {
		
		//Confirmation that the image did save to the Camera Roll
		//Requires user to press "OK" to dismiss
		let successAlert = UIAlertController(title: "Successfully Saved", message: "There is a new photo in your library.", preferredStyle: .alert)
		let doneAction = UIAlertAction(title: "Thanks", style: .default, handler: nil)
		successAlert.addAction(doneAction)
		
		present(successAlert, animated: true, completion: nil)
	}
	
}

extension ImageEditorViewController : UITextFieldDelegate {
	
	func textFieldShouldReturn(_ textField: UITextField) -> Bool {
		self.dismissKeyboard()
		return true
	}
	
	func textFieldDidEndEditing(_ textField: UITextField) {
		textField.isHidden = true
        textField.isEnabled = false
		captionableImageView.insertCaptionWithText(textField.text!)
	}
}
