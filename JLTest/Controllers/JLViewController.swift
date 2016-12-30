//
//  JLViewController.swift
//  JLTest
//
//  Created by Fabio on 22/12/2016.
//  Copyright © 2016 Fabio. All rights reserved.
//

import UIKit
import DATAStack
import Kingfisher

class JLViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, JLNetworkDelegate {

    @IBOutlet weak var mainTitle: UINavigationItem!
    @IBOutlet weak var collectionView: UICollectionView!
    
    var dataStack: DATAStack!
    var modelLayer: JLModelLayer!
    var requestSender: JLRequestSender!
    var requestFactory: JLRequestFactory!
    var parser: JLResponseParser!
    var apiInterface: JLRequestEndpoints!
    
    var dataSource: [JLProduct]?

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mainTitle.accessibilityLabel = "dishwashersTitleID"
        
        self.dataStack = DATAStack(modelName:"JLTest", storeType: .sqLite)
        
        self.modelLayer = JLModelLayer(dataStack: dataStack)
        
        // Initialise the apiInterface
        let requestFactory = JLRequestFactory()
        let parser = JLResponseParser()
        let dataHelper = JLDataHelper(dataStack: dataStack)
        let requestSender = JLRequestSender(requestFactory: requestFactory, parser: parser, dataHelper: dataHelper, delegate: self)

        apiInterface = JLRequestEndpoints(requestSender: requestSender)
        
        dataSource = modelLayer.fetchProducts()
        
        if let posts = dataSource, posts.count > 0 {
            refresh()
        }
        else {
            apiInterface.getProducts()
        }

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: Private methods
    
    private func refresh() {
        
        if let posts = dataSource {
            self.mainTitle.title = "Dishwashers (\(posts.count))"
        }
        collectionView.reloadData()
    }
    
    // MARK: UICollectionViewDataSource
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
            
        if let products = self.dataSource {
            return products.count
        }
        
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "JLCellID", for: indexPath) as! JLCollectionViewCell
        
        if let dataSource = dataSource,
            let product = dataSource[indexPath.row] as JLProduct? {
            
            let url = URL(string: "https:\(product.image)")
            cell.image.kf.setImage(with: url)
            
            cell.descriptionLabel.text = product.title
            cell.priceLabel.text = "£\(product.price.now)"
            
        }

        return cell
    }
    
    // MARK: UICollectionViewDelegate
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    }

    //MARK: BHTNetworkDelegate
    
    func requestProcessed(type: JLRequestType, data: Dictionary<String, AnyObject>) {
        
        self.dataSource = modelLayer.fetchProducts()
        refresh()
        log.debug("Data received")
        
    }
    
    func requestFailed(type: JLRequestType, httpCode: Int?) {
        
        log.error("Error receiving data")
        
        let alertController = UIAlertController(title: "Sorry!", message: "An error has occured;\nPlease try again later.", preferredStyle: .alert)
        
        // Create the actions
        let cancelAction = UIAlertAction(title: "Cancel", style: UIAlertActionStyle.cancel) {
            UIAlertAction in
        }
        
        // Add the actions
        alertController.addAction(cancelAction)
        
        // Present the controller
        self.present(alertController, animated: true, completion: nil)
        
    }

}

