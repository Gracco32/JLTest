//
//  JLRequestEndpoints.swift
//  JLTest
//
//  Created by Fabio on 24/12/2016.
//  Copyright © 2016 Fabio. All rights reserved.
//

import Foundation

class JLRequestEndpoints: NSObject {
    
    private var requestSender: JLRequestSender
    
    init(requestSender: JLRequestSender) {
        
        self.requestSender = requestSender
    }
    
    /**
     Send the request to get the products.
     */
    func getProducts(pageSize: Int = 20) {
        requestSender.sendDataRequest(method: "GET", endpoint: "v1/products/search?q=dishwasher&key=Wu1Xqn3vNrd1p7hqkvB6hEu0G9OrsYGb&pageSize=\(pageSize)", type: .GetProducts)
    }
    
    /**
     Send the request to get product details.
     */
    func getProductDetails(productId: String) {
        requestSender.sendDataRequest(method: "GET", endpoint: "v1/products/\(productId)?key=Wu1Xqn3vNrd1p7hqkvB6hEu0G9OrsYGb", type: .GetProductDetails)
    }
    
}
