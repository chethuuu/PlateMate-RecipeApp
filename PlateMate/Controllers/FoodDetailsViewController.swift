//
//  ContactDetailsViewController.swift
//  PlateMate
//
//  Created by Chethana on 2023-04-11.
//

import UIKit
import CoreData

class FoodDetailsViewController: UIViewController {

    public var selectedFoodId: NSManagedObjectID!
    
    private var foodData: Foods!
    
    @IBOutlet weak var photoImage: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var priceeLabel: UILabel!
    
    @IBOutlet weak var detailsdataLabel: UITextView!
    @IBOutlet weak var createdAtLabel: UILabel!
    
    override var preferredStatusBarStyle: UIStatusBarStyle{
       return .lightContent
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "openEditFood" {
            let foodRegisterController = segue.destination as! FoodRegisterViewController
            
            foodRegisterController.editingFood = foodData
        }
    }
    
    @IBAction func onDeletePress(_ sender: Any) {
        let deleteConfirmation = UIAlertController(title: "Delete Recipe", message: "Are you sure you want to delete this recipe \(foodData.name ?? "")?", preferredStyle: .actionSheet)
        
        let deleteAction = UIAlertAction(title: "Delete", style: .destructive, handler: {(action) in
            
            do {
                        let foodManager = FoodCoreDataManager()
                        try foodManager.delete(id: self.foodData.objectID)
                        
                        // Show a success alert after deleting the recipe.
                        let successAlert = UIAlertController(title: "Recipe Deleted", message: "The recipe has been successfully Deleted!", preferredStyle: .alert)
                        let okAction = UIAlertAction(title: "OK", style: .default, handler: {(action) in
                            // Pop the view controller to return to the previous screen.
                            self.navigationController?.popViewController(animated: true)
                        })
                        successAlert.addAction(okAction)
                        self.present(successAlert, animated: true, completion: nil)
                        
                    } catch {
                        ErrorHelper.handleError(self, message: "Error occurs while deleting recipe")
                    }

                })
        
        deleteConfirmation.addAction(deleteAction)
        deleteConfirmation.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        
        present(deleteConfirmation, animated: true, completion: nil)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        do {
            let foodManager = FoodCoreDataManager()
            
            foodData = try foodManager.getById(id: selectedFoodId)
            
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "dd/MM/YYYY"
            
            nameLabel.text = foodData.name
            priceeLabel.text = foodData.price
            detailsdataLabel.text = foodData.details
            createdAtLabel.text = dateFormatter.string(from: foodData.createdAt!)
            
            if let imageData = foodData.image {
                photoImage.image = UIImage(data: imageData)
            }
            
            
        } catch {
            ErrorHelper.handleError(self, message: "Error occurs when loading recipe details")
            self.navigationController?.popViewController(animated: true)
        }
    }

}
