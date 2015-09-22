//
//  HistoryController.swift
//  ToDoApp
//
//  Created by Dhvl on 22/09/15.
//  Copyright (c) 2015 Dhvl. All rights reserved.
//

import WatchKit
import Foundation


class HistoryController: WKInterfaceController {

    @IBOutlet weak var table: WKInterfaceTable!
    
    @IBOutlet weak var noTaskLabel: WKInterfaceLabel!
    var dateArray = [String]()
    
    override func awakeWithContext(context: AnyObject?) {
        super.awakeWithContext(context)
        
     
        
        // Configure interface objects here.
    }
    
    func getData() {
        var taskCount = 0
        if let taskList = TaskStack.sharedInstance.allTasks() as [ToDoApp]? {
            taskCount = taskList.count
            println("Count is: \(taskCount)")
            dateArray = [String]()
            for task in taskList {
                let date = task.startDate
                if !contains(dateArray, date) {
                    dateArray.append(date)
                }
            }
            if dateArray.count != 0 {
                noTaskLabel.setHidden(true)
                self.table.setHidden(false)
                createTableFromActivitiesList(dateArray)
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
    

    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        getData()
        super.willActivate()
    }

    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
    }

    
    private func createTableFromActivitiesList(activitiesList:[String]!) {
        deleteRows()
        // insert the rows first
        self.table.insertRowsAtIndexes(NSIndexSet(indexesInRange: NSMakeRange(0, activitiesList.count)), withRowType: "TaskCell")
        
        // populate the data of each row
        var i = 0
        for date in dateArray {
            
            if let rowInterfaceController = self.table.rowControllerAtIndex(i) as? TaskCell {
                rowInterfaceController.taskNameLabel!.setText(date)
            }
            i++
        }
    }

    
    override func contextForSegueWithIdentifier(segueIdentifier: String, inTable table: WKInterfaceTable, rowIndex: Int) -> AnyObject? {
        let dateTime = dateArray[rowIndex]
        return dateTime
    }
    
    
}
