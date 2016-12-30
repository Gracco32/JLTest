//
//  JLContentPageViewController.swift
//  JLTest
//
//  Created by Fabio on 29/12/2016.
//  Copyright © 2016 Fabio. All rights reserved.
//

import UIKit

class JLContentPageViewController: UIViewController {

    @IBOutlet weak var image: UIImageView!
    
    var pageIndex = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()

    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
        image.accessibilityIdentifier = "detailImageViewID"
    }
}