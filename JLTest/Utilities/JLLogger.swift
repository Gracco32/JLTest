//
//  JLLogger.swift
//  JLTest
//
//  Created by Fabio on 24/12/2016.
//  Copyright © 2016 Fabio. All rights reserved.
//

import Foundation
import XCGLogger

class JLLogger {
    
    static func networkRequestLog(request: URLRequest, type: JLRequestType) {
        //logging
        if let httpBody = request.httpBody {
            var bodyStr = ""
            if (httpBody.count > 5000) {
                bodyStr = "<\(httpBody.count / 1024) kBytes of data>"
            }
            else if let bodyStrUnwrapped = NSString(data: httpBody, encoding:String.Encoding.utf8.rawValue) as? String {
                bodyStr = bodyStrUnwrapped;
            }
            
            log.debug("\(request.httpMethod) -> \(request.url?.absoluteString)\n type:\(type.rawValue), JSON:\n \(bodyStr)")
        }
        else {
            log.debug("\(request.httpMethod) -> \(request.url?.absoluteString)\n type:\(type.rawValue)")
        }
    }
    
}
