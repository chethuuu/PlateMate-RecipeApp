//
//  FoodsTableViewController.swift
//  PlateMate
//
//  Created by Chethana on 2023-04-11.
//

import UIKit
import CoreData

class FoodsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var addRecipeButton: UIButton!
    @IBOutlet weak var tableView: UITableView!
    
    override var preferredStatusBarStyle: UIStatusBarStyle{
       return .lightContent
    }
    
    func UILoad () {
        addRecipeButton.layer.shadowColor = UIView().tintColor.cgColor
        addRecipeButton.layer.shadowOffset = CGSize(width: 0.0, height: 2.0)
        addRecipeButton.layer.shadowOpacity = 0.5
        addRecipeButton.layer.shadowRadius = 10
        addRecipeButton.layer.masksToBounds = false
        addRecipeButton.layer.cornerRadius = 4.0
    }
    
    var foods: [Foods] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        
        UILoad()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "openFoodDetails") {
            let foodDetailsController = segue.destination as! FoodDetailsViewController
            
            if let index = tableView.indexPathForSelectedRow?.row {
                foodDetailsController.selectedFoodId = foods[index].objectID
            }
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        fetchFoods()
    }
    
    func fetchFoods() {
        let foodManager = FoodCoreDataManager()
        
        do {
            foods = try foodManager.getAll()
            tableView.reloadData()
        } catch {
            ErrorHelper.handleError(self, message: "Error occurs fetching recipes")
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return foods.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let foodCell = tableView.dequeueReusableCell(withIdentifier: "foodCell", for: indexPath) as! FoodTableViewCell
        
        let currentFood = foods[indexPath.row]
        
        foodCell.name.text = currentFood.name
        foodCell.price.text = currentFood.price
        
        if let photo = currentFood.image {
            foodCell.photo.image = UIImage(data: photo)
        }
       
        return foodCell
    }
}

extension UINavigationController {
   open override var preferredStatusBarStyle: UIStatusBarStyle {
       return topViewController?.preferredStatusBarStyle ?? .lightContent
   }
}
