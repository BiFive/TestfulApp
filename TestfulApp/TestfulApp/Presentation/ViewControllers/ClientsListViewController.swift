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
    var imageProvider: ImageProvider?
    
    @IBOutlet var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let imageProvider = ImageProvider()
        self.imageProvider = imageProvider
        
        let dataSource = ClientsDataSource()
        dataSource.imageProvider = imageProvider
        dataSource.configureTableView(self.tableView)
        self.dataSource = dataSource
        
        self.tableView.dataSource = dataSource
        self.tableView.delegate = self
    }

    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        self.updateData()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func updateData() {
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

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
