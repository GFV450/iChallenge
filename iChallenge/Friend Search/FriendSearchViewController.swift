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
            controller.searchBar.barTintColor = UIColor.white
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

    func numberOfSections(in tableView: UITableView) -> Int
    {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        //Returns the number of rows depending if you're filtering users with the resultSearchController
        if (self.resultSearchController.isActive)
        {
            return self.filteredTableData.count
        }
        else
        {
            return userArray.count
        }
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FriendCell", for: indexPath) as! FriendSearchViewCell
        
        if (self.resultSearchController.isActive)
        {
            //Returns the relevant cell in the search bar controller
            let filteredUser = filteredTableData[(indexPath as NSIndexPath).row]
            let profileImageNSURL = URL(string: filteredUser.profileImage)
            
            cell.nameLabel?.text = filteredUser.name
            cell.profileImageView.sd_setImage(with: profileImageNSURL)
            
            return cell
        }
        else
        {
            //Fills the search TableView with the users on the app
            let user = userArray[(indexPath as NSIndexPath).row]
            let profileImageURL = URL(string: user.profileImage)
            
            //Sets the information relevant to the cell on the TableView
            cell.profileImageView!.sd_setImage(with: profileImageURL)
            cell.profileImageView.layer.cornerRadius = cell.profileImageView.frame.size.width/2
            cell.userID = user.userID
            cell.nameLabel?.text = user.name
            
            let friend = searchFriends(user)
            
            if(friend == true)
            {
                cell.addFriendButton.isSelected = true
            }
            
            return cell
        }
    }
    
    func searchFriends(_ user: User) -> Bool
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
    
    func updateSearchResults(for searchController: UISearchController)
    {
        filteredTableData.removeAll(keepingCapacity: false)
        
        filteredTableData = userArray.filter { (user) -> Bool in
            user.name.contains(searchController.searchBar.text!)
        }
        
        self.friendSearchTableView.reloadData()
    }
    
    @IBAction func addFriendButtonPressed(_ sender: AnyObject)
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
        
        if(button.isSelected == false)
        {
            button.isSelected = true
            FirebaseHelper.addFriend(currentUserID, friendID: friendID, friendName: friendName)
        }
        else
        {
            button.isSelected = false
            FirebaseHelper.removeFriend(currentUserID, friendID: friendID)
        }
    }
    
    @IBAction func dismissButtonPressed(_ sender: AnyObject)
    {
        self.presentingViewController?.dismiss(animated: true, completion: nil)
    }
}
