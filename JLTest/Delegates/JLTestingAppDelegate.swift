//
//  JLTestingAppDelegate.swift
//  JLTest
//
//  Created by Fabio on 23/12/2016.
//  Copyright © 2016 Fabio. All rights reserved.
//

import UIKit
import OHHTTPStubs

/**
 This class allow to override the application:didFinishLaunchingWithOptions when the unit tests are running;
 This allow to mock the network requests using the OHHTTPStubs framework.
 */
class JLTestingAppDelegate: AppDelegate {
    
    override  func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        // to initialise core data and logger
        let _ = super.application(application, didFinishLaunchingWithOptions: launchOptions)
        
        //Mock all the network requests for this host
        stub(condition: isHost("https://api.johnlewis.com/")) { _ in
            return OHHTTPStubsResponse(data: Data(), statusCode:200, headers:nil)
        }
        
        return true
    }
    
}
