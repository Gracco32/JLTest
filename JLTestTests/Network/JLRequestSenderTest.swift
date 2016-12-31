//
//  JLRequestSenderTest.swift
//  JLTest
//
//  Created by Fabio on 23/12/2016.
//  Copyright © 2016 Fabio. All rights reserved.
//

import XCTest
import OHHTTPStubs
import DATAStack
@testable import JLTest

class JLRequestSenderTest: XCTestCase, JLNetworkDelegate {
    
    var requestFactory: JLRequestFactory!
    var dataStack : DATAStack!
    var dataHelper: JLDataHelper!
    var parser : JLResponseParser!
    var requestSender: JLRequestSender!
    
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
        
        requestFactory = JLRequestFactoryMock()
        parser = JLResponseParser()
        
        dataStack = DATAStack(modelName: "JLTest", storeType: .inMemory)
        dataHelper = JLDataHelper(dataStack: dataStack)
        
        requestSender = JLRequestSender(requestFactory: requestFactory, parser: parser, dataHelper: dataHelper, delegate: self)
    }
    
    override func tearDown() {
        
        // Remove everything
        OHHTTPStubs.removeAllStubs()
        
        super.tearDown()
    }
    
    func testSendDataRequest() {
        
        stub(condition: isHost("www.testendpoint.com")) { request in
            // Stub it with test.json stub file
            return OHHTTPStubsResponse(
                fileAtPath: OHPathForFile("test.json", type(of: self))!,
                statusCode: 200,
                headers: ["Content-Type":"application/json"]
            )
        }
        
        expectation = expectation(description: "requestExpectation")
        
        requestSender.sendDataRequest(method: "GET", endpoint: "", type: .GetProducts)
        
        waitForExpectations(timeout: 5) { error in
            // timeout is automatically treated as a failed test
        }
    }
    
    func testSendRequestFailWrongFormat() {
        
        // simulate wrong format json
        let jsonWrongFormat = "{>}}".data(using: .utf8)!
        
        stub(condition: isHost("www.testendpoint.com")) { _ in
            return OHHTTPStubsResponse(data: jsonWrongFormat, statusCode:200, headers:nil)
        }
        
        expectation = expectation(description: "requestFailExpectation")
        
        requestSender.sendDataRequest(method: "GET", endpoint: "", type: .GetProducts)
        
        waitForExpectations(timeout: 5) { error in
            // timeout is automatically treated as a failed test
        }
        
    }
    
    func testSendRequestFailClientError() {
        
        stub(condition: isHost("www.testendpoint.com")) { request in
            // Stub it with test.json stub file
            return OHHTTPStubsResponse(
                fileAtPath: OHPathForFile("test.json", type(of: self))!,
                statusCode: 400,
                headers: ["Content-Type":"application/json"]
            )
        }
        
        expectation = expectation(description: "requestFailClientExpectation")
        
        requestSender.sendDataRequest(method: "GET", endpoint: "", type: .GetProducts)
        
        waitForExpectations(timeout: 5) { error in
            // timeout is automatically treated as a failed test
        }
    }
    
    func testSendRequestFailServerError() {
        
        stub(condition: isHost("www.testendpoint.com")) { request in
            // Stub it with test.json stub file
            return OHHTTPStubsResponse(
                fileAtPath: OHPathForFile("test.json", type(of: self))!,
                statusCode: 500,
                headers: ["Content-Type":"application/json"]
            )
        }
        
        expectation = expectation(description: "requestFailServerExpectation")
        
        requestSender.sendDataRequest(method: "GET", endpoint: "", type: .GetProducts)
        
        waitForExpectations(timeout: 5) { error in
            // timeout is automatically treated as a failed test
        }
    }
    
    //MARK: NAPNetworkDelegate
    
    func requestProcessed(type: JLRequestType, data: Dictionary<String, AnyObject>) {
        
        if type == .GetProducts && (data.first?.value as! Array<Any>).count == 2 && expectation.description == "requestExpectation" {
            
            expectation.fulfill()
        }
        
    }
    
    func requestFailed(type: JLRequestType, httpCode: Int?) {
        
        if expectation.description == "requestFailExpectation" ||
            expectation.description == "requestFrameworkFailExpectation" {
            expectation.fulfill()
        }
        
        if expectation.description == "requestFailClientExpectation" && httpCode == 400 {
            expectation.fulfill()
        }
        
        if expectation.description == "requestFailServerExpectation" && httpCode == 500 {
            expectation.fulfill()
        }
    }
    
}
