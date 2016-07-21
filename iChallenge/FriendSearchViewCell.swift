//
//  FriendSearchViewCell.swift
//  iChallenge
//
//  Created by Gian Vitola on 7/19/16.
//  Copyright © 2016 Gian Franco Vitola. All rights reserved.
//

import UIKit

class FriendSearchViewCell: UITableViewCell
{
    @IBOutlet weak var profileImageview: UIView!
    @IBOutlet weak var nameLabel: UILabel!
    
    override func awakeFromNib()
    {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool)
    {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
