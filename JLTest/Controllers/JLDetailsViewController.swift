//
//  JLDetailsViewController.swift
//  JLTest
//
//  Created by Fabio on 28/12/2016.
//  Copyright © 2016 Fabio. All rights reserved.
//

import UIKit

class JLDetailsViewController: UIViewController, UITableViewDataSource {
    
    @IBOutlet weak var mainStackView: UIStackView!
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var priceView: JLPriceView!
    @IBOutlet weak var productInfoView: JLProductInfoView!
    @IBOutlet weak var internalStackView: UIStackView!
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var priceViewHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var stackViewHeightConstraint: NSLayoutConstraint!
    
    var details: JLProductDetails?
    var attributes: [[String:String]]?
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        tableView.accessibilityIdentifier = "featuresTableViewID"
        tableView.dataSource = self
        
        if let d = details {
            
            self.title = d.title
            
            // Set price view
            priceView.priceLabel.text = "£\(d.price.now)"
            if d.displaySpecialOffer == "" {
                priceView.specialOfferLabelHeightConstraint.constant = 0
            } else {
                priceView.specialOfferLabelHeightConstraint.constant = 60
                priceView.specialOfferLabel.text = d.displaySpecialOffer
            }
            let services = NSKeyedUnarchiver.unarchiveObject(with: d.additionalServices.includedServices) as? [String]
            priceView.warrantyLabel.text = services?[0]
            
            // Set product info view
            productInfoView.titleInfoLabel.text = d.title
            productInfoView.codeLabel.text = "Product code: \(d.code)"
            productInfoView.infoWebView.loadHTMLString(d.details.productInformation, baseURL: nil)
            
            // Set images
            if let vc = childViewControllers[0] as? JLPageViewController,
               let urls = NSKeyedUnarchiver.unarchiveObject(with: d.media.images.urls) as? [String] {
                vc.isNewProduct = true
                vc.urls = urls
            }
            
            // Set attributes
            if let features = NSKeyedUnarchiver.unarchiveObject(with: d.details.features) as? [[String:AnyObject]],
                let attributes = features[0]["attributes"] as? [[String:String]] {
                
                self.attributes = attributes
                
            } else {
                attributes = nil
            }
            
            tableView.reloadData()
        }
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        UIView.animate(withDuration: 0.3) { 
            self.changeLayout()
        }
    }
    
    // MARK: Private methods
    
    private func changeLayout() {
        
        let orient = UIApplication.shared.statusBarOrientation
        var contentHeight = containerView.frame.height + productInfoView.frame.height + (tableView.tableHeaderView?.frame.height)!
        
        if let attributes = attributes, attributes.count > 0 {
            contentHeight += (tableView.rowHeight * CGFloat(attributes.count))
        }
        
        switch orient {
        case .portrait:
            self.priceView.removeFromSuperview()
            var height: CGFloat = 0
            if priceView.specialOfferLabelHeightConstraint.constant == 0 {
                height = 60
            }
            self.priceViewHeightConstraint.constant = 180 - height
            self.internalStackView.insertArrangedSubview(self.priceView, at: 1)
            self.stackViewHeightConstraint.constant = contentHeight + self.priceViewHeightConstraint.constant
        default:
            self.priceView.removeFromSuperview()
            self.stackViewHeightConstraint.constant = contentHeight
            self.mainStackView.addArrangedSubview(self.priceView)
        }
    }
    
    // MARK: Table View Data Source
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if let attributes = self.attributes {
            return attributes.count
        }
        
        return 0
    }
    
    // show the rows on the table view
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cellID: String = "JLAttributesTableCellID"
        
        let cell = tableView.dequeueReusableCell(withIdentifier: cellID) as! JLAttributeTableViewCell
        
        if let attributes = attributes,
            let name = attributes[indexPath.row]["name"] as String?,
            let value = attributes[indexPath.row]["value"] as String? {
            
            cell.nameLabel.text = name
            cell.valueLabel.text = value
        }
        
        return cell
    }
    
}
