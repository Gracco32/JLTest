//
//  JLImages.swift
//  JLTest
//
//  Created by Fabio on 30/12/2016.
//  Copyright © 2016 Fabio. All rights reserved.
//

import Foundation
import CoreData

public class JLImages: NSManagedObject {
    
    // array of url strings
    @NSManaged public var urls: Data

    @NSManaged public var media: JLMedia
}

