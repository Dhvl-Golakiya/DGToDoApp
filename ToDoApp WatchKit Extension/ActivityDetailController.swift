//
//  ActivityDetailController.swift
//  ToDoApp
//
//  Created by Dhvl on 23/09/15.
//  Copyright (c) 2015 Dhvl. All rights reserved.
//

import WatchKit
import Foundation


class ActivityDetailController: WKInterfaceController {

    @IBOutlet weak var taskNameLabel: WKInterfaceLabel!
    
    @IBOutlet weak var timeLabel: WKInterfaceLabel!
    var task : ToDoApp?
    override func awakeWithContext(context: AnyObject?) {
        super.awakeWithContext(context)
         if let task = context as? ToDoApp {
            self.task = task
            taskNameLabel.setText(task.name)
            timeLabel.setText("Time- " + String(format: "%02d", task.startHour as Int) + ":" + String(format: "%02d", task.startMinute as Int))
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

    @IBAction func onDeleteTask() {
        TaskStack.sharedInstance.deleteTask(self.task!)
        dismissController()
    }
}
