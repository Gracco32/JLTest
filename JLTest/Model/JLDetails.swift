//
//  JLDetails.swift
//  JLTest
//
//  Created by Fabio on 30/12/2016.
//  Copyright © 2016 Fabio. All rights reserved.
//

import Foundation
import CoreData

public class JLDetails: NSManagedObject {
    
    @NSManaged public var productInformation: String
    @NSManaged public var features: Data
    
    @NSManaged public var productDetails: JLProductDetails
}
