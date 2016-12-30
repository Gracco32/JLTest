//
//  JLDataHelperTest.swift
//  JLTest
//
//  Created by Fabio on 24/12/2016.
//  Copyright © 2016 Fabio. All rights reserved.
//

import XCTest
import XCGLogger
import DATAStack
import Sync
@testable import JLTest

class JLDataHelperTest: XCTestCase {
    
    let testBundle = Bundle(for: JLDataHelperTest.self)
    var dataHelper: JLDataHelper!
    var dataStack: DATAStack!
    var jsonData: Data!
    var jsonDetailData: Data!
    
    var expectation: XCTestExpectation!
    
    override func setUp() {
        super.setUp()
        
        dataStack = DATAStack(modelName:"JLTest", storeType: .inMemory)
        dataHelper = JLDataHelper(dataStack: dataStack)
        
        if let url = testBundle.url(forResource: "test", withExtension: "json"),
            let urlDetails = testBundle.url(forResource: "testDetails", withExtension: "json"){
            jsonData = try! Data(contentsOf: url)
            jsonDetailData = try! Data(contentsOf: urlDetails)
            
        } else {
            XCTFail()
        }

    }
    
    override func tearDown() {
        
        do {
            try dataStack.drop()
        }  catch {
            // it can fake other tests
            XCTFail()
        }
        
        super.tearDown()
    }
    
    /**
     To test this method I need to insert some data in the db first,
     and then check if the fetch works as expected.
     */
    func testSaveSuccessfull() {
        
        // parse the data into a json format
        let json = try! JSONSerialization.jsonObject(with: jsonData, options: JSONSerialization.ReadingOptions()) as! [String: AnyObject]

        expectation = expectation(description: "saveSuccessExpectation")
        
        // trigger the method to test
        dataHelper.saveData(json: json, type: .GetProducts) { (error) in
            
            if error == nil {

                let request: NSFetchRequest<NSFetchRequestResult> = NSFetchRequest(entityName: "Product")
                request.sortDescriptors = [NSSortDescriptor(key: "productId", ascending: true)]
                
                let product: [AnyObject]?
                
                do {
                    // retrive data from the db
                    product = try self.dataStack.mainContext.fetch(request)                     
                    // check if the retrived data correspond to what I'm expecting
                    if let retrivedProduct = product as? [JLProduct],
                        retrivedProduct[0].productId == "1913267",
                        retrivedProduct[0].price.now == "369.00",
                        retrivedProduct[1].productId == "1913470",
                        retrivedProduct[1].price.now == "449.00",
                        retrivedProduct.count == 2 {
                        self.expectation.fulfill()
                    }
                    
                } catch {
                    XCTFail("Saved data couldn't be retrived")
                }
            }
        }
        
        waitForExpectations(timeout: 5) { error in
            // timeout is automatically treated as a failed test
        }
    }
    
    /**
     To test this method I need to insert some data in the db first,
     and then check if the fetch works as expected.
     */
    func testSaveDetailsSuccessfull() {
        
        // parse the data into a json format
        let json = try! JSONSerialization.jsonObject(with: jsonDetailData, options: JSONSerialization.ReadingOptions()) as! [String: AnyObject]
        
        expectation = expectation(description: "saveDetailsSuccessExpectation")
        
        // trigger the method to test
        dataHelper.saveData(json: json, type: .GetProductDetails) { (error) in
            
            if error == nil {
                
                let request: NSFetchRequest<NSFetchRequestResult> = NSFetchRequest(entityName: "ProductDetails")
                request.sortDescriptors = [NSSortDescriptor(key: "productId", ascending: true)]
                
                let details: [AnyObject]?
                
                do {
                    // retrive data from the db
                    details = try self.dataStack.mainContext.fetch(request)
                    // check if the retrived data correspond to what I'm expecting
                    if let retrivedDetails = details as? [JLProductDetails],
                        let title = retrivedDetails[0].title as String?,
                        let code = retrivedDetails[0].code as String?,
                        let displaySpecialOffer = retrivedDetails[0].displaySpecialOffer as String?,
                        let urls = NSKeyedUnarchiver.unarchiveObject(with: retrivedDetails[0].media.images.urls) as? [String],
                        let includedServices = NSKeyedUnarchiver.unarchiveObject(with: retrivedDetails[0].additionalServices.includedServices) as? [String],
                    let features = NSKeyedUnarchiver.unarchiveObject(with: retrivedDetails[0].details.features) as? [[String:AnyObject]],
                    let attributes = features[0]["attributes"] as? [[String:String]],
                        retrivedDetails[0].price.now == "369.00",
                        title == "Bosch SMS53M02GB Freestanding Dishwasher, White",
                        code == "81701209",
                        displaySpecialOffer == "",
                        urls.count == 5,
                        includedServices.count == 1,
                        attributes.count == 27,
                        retrivedDetails.count == 1 {
                        
                        self.expectation.fulfill()
                    }
                    
                } catch {
                    XCTFail("Saved data couldn't be retrived")
                }
            }
        }
        
        waitForExpectations(timeout: 5) { error in
            // timeout is automatically treated as a failed test
        }
    }
    
    /**
     To test this method I need to insert some data in the db first,
     and then check if the fetch works as expected.
     */
    func testSaveFailureWrongFormat() {
        
        // The failure is simulated trying to save an incorrect json into the User table
        let json: [String: AnyObject]!
        
        json = ["wrongKey1": 2 as AnyObject,"wrongKey2": "wrongValue" as AnyObject]
        
        expectation = expectation(description: "saveFailureExpectation")
        
        // trigger the method to test
        dataHelper.saveData(json: json, type: .GetProducts) { (error) in
            
            if error == nil {
                
                let request: NSFetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Product")
                request.sortDescriptors = [NSSortDescriptor(key: "productId", ascending: true)]
                
                let products: [JLProduct]?
                
                do {
                    // retrive data from the db
                    products = try self.dataStack.mainContext.fetch(request) as? [JLProduct]
                    
                    // check if the retrived data correspond to what I'm expecting
                    if let retrivedProduct = products, retrivedProduct.count == 0 {
                        self.expectation.fulfill()
                    }
                    
                } catch {
                    log.error("fetch failure")
                }
            }
        }
        
        waitForExpectations(timeout: 5) { error in
            // timeout is automatically treated as a failed test
        }
    }
 
}
