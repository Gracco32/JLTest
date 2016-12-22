//
//  JLCollectionViewCell.swift
//  JLTest
//
//  Created by Fabio on 22/12/2016.
//  Copyright © 2016 Fabio. All rights reserved.
//

import UIKit

class JLCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var priceLabel
    : UILabel!
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        image.accessibilityIdentifier = "productImageID"
        descriptionLabel.accessibilityIdentifier = "descriptionLableID"
        priceLabel.accessibilityIdentifier = "priceLableID"
        
    }

}
