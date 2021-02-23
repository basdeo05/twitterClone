//
//  HomeTableViewController.swift
//  Twitter
//
//  Created by Richard Basdeo on 2/23/21.
//  Copyright © 2021 Dan. All rights reserved.
//

import UIKit

class HomeTableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    //when user clicks logout button
    @IBAction func onLogout(_ sender: UIBarButtonItem) {
        TwitterAPICaller.client?.logout()
        //screen will dismiss itself
        self.dismiss(animated: true, completion: nil)
    }
    

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 0
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 0
    }
}
