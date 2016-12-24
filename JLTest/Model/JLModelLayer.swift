//
//  JLModelLayer.swift
//  JLTest
//
//  Created by Fabio on 24/12/2016.
//  Copyright © 2016 Fabio. All rights reserved.
//

import Foundation
import DATAStack

class JLModelLayer: NSObject {
    
    private var dataStack: DATAStack!
    
    init(dataStack: DATAStack) {
        
        self.dataStack = dataStack
    }
    
    
    /**
     Fetch data from the model.
     
     - parameter request:     NSFetchRequest request to execute.
     
     - returns: Data fetched if present, Optional() otherwise.
     
     */
    private func fetchData(request: NSFetchRequest<NSFetchRequestResult>) -> [AnyObject]? {
        
        var result: [AnyObject]?
        
        do {
            result = try self.dataStack.mainContext.fetch(request)
        } catch {
            log.error("fetch failure")
        }
        
        return result
    }
    
    /**
     Check if an entity the model contains any record.
     
     - parameter entityName:     Entity name to check.
     
     - returns: true if there isn't any data, false otherwise.
     
     */
    func isEntityEmpty(entityName: String) -> Bool {
        
        let request: NSFetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
        
        if let entities = fetchData(request: request) as [AnyObject]?, entities.count > 0 {
            return false
        }
        
        return true
    }
    
    /**
     Fetch the JLProducts data from the model.
     
     - returns: Optional array of JLProduct items.
     
     */
    func fetchProducts() -> [JLProduct]? {
        
        let request: NSFetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Product")
        request.sortDescriptors = [NSSortDescriptor(key: "productId", ascending: true)]
        
        if let products = fetchData(request: request) as? [JLProduct] {
            return products
        }
        
        return Optional([])
    }
    
}
