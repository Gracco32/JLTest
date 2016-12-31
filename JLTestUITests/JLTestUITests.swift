//
//  JLTestUITests.swift
//  JLTestUITests
//
//  Created by Fabio on 22/12/2016.
//  Copyright © 2016 Fabio. All rights reserved.
//

import XCTest

class JLTestUITests: XCTestCase {
        
    let app = XCUIApplication()
    
    override func setUp() {
        super.setUp()
        
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false
        // UI tests must launch the application that they test. Doing this in setup will make sure it happens for each test method.
        XCUIApplication().launch()
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testMainViewDisplayed() {
        
        let title = app.navigationBars.staticTexts["dishwashersTitleID"]
        XCTAssertTrue(title.exists)
    
    }
    
    func testCustomCell() {
        
        let collection = app.collectionViews.element
        XCTAssertTrue(collection.exists)
        
        let cell = collection.cells.element(boundBy: 0)
        
        let exists = NSPredicate(format: "exists == true")
        expectation(for: exists, evaluatedWith: cell, handler: nil)
        waitForExpectations(timeout: 10, handler: nil)
        
        XCTAssertTrue(cell.exists)
        
        let image = cell.images["productImageID"]
        let description = cell.staticTexts["descriptionLableID"]
        let price = cell.staticTexts["priceLableID"]
        
        XCTAssertTrue(image.exists)
        XCTAssertTrue(description.exists)
        XCTAssertTrue(price.exists)

    }
    
    func testDetailView() {
        
        let collection = app.collectionViews.element
        XCTAssertTrue(collection.exists)
        
        let cell = collection.cells.element(boundBy:0)
        
        let exists = NSPredicate(format: "exists == true")
        expectation(for: exists, evaluatedWith: cell, handler: nil)
        waitForExpectations(timeout: 10, handler: nil)
        
        XCTAssertTrue(cell.exists)
        
        cell.tap()
        
        let imageView = app.images["detailImageViewID"]
        let priceTitle = app.staticTexts["detailPriceLabelID"]
        let priceOffers = app.staticTexts["offerLabelID"]
        let priceWarranty = app.staticTexts["warrantyLabelID"]
        let productInfoTitle = app.staticTexts["infoTitleLableID"]
        let productCode = app.staticTexts["codeLabelID"]
        let productDetails = app.otherElements["detailsWebViewID"]
        let tableView = app.tables["featuresTableViewID"]
        
        expectation(for: exists, evaluatedWith: imageView, handler: nil)
        waitForExpectations(timeout: 3, handler: nil)
        XCTAssertTrue(priceTitle.exists)
        XCTAssertTrue(priceOffers.exists)
        XCTAssertTrue(priceWarranty.exists)
        XCTAssertTrue(productInfoTitle.exists)
        XCTAssertTrue(productCode.exists)
        XCTAssertTrue(productDetails.exists)
        XCTAssertTrue(tableView.exists)
    }
}
