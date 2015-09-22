//
//  InterfaceController.swift
//  ToDoApp WatchKit Extension
//
//  Created by Dhvl on 22/09/15.
//  Copyright (c) 2015 Dhvl. All rights reserved.
//

import WatchKit
import Foundation


class InterfaceController: WKInterfaceController {

    override func awakeWithContext(context: AnyObject?) {
        super.awakeWithContext(context)
        
        var activitiesCount = 0
        if let activitiesList = TaskStack.sharedInstance.allTasks() as [ToDoApp]?{
            activitiesCount = activitiesList.count
            println("Count is: \(activitiesCount)")
        }
        // Configure interface objects here.
    }

    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()
    }

    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
    }

}
