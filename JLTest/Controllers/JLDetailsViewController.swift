//
//  JLDetailsViewController.swift
//  JLTest
//
//  Created by Fabio on 28/12/2016.
//  Copyright © 2016 Fabio. All rights reserved.
//

import UIKit

class JLDetailsViewController: UIViewController {
    
    @IBOutlet weak var mainStackView: UIStackView!
    @IBOutlet weak var priceView: JLPriceView!
    @IBOutlet weak var internalStackView: UIStackView!
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var priceViewHeightConstraint: NSLayoutConstraint!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        tableView.accessibilityIdentifier = "featuresTableViewID"
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        UIView.animate(withDuration: 0.3) { 
            self.changeLayout()
        }
    }

    private func changeLayout() {
        
        let orient = UIApplication.shared.statusBarOrientation
        
        switch orient {
        case .portrait:
            self.priceView.removeFromSuperview()
            self.priceViewHeightConstraint.constant = 200
            self.internalStackView.insertArrangedSubview(self.priceView, at: 1)
        default:
            self.priceView.removeFromSuperview()
            self.mainStackView.addArrangedSubview(self.priceView)
        }
    }
}
