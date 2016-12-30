//
//  JLServices.swift
//  JLTest
//
//  Created by Fabio on 30/12/2016.
//  Copyright © 2016 Fabio. All rights reserved.
//

import Foundation
import CoreData

public class JLServices: NSManagedObject {
    
    // Array of included sevices
    @NSManaged public var includedServices: Data
    
    @NSManaged public var productDetails: JLProductDetails
}

