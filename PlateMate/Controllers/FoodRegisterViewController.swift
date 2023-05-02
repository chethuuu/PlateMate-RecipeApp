//
//  FoodRegisterViewController.swift
//  PlateMate
//
//  Created by Chethana on 2023-04-11.
//

import UIKit

class FoodRegisterViewController: UIViewController {

    @IBOutlet weak var nameField: UITextField!
    @IBOutlet weak var priceField: UITextField!
    @IBOutlet weak var detailsField: UITextField!
    @IBOutlet weak var saveButton: UIButton!
    @IBOutlet weak var photoThumbnail: UIButton!
    
    public var editingFood: Foods? = nil
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
       return .lightContent
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if editingFood != nil {
            nameField.text = editingFood?.name
            priceField.text = editingFood?.price
            detailsField.text = editingFood?.details
            
            if let image = editingFood?.image {
                photoThumbnail.setBackgroundImage(UIImage(data: image), for: .normal)
                userHasSelectedImage = true
            }
            
            saveButton.setTitle("Update Recipe", for: .normal)
            navigationItem.title = "Edit \(editingFood!.name ?? "")"
        }
        
        validateFields()
    }
    
    @IBAction func handleSaveContact(_ sender: UIButton) {
        let foodData = FoodRegisterData()
        
        foodData.name = nameField!.text
        foodData.price = priceField!.text
        foodData.details = detailsField!.text
        foodData.image = photoThumbnail.backgroundImage(for: .normal)
        
        let foodsManager = FoodCoreDataManager()
        
        do {
            if editingFood == nil {
                _ = try foodsManager.add(foodData)
            } else {
                _ = try foodsManager.update(id: editingFood!.objectID, entity: foodData)
            }
            
            self.navigationController?.popViewController(animated: true)
            
            let alertController = UIAlertController(title: "Recipe Added", message: "Your Recipe has been added Successfully!", preferredStyle: .alert)
            let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
            alertController.addAction(okAction)
            present(alertController, animated: true, completion: nil)
        } catch {
            ErrorHelper.handleError(self, message: "Error occurs adding recipe. Try again later!")
        }
    }
    
    @IBAction func onPhotoChangePress(_ sender: Any) {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.allowsEditing = true
        present(imagePicker, animated: true, completion: nil)
    }
    
    @IBAction func onChangeField(_ sender: Any) {
        validateFields()
    }
    
    var userHasSelectedImage = false
    
    func validateFields() {
        var isValid = true
                
        if (!userHasSelectedImage) {
            isValid = false
        }
                
        if nameField.text!.isEmpty {
            isValid = false
        }
                
        if priceField.text!.isEmpty {
            isValid = false
        }
                
        if detailsField.text!.isEmpty {
            isValid = false
        }
            
        if isValid {
            saveButton.isEnabled = true
        } else {
            saveButton.isEnabled = false
        }
    }
}

extension FoodRegisterViewController: UINavigationControllerDelegate, UIImagePickerControllerDelegate  {
 
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            
        if let selected = info[.editedImage] as? UIImage {
            photoThumbnail.setBackgroundImage(selected, for: .normal)
            userHasSelectedImage = true
        }
        
        validateFields()
        picker.dismiss(animated: true, completion: nil)
    }
}
