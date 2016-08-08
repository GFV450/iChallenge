//
//  MainChallengesCollectionViewCell.swift
//  iChallenge
//
//  Created by Gian Vitola on 8/6/16.
//  Copyright © 2016 Gian Franco Vitola. All rights reserved.
//

import UIKit

class MainChallengesCollectionViewCell: UICollectionViewCell
{
    @IBOutlet weak var challengerImage: UIImageView!
    @IBOutlet weak var challengeName: UILabel!
    @IBOutlet weak var challengerName: UILabel!
    
    var challengeDescription: String?
    var challenge: Challenge?
}