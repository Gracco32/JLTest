//
//  JLFlowLayout.swift
//  JLTest
//
//  Created by Fabio on 27/12/2016.
//  Copyright © 2016 Fabio. All rights reserved.
//

import UIKit

extension JLViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        var width : Double = 0
        let height : Double = 351
        
        // Adjust cell size for orientation
        if UIInterfaceOrientationIsLandscape(UIApplication.shared.statusBarOrientation) {
            
            width = Double(collectionView.frame.size.width / 4.0) - Double(1.0)
            
        } else {
            
            width = Double(collectionView.frame.size.width / 3.0) - Double(1.0)
        }

        return CGSize(width: width, height: height)
    }
    
}
