//
//  OneDayTaskController.swift
//  ToDoApp
//
//  Created by Dhvl on 23/09/15.
//  Copyright (c) 2015 Dhvl. All rights reserved.
//

import WatchKit
import Foundation


class OneDayTaskController: WKInterfaceController {
    
    @IBOutlet weak var noTaskLabel: WKInterfaceLabel!
    @IBOutlet weak var table: WKInterfaceTable!
    
    var taskList = [ToDoApp]()
    var date : String!
    
    override func awakeWithContext(context: AnyObject?) {
        super.awakeWithContext(context)
        
        if let date = context as? String {
            self.date = date
            
        }
        // Configure interface objects here.
    }
    
    
    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        getData()
        super.willActivate()
    }
    
    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
    }
    
    func getData() {
        taskList = [ToDoApp]()
        if let taskList = TaskStack.sharedInstance.oneDayTasks(date) as [ToDoApp]? {
            self.taskList = taskList
            if self.taskList.count != 0 {
                noTaskLabel.setHidden(true)
                self.table.setHidden(false)
                createTableFromTaskList()
            }
            else {
                noTaskLabel.setHidden(false)
                self.table.setHidden(true)
            }
        }
    }
    
    func deleteRows() {
        self.table.removeRowsAtIndexes(NSIndexSet(indexesInRange: NSMakeRange(0, self.table.numberOfRows)))
    }
    private func createTableFromTaskList() {
        deleteRows()
        // insert the rows first
        self.table.insertRowsAtIndexes(NSIndexSet(indexesInRange: NSMakeRange(0, taskList.count)), withRowType: "TaskCell")
        
        // populate the data of each row
        var i = 0
        for task in taskList {
            
            if let rowInterfaceController = self.table.rowControllerAtIndex(i) as? TaskCell {
                rowInterfaceController.taskNameLabel!.setText(task.name)
            }
            i++
        }
    }
    
    override func contextForSegueWithIdentifier(segueIdentifier: String, inTable table: WKInterfaceTable, rowIndex: Int) -> AnyObject? {
        let task = taskList[rowIndex]
        return task
    }
    
    
}
