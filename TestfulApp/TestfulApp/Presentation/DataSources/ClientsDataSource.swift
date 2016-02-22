//
//  ClientsDataSource.swift
//  TestfulApp
//
//  Created by Andrey Morichev on 17/02/16.
//  Copyright © 2016 Andrey Morichev. All rights reserved.
//

import UIKit

class ClientsDataSource: NSObject, UITableViewDataSource {

    private enum CellIdentifiers : String {
        case ClientCell = "clientCellIdentifier"
    }
    
    var clients: [Client]?
    var imageProvider: ImageProvider?
    
    func configureTableView(tableView: UITableView) {
        tableView.registerNib(ClientTableViewCell.cellNib(), forCellReuseIdentifier: CellIdentifiers.ClientCell.rawValue)
    }
    
    func heightForRow(indexPath: NSIndexPath, tableView: UITableView) -> CGFloat {
        let message = self.clients?[indexPath.row].getLastMessage()?.text ?? ""
        return ClientTableViewCell.calculateHeight(message, width: tableView.frame.size.width)
    }
    
    //MARK: UITableViewDataSource
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let clients = self.clients {
            return clients.count
        } else {
            return 0
        }
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(CellIdentifiers.ClientCell.rawValue, forIndexPath: indexPath) as! ClientTableViewCell
        if let client = self.clients?[indexPath.row] {
            cell.configure(client)
            if let imageProvider = self.imageProvider, let imageUrl = client.avatarUrl {
                imageProvider.provideImage(imageUrl, completition: { (image, error) -> Void in
                    self.setImage(image, forCellAtIndexPath: indexPath, inTableView: tableView)
                })
            }
        }
        return cell
    }
    
    //MARK: private utils
    
    func setImage(image: UIImage?, forCellAtIndexPath indexPath: NSIndexPath, inTableView tableView: UITableView) {
        guard let image = image, let cell = tableView.cellForRowAtIndexPath(indexPath) as? ClientTableViewCell else {
            return
        }
        
        cell.setImageForAvatar(image)
    }
    
}
