//
//  JLRequestEndpointsTest.swift
//  JLTest
//
//  Created by Fabio on 24/12/2016.
//  Copyright © 2016 Fabio. All rights reserved.
//

import XCTest
import OHHTTPStubs
import DATAStack
@testable import JLTest

class JLRequestEndpointsTest: XCTestCase, JLNetworkDelegate {
    
    var requestFactory: JLRequestFactory!
    var dataStack : DATAStack!
    var dataHelper: JLDataHelper!
    var parser : JLResponseParser!
    var requestSender: JLRequestSender!
    var apiInterface: JLRequestEndpoints!
    
    var expectation: XCTestExpectation!
    
    override func setUp() {
        super.setUp()
        
        // Initialise the apiInterface
        class JLRequestFactoryMock: JLRequestFactory {
            
            override func dataRequestWithMethod(method: String, endpoint: String) -> URLRequest? {
                
                let url = URL(string: "https://www.testendpoint.com/test1")!
                let request = URLRequest.init(url: url as URL)
                return request
            }
        }

        // Initialise the requestSender with mocks
        requestFactory = JLRequestFactoryMock()
        parser = JLResponseParser()
        
        dataStack = DATAStack(modelName: "JLTest", storeType: .inMemory)
        dataHelper = JLDataHelper(dataStack: dataStack)
        
        requestSender = JLRequestSender(requestFactory: requestFactory, parser: parser, dataHelper: dataHelper, delegate: self)
        
        apiInterface = JLRequestEndpoints(requestSender: requestSender)
        
        // Stub URLSession
        stub(condition: isHost("www.testendpoint.com")) { _ in
            return OHHTTPStubsResponse(data: "{}".data(using: .utf8)!, statusCode:200, headers:nil)
        }
    }
    
    override func tearDown() {
        
        // Remove everything
        OHHTTPStubs.removeAllStubs()
        
        super.tearDown()
        
    }
    
    func testGetProducts() {
        
        expectation = expectation(description: "productsRequestExpectation")
        
        apiInterface.getProducts()
        
        waitForExpectations(timeout: 5) { error in
            // timeout is automatically treated as a failed test
        }
    }
    
    func testGetProductDetails() {
        
        expectation = expectation(description: "productDetailsRequestExpectation")
        
        apiInterface.getProductDetails(productId: "testId")
        
        waitForExpectations(timeout: 5) { error in
            // timeout is automatically treated as a failed test
        }
    }
    
    //MARK: JLNetworkDelegate
    
    func requestProcessed(type: JLRequestType, data: Dictionary<String, AnyObject>) {
        
        if type == .GetProducts && expectation.description == "productsRequestExpectation" {
            expectation.fulfill()
        }
        
        if type == .GetProductDetails && expectation.description == "productDetailsRequestExpectation" {
            expectation.fulfill()
        }

    }
    
    func requestFailed(type: JLRequestType, httpCode: Int?) {
        XCTFail()
    }
    
}
