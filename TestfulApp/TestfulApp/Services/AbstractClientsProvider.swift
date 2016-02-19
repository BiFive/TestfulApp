//
//  AbstractClientsProvider.swift
//  TestfulApp
//
//  Created by Andrey Morichev on 16/02/16.
//  Copyright © 2016 Andrey Morichev. All rights reserved.
//

import UIKit

class AbstractClientsProvider: NSObject {
    
    typealias FetchComplitionHanlder = (clients: [Client]?, error: NSError?) -> Void
    
    func fetchClients(completitionHandler: FetchComplitionHanlder) {}
    
}
