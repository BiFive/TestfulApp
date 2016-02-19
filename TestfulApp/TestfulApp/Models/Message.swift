//
//  Message.swift
//  TestfulApp
//
//  Created by Andrey Morichev on 13/02/16.
//  Copyright © 2016 Andrey Morichev. All rights reserved.
//

import UIKit

class Message: NSObject {
    
    enum FieldTag : String {
        case Text = "text"
        case SendingDate = "date"
    }
    
    let text: String
    let date: NSDate
    
    init(dictionary : [FieldTag : AnyObject]) {
        self.text = dictionary.getValueForKey(.Text, withDefaultValue: "")
        self.date = dictionary.getValueForKey(.SendingDate, withDefaultValue: NSDate(timeIntervalSince1970: 0))
        super.init()
    }
}
