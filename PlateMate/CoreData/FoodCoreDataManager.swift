//
//  FoodCoreDataManager.swift
//  PlateMate
//
//  Created by Chethana on 2023-04-11.
//

import Foundation
import CoreData

class FoodCoreDataManager: CoreDataManager<FoodRegisterData, Foods> {
    
    override init() {
        super.init()
    }
        
        override func add(_ entity: FoodRegisterData) throws -> Foods {
            let food = Foods(context: self.getContext())
            
            food.name = entity.name
            food.details = entity.details
            food.price = entity.price
            food.createdAt = Date.now
            food.image = entity.image.jpegData(compressionQuality: 1)
            
            try self.getContext().save()
            
            return food
        }
        
        override func getAll() throws -> [Foods] {
            let fetchRequest = Foods.fetchRequest();
            
            let sortByDate = NSSortDescriptor(key: #keyPath(Foods.createdAt), ascending: false)
            fetchRequest.sortDescriptors = [sortByDate]
            return try getContext().fetch(fetchRequest)
        }
        
        override func getById(id: NSManagedObjectID) throws -> Foods {
            return try getContext().existingObject(with: id) as! Foods
        }
        
        override func update(id: NSManagedObjectID, entity: FoodRegisterData) throws -> Foods {
            let food = try getById(id: id)
            
            food.price = entity.price
            food.details = entity.details
            food.image = entity.image.jpegData(compressionQuality: 1)
            food.name = entity.name
            
            try self.getContext().save()
            
            return food
        }
        
        override func delete(id: NSManagedObjectID) throws {
            let food = try getById(id: id)
            
            getContext().delete(food)
            
            try getContext().save()
        }
    }
