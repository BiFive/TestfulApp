//
//  ClientsListViewController.swift
//  TestfulApp
//
//  Created by Andrey Morichev on 17/02/16.
//  Copyright © 2016 Andrey Morichev. All rights reserved.
//

import UIKit

class ClientsListViewController: UIViewController, UITableViewDelegate {

    var dataSource: ClientsDataSource?
    var clientsProvider: AbstractClientsProvider?
    
    @IBOutlet var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let dataSource = ClientsDataSource()
        dataSource.imageProvider = ImageProvider()
        dataSource.configureTableView(self.tableView)
        self.dataSource = dataSource
        
        self.tableView.dataSource = dataSource
        self.tableView.delegate = self
        
        self.setupTitle()
    }

    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        self.updateData()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    private func setupTitle() {
        let label = UILabel(frame: CGRectZero)
        label.text = NSLocalizedString("ClientsList.Title.Chats", comment: "Title for clients list screen")
        label.textColor = UIColor(red: 252.0/255.0, green: 101.0/255.0, blue: 84.0/255.0, alpha: 1.0)
        label.sizeToFit()
        
        self.navigationItem.titleView = label
    }
    
    private func updateData() {
        guard let clientsProvider = self.clientsProvider else {
            return
        }
        
        clientsProvider.fetchClients { (clients, error) -> Void in
            if let clients = clients, let dataSource = self.dataSource {
                dataSource.clients = clients
                self.tableView.reloadData()
            }
        }
    }
    
    // MARK: - UITableViewDelegate
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        guard let dataSource = self.dataSource else {
            return 0
        }
        return dataSource.heightForRow(indexPath, tableView: tableView)
    }

}
