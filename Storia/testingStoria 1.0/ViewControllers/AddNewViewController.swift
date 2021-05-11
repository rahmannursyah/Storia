//
//  AddNewViewController.swift
//  testingStoria 1.0
//
//  Created by Rahmannur Rizki Syahputra on 29/04/21.
//

import UIKit
import MapKit
import Photos

class AddNewViewController: UIViewController, UIImagePickerControllerDelegate & UINavigationControllerDelegate, UITextViewDelegate, UITextFieldDelegate {

	@IBOutlet weak var titleMemory: UITextField!
	@IBOutlet weak var galleryButton: UIButton!
	@IBOutlet weak var galleryPreview: UIImageView!
	@IBOutlet weak var oneWordField: UITextField!
	@IBOutlet weak var detailField: UITextView!
	@IBOutlet weak var datePicker: UIDatePicker!
	@IBOutlet weak var locationMemory: UITextField!
	@IBOutlet weak var locationLabel: UILabel!
	
	var imagePickerController = UIImagePickerController()
	
	var locationName: Any = ""
	
	var lattitude: Double!
	var longitude: Double!
	
	@IBAction func didTapGallery(_ sender: Any) {
		self.imagePickerController.sourceType = .photoLibrary
		self.present(self.imagePickerController, animated: true, completion: nil)
	}
	
	let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
	
    override func viewDidLoad() {
        super.viewDidLoad()
		
//		buat narok placeholder di text view detail
		detailField.delegate = self
		detailField.text = "Detail"
		detailField.textColor = UIColor.lightGray
		titleMemory.delegate = self
		oneWordField.delegate = self
//		buat bisa ngepick image dari gallery user
		imagePickerController.delegate = self
		
//		locationLabel.text = "\(locationName)"
    }
    
	func checkPermissions() {
		if PHPhotoLibrary.authorizationStatus() != PHAuthorizationStatus.authorized {
			PHPhotoLibrary.requestAuthorization({ (status: PHAuthorizationStatus) -> Void in ()
			})
		}
		
		if PHPhotoLibrary.authorizationStatus() == PHAuthorizationStatus.authorized {
		}else{
			PHPhotoLibrary.requestAuthorization(requestAuthorizationHandler)
		}
	}
	
	func requestAuthorizationHandler(status: PHAuthorizationStatus) {
		if PHPhotoLibrary.authorizationStatus() == PHAuthorizationStatus.authorized {
			print("Access granted to use photo Library")
		} else{
			print("We don't have access to your Photos.")
		}
	}
	
	func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
		galleryPreview.image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage
		
		picker.dismiss(animated: true, completion: nil)
	}
	
	func textViewDidBeginEditing(_ textView: UITextView) {
		if textView.textColor == UIColor.lightGray {
			textView.text = nil
			textView.textColor = UIColor.black
		}
	}
	
	func textViewDidEndEditing(_ textView: UITextView) {
		if textView.text.isEmpty {
			textView.text = "Detail"
			textView.textColor = UIColor.lightGray
		}
	}
	
	func textFieldShouldReturn(_ textField: UITextField) -> Bool {
		self.view.endEditing(true)
		return false
	}
	
	@IBAction func unwindToAddMemory(_ sender: UIStoryboardSegue) {
//		guard let source = sender.source as? AddLocationViewController else {
//			return
//		}
//		locationLabel.text = source.locationName as! String
//		print(source.locationName)
//		print("unwind successfull")
	}
	
	@IBAction func didTapCancel(_ sender: Any) {
		dismiss(animated: true, completion: nil)
	}
	
	@IBAction func didTappAdd(_ sender: Any) {
		
//		create a memory object
		let newMemory = Memory(context: context)
		
		newMemory.title = titleMemory.text
		newMemory.detail = detailField.text
		newMemory.oneWord = oneWordField.text
		newMemory.location = locationLabel.text ?? "error saving location"
		newMemory.dateMemory = datePicker.date
		newMemory.image = galleryPreview.image?.jpegData(compressionQuality: 1.0) ?? nil
		newMemory.coordinateLat = lattitude
		newMemory.coordinateLon = longitude
		print(lattitude)
		print(longitude)
		
		do{
			try self.context.save()
			print("successfull")
		}
		catch{
			print("error saving data")
		}
		
		performSegue(withIdentifier: "unwindToFirst", sender: self)
	}
	
}
