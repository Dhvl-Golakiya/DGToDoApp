//
//  Extension.swift
//  SMEApp
//
//  Created by Dhaval.Golakiya on 02/06/15.
//  Copyright (c) 2015 Dhaval.Golakiya. All rights reserved.
//

import Foundation
import UIKit

extension String {
    func trim() -> String {
        return stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceCharacterSet())
    }
    
    func trimForNewLineCharacterSet() -> String {
        return stringByTrimmingCharactersInSet(NSCharacterSet.newlineCharacterSet())
    }
    
    var makeArray : NSArray! {
        return self.componentsSeparatedByString(",")
    }
    
    subscript (i: Int) -> Character {
        return self[advance(self.startIndex, i)]
    }
    
    subscript (i: Int) -> String {
        return String(self[i] as Character)
    }
    
    var toDictionary : NSDictionary! {
        let data = dataUsingEncoding(NSUTF8StringEncoding)
        var jsonError : NSError?
        return NSJSONSerialization.JSONObjectWithData(data!, options: nil, error: &jsonError) as? NSDictionary
    }
    
}


class ArrayInfo {
    let key : String
    let withClass : AnyClass
    let forClass : AnyClass
    
    init(key : String, withClass : AnyClass, forClass : AnyClass) {
        self.key = key
        self.withClass = withClass
        self.forClass = forClass
    }
}



extension UIFont {
    convenience init?(fontname: String , fontSize: CGFloat) {
        self.init(name:fontname, size:fontSize)
    }
}




extension NSDate {
    var timeIntervalSince1970Millis : Int64 {
        return Int64  (timeIntervalSince1970) * 1000
    }
    
    func formateDateFull(date:NSDate) -> String {
        let formatter = NSDateFormatter()
        formatter.dateFormat = "MMM dd, yyyy"
        return formatter.stringFromDate(date)
    }
    
}


public func getUniqueId() -> String {
    return NSUUID().UUIDString
}





