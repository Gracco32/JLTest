//
//  JLProductDetails.swift
//  JLTest
//
//  Created by Fabio on 30/12/2016.
//  Copyright © 2016 Fabio. All rights reserved.
//

import Foundation
import CoreData

public class JLProductDetails: NSManagedObject {
    
    @NSManaged public var productId: String
    @NSManaged public var title: String
    @NSManaged public var displaySpecialOffer: String
    @NSManaged public var code: String
    
    @NSManaged public var product: JLProduct
    @NSManaged public var media: JLMedia
    @NSManaged public var additionalServices: JLServices
    @NSManaged public var price: JLPrice
    @NSManaged public var details: JLDetails
}
