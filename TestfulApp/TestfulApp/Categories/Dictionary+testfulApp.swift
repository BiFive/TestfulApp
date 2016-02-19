//
//  Dictionary+testfulApp.swift
//  TestfulApp
//
//  Created by Andrey Morichev on 13/02/16.
//  Copyright © 2016 Andrey Morichev. All rights reserved.
//

import UIKit

extension Dictionary {
    func getValueForKey<T>(key: Key, withDefaultValue defaultValue: T) -> T {
        if let value = self[key] as? T {
            return value
        } else {
            return defaultValue
        }
    }
}
