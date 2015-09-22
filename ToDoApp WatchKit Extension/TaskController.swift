//
//  TaskController.swift
//  ToDoApp
//
//  Created by Dhvl on 22/09/15.
//  Copyright (c) 2015 Dhvl. All rights reserved.
//

import WatchKit
import Foundation


class TaskController: WKInterfaceController {

    @IBOutlet weak var taskButton: WKInterfaceButton!
    @IBOutlet weak var hourLabel: WKInterfaceLabel!
    @IBOutlet weak var minuteLabel: WKInterfaceLabel!
    
    @IBOutlet weak var doneButton: WKInterfaceButton!
    
    var taskName:String?
    var startHour:Int = 0
    var startMinute : Int = 0
    
    override func awakeWithContext(context: AnyObject?) {
        super.awakeWithContext(context)
        
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

    @IBAction func onActivity() {


        self.presentTextInputControllerWithSuggestions([
            "Wake up",
            "Exercise",
            "Bath",
            "Breakfast",
            "Reach to Office",
            "Meeting",
            "Work",
            "Lunch",
            "Return Home",
            "Dinner",
            "Read a Book",
            "Internet Surfing",
            "Sleep"], allowedInputMode: WKTextInputMode.Plain, completion:{(selectedAnswers) -> Void  in
                if let taskName = selectedAnswers?[0] as? String {
                    if let taskName = selectedAnswers?[0] as? String {
                        self.taskName = taskName
                        self.taskButton!.setTitle(taskName)
                        self.doneButton!.setEnabled(true)
                        self.doneButton!.setHidden(false)
                        
                    }
                }
        })
    }
    
    @IBAction func onHour(value: Float) {
        self.startHour = Int(floor(value))
        self.hourLabel!.setText("\(self.startHour)")
    }
    
    @IBAction func onMinute(value: Float) {
        self.startMinute = Int(floor(value))
        self.minuteLabel!.setText("\(self.startMinute)")
    }
    
    @IBAction func onDone() {
        if let name = self.taskName {
            TaskStack.sharedInstance.createTask(name, startHour: startHour, startMinute: startMinute)
            TaskStack.sharedInstance.saveContext()
        }
        self.dismissController()
    }
    
}
