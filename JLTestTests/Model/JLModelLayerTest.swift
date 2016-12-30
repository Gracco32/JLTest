//
//  JLModelLayerTest.swift
//  JLTest
//
//  Created by Fabio on 24/12/2016.
//  Copyright © 2016 Fabio. All rights reserved.
//

import XCTest
import DATAStack
@testable import JLTest

class JLModelLayerTest: XCTestCase {
    
    var modelLayer: JLModelLayer!
    var dataStack: DATAStack!
    
    override func setUp() {
        super.setUp()
        
        dataStack = DATAStack(modelName:"JLTest", storeType: .inMemory)
        modelLayer = JLModelLayer(dataStack: dataStack)
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
    
    func testIsEntityEmpty() {
        
        // haven't inserted data, it must be empty
        let request: NSFetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Product")
        
        let products = try! self.dataStack.mainContext.fetch(request) as? [JLProduct]
        XCTAssert( products?.count == 0, "Count should be 0")
        XCTAssert( self.modelLayer.isEntityEmpty(entityName: "Product"), "Table should be empty")
    }
    
    /**
     To test this method I need to insert some data in the db first,
     and then check if the fetch works as expected.
     */
    func testFetchProducts() {
        
        // save test data into the db and wait for the completion block
        // to complete the test
        let entity = NSEntityDescription.entity(forEntityName: "Product", in: self.dataStack.mainContext)!
        let object = NSManagedObject(entity: entity, insertInto: self.dataStack.mainContext)
        object.setValue("100", forKey: "productId")
        object.setValue("TestTitle", forKey: "title")
        try! self.dataStack.mainContext.save()
        
        // retrive saved data
        let products = self.modelLayer.fetchProducts()
        
        // check if the retrieved data correspond to the inserted data
        XCTAssertTrue((products?.count)! == 1, "Number of products should be 1")
        XCTAssertTrue((products?.first?.productId)! == "100", "Products id incorrect")
        XCTAssertTrue((products?.first?.title)! == "TestTitle", "Products title incorrect")
    }

    /**
     To test this method I need to insert some data in the db first,
     and then check if the fetch works as expected.
     */
    func testFetchProductDetails() {
        
        // save test data into the db and wait for the completion block
        // to complete the test
        let entity = NSEntityDescription.entity(forEntityName: "ProductDetails", in: self.dataStack.mainContext)!
        let object = NSManagedObject(entity: entity, insertInto: self.dataStack.mainContext)
        object.setValue("100", forKey: "productId")
        object.setValue("TestTitle", forKey: "title")
        try! self.dataStack.mainContext.save()
        
        // retrive saved data
        let productDetails = self.modelLayer.fetchProductDetails(productId: "100")
        
        // check if the retrieved data correspond to the inserted data
        XCTAssertTrue((productDetails?.productId)! == "100", "Products id incorrect")
        XCTAssertTrue((productDetails?.title)! == "TestTitle", "Products title incorrect")
    }
    
}
