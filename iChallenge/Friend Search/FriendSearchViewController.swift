//
//  FriendSearchViewController.swift
//  iChallenge
//
//  Created by Gian Vitola on 7/19/16.
//  Copyright © 2016 Gian Franco Vitola. All rights reserved.
//

import UIKit
import Firebase
import SDWebImage

class FriendSearchViewController: UIViewController, UISearchResultsUpdating, UITableViewDataSource, UITableViewDelegate
{
    var userArray = [User]()
    var friendArray = [String]()
    var filteredTableData = [User]()
    var resultSearchController = UISearchController()
    
    @IBOutlet weak var friendSearchTableView: UITableView!
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        self.retrieveUsers()
        
        //Defines the state of the resultSearchController
        self.resultSearchController =
        ({
            let controller = UISearchController(searchResultsController: nil)
            controller.searchResultsUpdater = self
            controller.dimsBackgroundDuringPresentation = false
            controller.searchBar.sizeToFit()
            controller.searchBar.barTintColor = UIColor .whiteColor()
            friendSearchTableView.tableHeaderView = controller.searchBar
            
            return controller
        })()
    }
    
    func retrieveUsers()
    {
        //Pass closure as a parameter to load data being fetched asynchronously in real time
        FirebaseHelper.queryUserData({ [weak self] (user: User) -> Void in
            
            //Appends the user retrieved from the Database on userArray
            self?.userArray.append(user)
            
            self?.retrieveFriends()
            
            self?.friendSearchTableView.reloadData()
        })
    }
    
    func retrieveFriends()
    {
        //Pass closure as a parameter to load data being fetched asynchronously in real time
        FirebaseHelper.queryFriendID({ (userID: String) -> Void in
            
            //Appends the user retrieved from the Database on userArray
            self.friendArray.append(userID)
        })
    }
    
    // MARK: - Table view data source

    func numberOfSectionsInTableView(tableView: UITableView) -> Int
    {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        //Returns the number of rows depending if you're filtering users with the resultSearchController
        if (self.resultSearchController.active)
        {
            return self.filteredTableData.count
        }
        else
        {
            return userArray.count
        }
    }
    
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCellWithIdentifier("FriendCell", forIndexPath: indexPath) as! FriendSearchViewCell
        
        if (self.resultSearchController.active)
        {
            //Returns the relevant cell in the search bar controller
            let filteredUser = filteredTableData[indexPath.row]
            let profileImageNSURL = NSURL(string: filteredUser.profileImage)
            
            cell.nameLabel?.text = filteredUser.name
            cell.profileImageView.sd_setImageWithURL(profileImageNSURL)
            
            return cell
        }
        else
        {
            //Fills the search TableView with the users on the app
            let user = userArray[indexPath.row]
            let profileImageURL = NSURL(string: user.profileImage)
            
            //Sets the information relevant to the cell on the TableView
            cell.profileImageView!.sd_setImageWithURL(profileImageURL)
            cell.profileImageView.layer.cornerRadius = cell.profileImageView.frame.size.width/2
            cell.userID = user.userID
            cell.nameLabel?.text = user.name
            
            let friend = searchFriends(user)
            
            if(friend == true)
            {
                cell.addFriendButton.selected = true
            }
            
            return cell
        }
    }
    
    func searchFriends(user: User) -> Bool
    {
        for friend in friendArray 
        {
            if(user.userID == friend)
            {
                return true
            }
        }
        
        return false
    }
    
    func updateSearchResultsForSearchController(searchController: UISearchController)
    {
        filteredTableData.removeAll(keepCapacity: false)
        
        filteredTableData = userArray.filter { (user) -> Bool in
            user.name.containsString(searchController.searchBar.text!)
        }
        
        self.friendSearchTableView.reloadData()
    }
    
    @IBAction func addFriendButtonPressed(sender: AnyObject)
    {
        //Retrieved logged-in user
        let user = (FIRAuth.auth()?.currentUser)!
        
        //Creates a reference to the specific cell where the button was pressed
        let button = sender as! UIButton
        let view = button.superview!
        let cell = view.superview as! FriendSearchViewCell
        
        //Places the relevant information from the current user and the friend to add in constants
        let currentUserID = user.uid
        let friendName = cell.nameLabel.text!
        let friendID = cell.userID
        
        if(button.selected == false)
        {
            button.selected = true
            FirebaseHelper.addFriend(currentUserID, friendID: friendID, friendName: friendName)
        }
        else
        {
            button.selected = false
            FirebaseHelper.removeFriend(currentUserID, friendID: friendID)
        }
    }
    
    @IBAction func dismissButtonPressed(sender: AnyObject)
    {
        self.presentingViewController?.dismissViewControllerAnimated(true, completion: nil)
    }
}
