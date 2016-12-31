//
//  JLDataHelper.swift
//  JLTest
//
//  Created by Fabio on 24/12/2016.
//  Copyright © 2016 Fabio. All rights reserved.
//

import Foundation
import DATAStack
import Sync

class JLDataHelper: NSObject {
    
    private var dataStack: DATAStack!
    
    init(dataStack: DATAStack) {
        
        self.dataStack = dataStack
    }
    
    /**
     Save data into the model.
     
     - parameter json:               Parsed json to save.
     - parameter type:               Enum of type JLRequestType.
     - parameter completion:         Returns error != nil if any problem occours during the operation.
     */
    func saveData(json: [String: AnyObject] , type: JLRequestType, completion: @escaping (_ error: Error?) -> Void) {
        
        var entityName = ""
        var jsonValues : [[String: AnyObject]] = [json]
        
        switch type {
        case .GetProducts:
            entityName =  "Product"
            if json.keys.contains("products") {
                jsonValues = json["products"] as! [[String : AnyObject]]
            }
        case .GetProductDetails:
            entityName = "ProductDetails"
        default:
            entityName = ""
        }
        
        Sync.changes(
            jsonValues,
            inEntityNamed: entityName,
            dataStack: dataStack,
            operations: [.Insert,.Update]) { error in
                
                log.debug("Save operation completed")
                
                if error == nil {
                    completion(nil)
                } else {
                    completion(error)
                }
        }
        
    }
    
}
