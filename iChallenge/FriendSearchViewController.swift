//
//  FriendSearchViewController.swift
//  iChallenge
//
//  Created by Gian Vitola on 7/19/16.
//  Copyright © 2016 Gian Franco Vitola. All rights reserved.
//

import UIKit
import Firebase
import AlamofireImage

class FriendSearchViewController: UITableViewController, UISearchResultsUpdating
{
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
        FirebaseHelper.retrieveUserData({ (user: User) -> Void in
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
            let profileImageURL = NSURL(string: user.profileImage)
            
            cell.profileImageView!.af_setImageWithURL(profileImageURL!)
            cell.userID = user.userID
            cell.nameLabel?.text = user.name
            
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
    @IBAction func addFriendButtonPressed(sender: AnyObject)
    {
        if let user = FIRAuth.auth()?.currentUser
        {
            let button = sender as! UIButton
            let view = button.superview!
            let cell = view.superview as! FriendSearchViewCell
            
            let currentUserID = user.uid
            let friendName = cell.nameLabel.text!
            let friendID = cell.userID
            
            FirebaseHelper.addFriend(currentUserID, friendID: friendID, friendName: friendName)
        }
        else
        {
            print("No user is logged in")
        }
    }
}
