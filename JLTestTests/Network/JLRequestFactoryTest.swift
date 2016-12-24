//
//  JLRequestFactoryTest.swift
//  JLTest
//
//  Created by Fabio on 23/12/2016.
//  Copyright © 2016 Fabio. All rights reserved.
//

import XCTest
@testable import JLTest

class JLRequestFactoryTest: XCTestCase {
    
    var requestFactory: JLRequestFactory!
    
    override func setUp() {
        super.setUp()
        
        requestFactory = JLRequestFactory()
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testCreateBaseRequest() {
        
        let endpoint = "products"
        let method = "GET"
        
        let request = requestFactory.createBaseRequest(endpoint: endpoint, method: method)
        
        XCTAssert(request != nil, "Request is nil")
        
        if request != nil {
            
            XCTAssert(request!.httpMethod == method, "HTTPMethod is incorrect")
            
            XCTAssert(request!.url?.absoluteString.range(of: endpoint) != nil, "Absolute URL is incorrect")
            
            XCTAssert(request!.allHTTPHeaderFields != nil, "HTTPHeaderFields is empty")
        }
    }
    
    func testDataRequestWithMethod() {
        
        let endpoint = "products"
        let method = "GET"
        
        let request = requestFactory.dataRequestWithMethod(method: method, endpoint: endpoint)
        
        XCTAssert(request != nil, "Request is nil")
        
        if request != nil {
            XCTAssert(request!.allHTTPHeaderFields != nil, "HTTPHeaderFields is empty")
        }
    }

}
