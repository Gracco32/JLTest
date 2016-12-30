//
//  JLMedia.swift
//  JLTest
//
//  Created by Fabio on 30/12/2016.
//  Copyright © 2016 Fabio. All rights reserved.
//

import Foundation
import CoreData

public class JLMedia: NSManagedObject {
    
    @NSManaged public var images: JLImages
    @NSManaged public var productDetails: JLProductDetails
}
