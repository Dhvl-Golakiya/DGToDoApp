//
//  TaskStack.swift
//  ToDoApp
//
//  Created by Dhvl on 22/09/15.
//  Copyright (c) 2015 Dhvl. All rights reserved.
//

import Foundation
import CoreData

public class TaskStack {
    private struct TaskStackConstants {
        static let appGroupID = "group.com.avinashi.ToDoApp"
        static let shouldUseAppGroupsForStorage = true
    }
    
    public class var sharedInstance:TaskStack {
        struct Singleton {
            static let instance = TaskStack()
        }
        return Singleton.instance
    }
    
    // MARK - helper methods
    public func createTask(name:String, startHour : NSNumber, startMinute : NSNumber) -> ToDoApp? {
        
        var newTask = NSEntityDescription.insertNewObjectForEntityForName("ToDoApp", inManagedObjectContext: self.managedObjectContext!) as ToDoApp
        newTask.name = name
        newTask.taskId = NSUUID().UUIDString
        newTask.startMinute = startMinute
        newTask.startHour = startHour
        newTask.startDate = NSDate().formateDateFull(NSDate())
        return newTask
    }
    
    
    public func deleteTask(task:ToDoApp) {
        self.managedObjectContext?.deleteObject(task)
        self.saveContext()
    }
    
    public func allTasks() -> [ToDoApp]? {
        let request = NSFetchRequest(entityName: "ToDoApp")
        let predict = NSPredicate(
            request.sortDescriptors = [
                NSSortDescriptor(key: "name", ascending: false),
                NSSortDescriptor(key: "startDate", ascending: true)
            ])
        return self.managedObjectContext?.executeFetchRequest(request, error: nil) as [ToDoApp]?
    }
    
    public func oneDayTasks(date : String) -> [ToDoApp]? {
        let request = NSFetchRequest(entityName: "ToDoApp")
        let predicate = NSPredicate(format: "startDate = %@", date)
        request.predicate = predicate
        
//        let predict = NSPredicate(
//            request.sortDescriptors = [
//                NSSortDescriptor(key: "name", ascending: false),
//                NSSortDescriptor(key: "startDate", ascending: true)
//            ])
        return self.managedObjectContext?.executeFetchRequest(request, error: nil) as [ToDoApp]?
    }
    // MARK - Core Data methods
    
    lazy var applicationDocumentsDirectory: NSURL = {
        // The directory the application uses to store the Core Data store file. This code uses a directory named "com.cogitoergosum.Test2" in the application's documents Application Support directory.
        let urls = NSFileManager.defaultManager().URLsForDirectory(.DocumentDirectory, inDomains: .UserDomainMask)
        return urls[urls.count-1] as NSURL
        }()
    
    lazy var managedObjectModel: NSManagedObjectModel = {
        // The managed object model for the application. This property is not optional. It is a fatal error for the application not to be able to find and load its model.
        
        let modelURL = NSBundle.mainBundle().URLForResource("ToDoApp", withExtension: "momd")!
        return NSManagedObjectModel(contentsOfURL: modelURL)!
        }()
    
    lazy var persistentStoreCoordinator: NSPersistentStoreCoordinator? = {
        // The persistent store coordinator for the application. This implementation creates and return a coordinator, having added the store for the application to it. This property is optional since there are legitimate error conditions that could cause the creation of the store to fail.
        // Create the coordinator and store
        var coordinator: NSPersistentStoreCoordinator? = NSPersistentStoreCoordinator(managedObjectModel: self.managedObjectModel)
        var containerURL:NSURL?;
        if (TaskStackConstants.shouldUseAppGroupsForStorage) {
            containerURL = NSFileManager.defaultManager().containerURLForSecurityApplicationGroupIdentifier(TaskStackConstants.appGroupID)?.URLByAppendingPathComponent("ToDoApp.sqlite")
            
        } else {
            containerURL = self.applicationDocumentsDirectory.URLByAppendingPathComponent("ToDoApp.sqlite")
        }
        
        var error: NSError? = nil
        var failureReason = "There was an error creating or loading the application's saved data."
        if coordinator!.addPersistentStoreWithType(NSSQLiteStoreType, configuration: nil, URL: containerURL, options: nil, error: &error) == nil {
            coordinator = nil
            // Report any error we got.
            var dict = [String: AnyObject]()
            dict[NSLocalizedDescriptionKey] = "Failed to initialize the application's saved data"
            dict[NSLocalizedFailureReasonErrorKey] = failureReason
            dict[NSUnderlyingErrorKey] = error
            error = NSError(domain: "YOUR_ERROR_DOMAIN", code: 9999, userInfo: dict)
            // Replace this with code to handle the error appropriately.
            // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            NSLog("Unresolved error \(error), \(error!.userInfo)")
            abort()
        }
        
        return coordinator
        }()
    
    lazy var managedObjectContext: NSManagedObjectContext? = {
        // Returns the managed object context for the application (which is already bound to the persistent store coordinator for the application.) This property is optional since there are legitimate error conditions that could cause the creation of the context to fail.
        let coordinator = self.persistentStoreCoordinator
        if coordinator == nil {
            return nil
        }
        var managedObjectContext = NSManagedObjectContext()
        managedObjectContext.persistentStoreCoordinator = coordinator
        return managedObjectContext
        }()
    
    // MARK: - Core Data Saving support
    
    public func saveContext () {
        if let moc = self.managedObjectContext {
            var error: NSError? = nil
            if moc.hasChanges && !moc.save(&error) {
                // Replace this implementation with code to handle the error appropriately.
                // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                NSLog("Unresolved error \(error), \(error!.userInfo)")
                abort()
            }
        }
    }

}
