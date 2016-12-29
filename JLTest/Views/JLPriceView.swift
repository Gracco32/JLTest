//
//  JLPriceView.swift
//  JLTest
//
//  Created by Fabio on 29/12/2016.
//  Copyright © 2016 Fabio. All rights reserved.
//

import UIKit

class JLPriceView: UIView {

    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var specialOfferLabel: UILabel!
    @IBOutlet weak var warrantyLabel: UILabel!

    override func layoutSubviews() {
        super.layoutSubviews()
        
        priceLabel.accessibilityIdentifier = "detailPriceLabelID"
        specialOfferLabel.accessibilityIdentifier = "offerLabelID"
        warrantyLabel.accessibilityIdentifier = "warrantyLabelID"
        
    }
}
