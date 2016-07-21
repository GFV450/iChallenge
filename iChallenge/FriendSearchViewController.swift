//
//  FriendSearchViewController.swift
//  iChallenge
//
//  Created by Gian Vitola on 7/19/16.
//  Copyright © 2016 Gian Franco Vitola. All rights reserved.
//

import UIKit
import Firebase

class FriendSearchViewController: UITableViewController, UISearchResultsUpdating {
    var userArray = [User]()
    var filteredTableData = [User]()
    var resultSearchController = UISearchController()
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        self.retrieveUsers()
        
        self.resultSearchController =
        ({
            let controller = UISearchController(searchResultsController: nil)
            controller.searchResultsUpdater = self
            controller.dimsBackgroundDuringPresentation = false
            controller.searchBar.sizeToFit()
            
            self.tableView.tableHeaderView = controller.searchBar
            
            return controller
        })()
        
        // Reload the table
        self.tableView.reloadData()
    }
    
    func retrieveUsers()
    {
        let object = FirebaseHelper()
        
//         1. closure in parameter list
        object.retrieveUserData({ (user: User) -> Void in
            self.userArray.append(user)
            self.tableView.reloadData()
        })
    }
    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int
    {
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        if (self.resultSearchController.active)
        {
            return self.filteredTableData.count
        }
        else
        {
            return userArray.count
        }
    }
    
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCellWithIdentifier("FriendCell", forIndexPath: indexPath) as! FriendSearchViewCell
        
        if (self.resultSearchController.active)
        {
            cell.nameLabel?.text = filteredTableData[indexPath.row].name
            
            return cell
        }
        else
        {
            let user = userArray[indexPath.row]
            // TO DO: Look into af async image loading
//            let profileImageURL = NSURL(string: user.profileImage)
//            let userProfileImage = NSData(contentsOfURL: profileImageURL!)
            
//            if userProfileImage != nil
//            {
//                cell.imageView!.image = UIImage(data : userProfileImage!)
//            }
            
            cell.textLabel?.text = user.name
            
            return cell
        }
    }
    
    func updateSearchResultsForSearchController(searchController: UISearchController)
    {
        filteredTableData.removeAll(keepCapacity: false)
        
        filteredTableData = userArray.filter { (user) -> Bool in
            user.name.containsString(searchController.searchBar.text!)
        }
        
        self.tableView.reloadData()
    }

}
