//
//  CoreDataManager.swift
//  PlateMate
//
//  Created by Chethana on 2023-04-11.
//

import Foundation
import CoreData
import UIKit

class CoreDataManager<T, U> {
    
    private var persistentContainer: NSPersistentContainer!
    
    internal init() {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        persistentContainer = appDelegate.persistentContainer
    }
    
    internal final func getContext () -> NSManagedObjectContext {
        return persistentContainer.viewContext;
    }
    
    func add(_ entity: T) throws -> U {
        fatalError("Not implemented")
    }
    
    func update (id: NSManagedObjectID, entity: T) throws -> U {
        fatalError("Not implemented")
    }
    
    func delete (id: NSManagedObjectID) throws {
        fatalError("Not implemented")
    }
    
    func getAll () throws -> [U] {
        fatalError("Not implemented")
    }
    
    func getById (id: NSManagedObjectID) throws -> U {
        fatalError("Not implemented")
    }
    
}
