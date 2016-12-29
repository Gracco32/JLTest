//
//  JLProductInfoView.swift
//  JLTest
//
//  Created by Fabio on 29/12/2016.
//  Copyright © 2016 Fabio. All rights reserved.
//

import UIKit

class JLProductInfoView: UIView {

    @IBOutlet weak var titleInfoLabel: UILabel!
    @IBOutlet weak var codeLabel: UILabel!
    @IBOutlet weak var infoWebView: UIWebView!
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        titleInfoLabel.accessibilityIdentifier = "infoTitleLableID"
        codeLabel.accessibilityIdentifier = "codeLabelID"
        infoWebView.accessibilityIdentifier = "detailsWebViewID"
    }
}
