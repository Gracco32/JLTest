//
//  JLResponseParser.swift
//  JLTest
//
//  Created by Fabio on 24/12/2016.
//  Copyright © 2016 Fabio. All rights reserved.
//

import Foundation
import XCGLogger

class JLResponseParser {
    
    /**
     Parse data and save it into the model.
     
     - parameter data:     Data received from a request.
     
     - returns: The parsed data if it's a valid json format, Optional() otherwise.
     
     */
    func parse(data: Data) -> AnyObject? {
        
        var json: [String: AnyObject]? = nil
        
        let datastring = NSString(data: data, encoding: String.Encoding.utf8.rawValue)
        log.debug(datastring as? String)
        
        do {
            json = try JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions()) as? Dictionary<String,AnyObject>
        } catch {
            log.error("JSONSerialization failure!")
            print(error)
        }
        
        return json as AnyObject?
    }
    
}
