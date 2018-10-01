//
//  PersistenceManager.swift
//  MarketListModel
//
//  Created by Phan Nhat Dang on 9/24/18.
//  Copyright © 2018 Phan Nhat Dang. All rights reserved.
//

import Foundation
import CoreData

final class PersistenceManager {
    
    //    private init() {}
    //    static let shared = PersistenceManager()
    
    
    // MARK: - Core Data stack
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "MarketListDatabase")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    lazy var context = persistentContainer.viewContext
    
    
    // MARK: - Core Data Saving support
    
    func save () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
                print("saved successfully")
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
    
    func delete(_ object: NSManagedObject) {
        context.delete(object)
        save()
    }
    
    //MARK: - Load an array of Object
    func fetch<T:NSManagedObject>(_ object: T.Type) -> [T] {
        let entityName = String(describing: object)
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
        
        do {
            let fetchObjects = try context.fetch(fetchRequest) as? [T]
            return fetchObjects ?? [T]()
        } catch  {
            print(error)
            return [T]()
        }
    }
    
}
