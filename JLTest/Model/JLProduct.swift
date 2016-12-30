//
//  JLProduct.swift
//  JLTest
//
//  Created by Fabio on 24/12/2016.
//  Copyright © 2016 Fabio. All rights reserved.
//

import Foundation
import CoreData

public class JLProduct: NSManagedObject {
    
    @NSManaged public var productId: String
    @NSManaged public var title: String
    @NSManaged public var image: String

    @NSManaged public var price: JLPrice
    @NSManaged public var productDetails: JLProductDetails
    
}
