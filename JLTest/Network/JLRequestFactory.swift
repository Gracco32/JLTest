//
//  JLRequestFactory.swift
//  JLTest
//
//  Created by Fabio on 23/12/2016.
//  Copyright © 2016 Fabio. All rights reserved.
//

import UIKit
import XCGLogger

class JLRequestFactory {
    
    private let baseUrl = "https://api.johnlewis.com/"
    
    /**
     Base function for creating all kinds of API requests.
     
     - parameter endpoint: Relative path to API endpoint.
     - parameter method:   HTTP method string, either "GET", "PUT", "POST" or "DELETE".
     
     - returns: The newly created base request.
     */
    func createBaseRequest(endpoint: String, method: String) -> NSMutableURLRequest? {
        
        let urlString = "\(baseUrl)\(endpoint)"
        
        if let escapedString = urlString.addingPercentEncoding(withAllowedCharacters:NSCharacterSet.urlQueryAllowed),
            let url = NSURL(string: escapedString) {
            
            let baseRequest = NSMutableURLRequest(url: url as URL, cachePolicy: .reloadIgnoringLocalCacheData , timeoutInterval: 10.0)
            
            baseRequest.httpMethod = method
            
            return baseRequest
        }
        
        log.error("Bad URL string: \(self.baseUrl)\(endpoint)")
        
        return nil
    }
    
    /**
     Create API data request. Request params are added to body.
     
     - parameter method:   HTTP method string, either "GET", "PUT", "POST".
     - parameter endpoint: Relative path to API endpoint.
     
     - returns: The newly created request.
     */
    func dataRequestWithMethod(method: String, endpoint: String) -> NSURLRequest? {
        
        if let request = self.createBaseRequest(endpoint: endpoint, method: method) {
            
            if request.allHTTPHeaderFields?["Content-Type"] == nil {
                request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            }
            
            return request;
        }
        
        return nil
    }
    
    
    
}
