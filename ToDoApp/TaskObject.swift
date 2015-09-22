//
//  TaskObject.swift
//  ToDoApp
//
//  Created by Dhvl on 22/09/15.
//  Copyright (c) 2015 Dhvl. All rights reserved.
//

import Foundation
import CoreData

@objc(ToDoApp)

public class ToDoApp : NSManagedObject {
    @NSManaged public var taskId: String
    @NSManaged public var startHour: NSNumber
    @NSManaged public var startMinute: NSNumber
    @NSManaged public var name: String
    @NSManaged public var startDate: String
    
    override init(entity: NSEntityDescription, insertIntoManagedObjectContext context: NSManagedObjectContext?){
        super.init(entity: entity, insertIntoManagedObjectContext:context)
    }
}
