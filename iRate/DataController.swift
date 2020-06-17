//
//  DataController.swift
//  iRate
//
//  Created by Garima Bothra on 17/06/20.
//  Copyright © 2020 Garima Bothra. All rights reserved.
//

import Foundation
import CoreData

class DataController {

    let persistentContainer: NSPersistentContainer
    var viewContext: NSManagedObjectContext{
        return persistentContainer.viewContext
    }
    var backgroundContext: NSManagedObjectContext!

    //MARK: Initializing Persistent Container
    init(modelName: String){
        persistentContainer = NSPersistentContainer(name: modelName)
    }

    func configureContexts() {
        backgroundContext = persistentContainer.newBackgroundContext()
        viewContext.automaticallyMergesChangesFromParent = true
        backgroundContext.automaticallyMergesChangesFromParent = true
        backgroundContext.mergePolicy = NSMergePolicy.mergeByPropertyObjectTrump
        viewContext.mergePolicy = NSMergePolicy.mergeByPropertyStoreTrump
    }

    //MARK: Loading the Persistent Store
    func load(completion: (() -> Void)? = nil){
        persistentContainer.loadPersistentStores(completionHandler: { storeDescription, error in
            guard error == nil else {
                fatalError(error!.localizedDescription)
            }
            self.autoSaveViewContext(timeInterval: 3)
            self.configureContexts()
            completion?()
        })
    }
}

//MARK: Autosaving with Time Intervals
extension DataController {
    func autoSaveViewContext(timeInterval: TimeInterval = 30) {
        guard timeInterval > 0 else {
            print("Negative interval not possible!")
            return
        }
        if viewContext.hasChanges {
            try? viewContext.save()
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + timeInterval) {
            self.autoSaveViewContext(timeInterval: timeInterval)
        }
    }
}
