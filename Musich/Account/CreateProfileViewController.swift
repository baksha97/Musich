//
//  CreateProfileViewController.swift
//  Musich
//
//  Created by Loaner on 2/18/18.
//  Copyright © 2018 baksha97. All rights reserved.
//

import UIKit
import MaterialComponents.MaterialAppBar
import MaterialComponents.MDCTextField
import MaterialComponents.MDCTextInputControllerLegacyDefault

class CreateProfileViewController: UIViewController,UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITextFieldDelegate {

    //MARK: Constant
    let unwindToLoginSegue = "unwindToLoginSegue"
    //MARK: Outlets
    @IBOutlet weak var displayNameField: MDCTextField!
    @IBOutlet weak var profilePictureImageView: UIImageView!
    @IBOutlet weak var nameTextField: MDCTextField!
    
    var userEmail: String?
    var password: String?
    
    
    //MARK: UI Elements
    let appBar = MDCAppBar()
    var displayNameController: MDCTextInputControllerLegacyDefault?
    var nameController: MDCTextInputControllerLegacyDefault?
    
    let imagePicker = UIImagePickerController()
    override func viewDidLoad() {
        super.viewDidLoad()
        configureAppBar()
        configureFields()
        imagePicker.delegate = self
        // Do any additional setup after loading the view.
    }
    
    func configureFields(){
        displayNameField.delegate = self
        nameTextField.delegate = self
        displayNameController = MDCTextInputControllerLegacyDefault(textInput: displayNameField)
        nameController = MDCTextInputControllerLegacyDefault(textInput: nameTextField)
    }

    func configureAppBar(){
        addChildViewController(appBar.headerViewController)
        appBar.headerViewController.headerView.backgroundColor = UIColor(red: 1.0, green: 0.81, blue: 0.0, alpha: 1.0)
        appBar.addSubviewsToParent()
        title = "Create your profile!"
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(self.doneDidTap))
//        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Next", style: .plain, target: self, action: #selector(self.nextDidTap))
        
        appBar.navigationBar.tintColor = UIColor.black
    }

    @objc func doneDidTap(){
        if(displayNameField.text != "" && nameTextField.text != ""){
            UserRegistrationService.shared.registerUser(email: self.userEmail!, password: self.password!, name: nameTextField.text!, displayName: displayNameField.text!, pickedImage: profilePictureImageView.image!)
            performSegue(withIdentifier: unwindToLoginSegue, sender: self)
        }
    }
    
    @IBAction func choosePhotoDidTap(_ sender: Any) {
    
        imagePicker.allowsEditing = false
        imagePicker.sourceType = .photoLibrary
        
        
        /*
         The sourceType property wants a value of the enum named        UIImagePickerControllerSourceType, which gives 3 options:
         
         UIImagePickerControllerSourceType.PhotoLibrary
         UIImagePickerControllerSourceType.Camera
         UIImagePickerControllerSourceType.SavedPhotosAlbum
         
         */
        present(imagePicker, animated: true, completion: nil)
    
    
    }
    
    // MARK: - ImagePicker Delegate
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        if let pickedImage = info[UIImagePickerControllerOriginalImage] as? UIImage {
            profilePictureImageView.contentMode = .scaleAspectFit
            profilePictureImageView.image = pickedImage
        }
        
        
        /*
         
         Swift Dictionary named “info”.
         We have to unpack it from there with a key asking for what media information we want.
         We just want the image, so that is what we ask for.  For reference, the available options are:
         
         UIImagePickerControllerMediaType
         UIImagePickerControllerOriginalImage
         UIImagePickerControllerEditedImage
         UIImagePickerControllerCropRect
         UIImagePickerControllerMediaURL
         UIImagePickerControllerReferenceURL
         UIImagePickerControllerMediaMetadata
         
         */
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion:nil)
    }

}
