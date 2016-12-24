//
//  JLPrice.swift
//  JLTest
//
//  Created by Fabio on 24/12/2016.
//  Copyright © 2016 Fabio. All rights reserved.
//

import Foundation
import CoreData

public class JLPrice: NSManagedObject {
    
    @NSManaged public var was: String
    @NSManaged public var then1: String
    @NSManaged public var then2: String
    @NSManaged public var now: String
    @NSManaged public var uom: String
    @NSManaged public var currency: String
    
    @NSManaged public var product: JLProduct
}
