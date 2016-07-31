//
//  MainCollectionViewCell.swift
//  iChallenge
//
//  Created by Jake on 7/6/16.
//  Copyright © 2016 Gian Franco Vitola. All rights reserved.
//

import UIKit

class MainCollectionViewCell: UICollectionViewCell
{
    // MARK: - IBOutlets
    @IBOutlet weak var challengerImage: UIImageView!
    @IBOutlet weak var challengeName: UILabel!
    
    var challengeDescription: String = ""
    
}
