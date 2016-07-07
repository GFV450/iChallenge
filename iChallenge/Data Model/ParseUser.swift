//
//  ParseUser.swift
//  iChallenge
//
//  Created by Jake on 7/7/16.
//  Copyright © 2016 Gian Franco Vitola. All rights reserved.
//

import Foundation
import Parse
import Bond
import ConvenienceKit

class ParseUser: PFUser {
    
    // MARK: - Properties
    @NSManaged var imageFile: PFFile?
    
    var image: Observable<UIImage?> = Observable(nil)
    
    static var imageCache: NSCacheSwift<String, UIImage>!
    
    // MARK: - Initializers
    override class func initialize() {
        var onceToken: dispatch_once_t = 0;
        dispatch_once(&onceToken) {
            // inform Parse about this subclass
            self.registerSubclass()
            ParseUser.imageCache = NSCacheSwift<String, UIImage>()
        }
    }
    
    // MARK: - Helper Methods
    func downloadImage() {
        image.value = ParseUser.imageCache[self.imageFile!.name]
        
        if (image.value == nil) {
            
            imageFile?.getDataInBackgroundWithBlock { (data: NSData?, error: NSError?) in
                
                if let error = error {
                    ErrorHandling.defaultErrorHandler(error)
                }
                
                if let data = data {
                    let image = UIImage(data: data, scale:1.0)!
                    
                    self.image.value = image
                    
                    ParseUser.imageCache[self.imageFile!.name] = image
                }
            }
        }
    }
    
}
