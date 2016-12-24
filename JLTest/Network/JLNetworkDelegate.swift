//
//  JLNetworkDelegate.swift
//  JLTest
//
//  Created by Fabio on 23/12/2016.
//  Copyright © 2016 Fabio. All rights reserved.
//

import Foundation

public protocol JLNetworkDelegate: AnyObject {
    
    func requestProcessed(type: JLRequestType, data: Dictionary<String, AnyObject>)
    func requestFailed(type: JLRequestType, httpCode: Int?)
    
}
