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
        
        return self.managedObjectContext?.executeFetchRequest(request, error: nil) as [ToDoApp]?
    }
    // MARK - Core Data methods
    
    lazy var applicationDocumentsDirectory: NSURL = {

        let urls = NSFileManager.defaultManager().URLsForDirectory(.DocumentDirectory, inDomains: .UserDomainMask)
        return urls[urls.count-1] as NSURL
        }()
    
    lazy var managedObjectModel: NSManagedObjectModel = {

        
        let modelURL = NSBundle.mainBundle().URLForResource("ToDoApp", withExtension: "momd")!
        return NSManagedObjectModel(contentsOfURL: modelURL)!
        }()
    
    lazy var persistentStoreCoordinator: NSPersistentStoreCoordinator? = {

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

            NSLog("Unresolved error \(error), \(error!.userInfo)")
            abort()
        }
        
        return coordinator
        }()
    
    lazy var managedObjectContext: NSManagedObjectContext? = {

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

                NSLog("Unresolved error \(error), \(error!.userInfo)")
                abort()
            }
        }
    }

}
