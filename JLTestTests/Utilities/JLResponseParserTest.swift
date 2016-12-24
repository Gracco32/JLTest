//
//  JLResponseParserTest.swift
//  JLTest
//
//  Created by Fabio on 24/12/2016.
//  Copyright © 2016 Fabio. All rights reserved.
//

import XCTest
@testable import JLTest

class JLResponseParserTest: XCTestCase {
    
    let testBundle = Bundle(for: JLResponseParserTest.self)
    var parser: JLResponseParser!
    var json: Data!
    
    override func setUp() {
        super.setUp()
        
        if let url = testBundle.url(forResource: "test", withExtension: "json") {
            json = try! Data(contentsOf: url)
            
        } else {
            XCTFail()
        }
        
        parser = JLResponseParser()
        
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testParseValidJson() {
        
        let parsedJson = parser.parse(data: json) as! [String: AnyObject]
        
        XCTAssertTrue((parsedJson.first?.value as! Array<Any>).count == 2  , "Parsing of a valid json failed")
        
    }
    
    func testParseInvalidJson() {
        
        let jsonWrongFormat = "{>}}".data(using: .utf8)!
        let parsedJson = parser.parse(data: jsonWrongFormat)
        
        XCTAssertTrue( parsedJson == nil  , "Parsing of an Invalid json looks successfull")
        
    }
}
