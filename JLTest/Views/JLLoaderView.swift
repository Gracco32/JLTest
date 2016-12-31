//
//  JLLoaderView.swift
//  JLTest
//
//  Created by Fabio on 31/12/2016.
//  Copyright © 2016 Fabio. All rights reserved.
//

import UIKit

class JLLoaderView: NSObject {
    
    static var loadingView: UIView?
    
    static func showLoader(view: UIView) {
        
        let v = view
        
        if let lv = loadingView {
            lv.removeFromSuperview()
        }
        
        self.loadingView = UIView(frame: v.frame)
        loadingView!.translatesAutoresizingMaskIntoConstraints = false
        
        v.addSubview(loadingView!)
        
        let loaderColor = UIColor(red: 40/255.0, green: 40/255.0, blue: 40/255.0, alpha: 0.5)
        loadingView!.backgroundColor = loaderColor
        
        var constraints = [NSLayoutConstraint]()
        //set the size of the images
        let c0 = NSLayoutConstraint(item: loadingView!, attribute: NSLayoutAttribute.centerX, relatedBy: NSLayoutRelation.equal, toItem: v, attribute: NSLayoutAttribute.centerX, multiplier: 1.0, constant: 0.0)
        constraints.append(c0)
        
        let c1 = NSLayoutConstraint(item: loadingView!, attribute: NSLayoutAttribute.centerY, relatedBy: NSLayoutRelation.equal, toItem: v, attribute: NSLayoutAttribute.centerY, multiplier: 1.0, constant: 0.0)
        constraints.append(c1)
        
        let c2 = NSLayoutConstraint(item: loadingView!, attribute: NSLayoutAttribute.width, relatedBy: NSLayoutRelation.equal, toItem: v, attribute: NSLayoutAttribute.width, multiplier: 1.0, constant: 0.0)
        constraints.append(c2)
        
        let c3 = NSLayoutConstraint(item: loadingView!, attribute: NSLayoutAttribute.height, relatedBy: NSLayoutRelation.equal, toItem: v, attribute: NSLayoutAttribute.height, multiplier: 1.0, constant: 0.0)
        constraints.append(c3)
        
        v.addConstraints(constraints)
        constraints.removeAll()
        
        let loader = UIActivityIndicatorView(frame: CGRect(x: 0, y: 0, width: 40, height: 40))
        loader.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.whiteLarge
        
        let l0 = NSLayoutConstraint(item: loader, attribute: NSLayoutAttribute.centerX, relatedBy: NSLayoutRelation.equal, toItem: loadingView, attribute: NSLayoutAttribute.centerX, multiplier: 1.0, constant: 0.0)
        constraints.append(l0)
        
        constraints.append(l0)
        
        let l1 = NSLayoutConstraint(item: loader, attribute: NSLayoutAttribute.centerY, relatedBy: NSLayoutRelation.equal, toItem: loadingView, attribute: NSLayoutAttribute.centerY, multiplier: 1.0, constant: 0.0)
        constraints.append(l1)
        
        constraints.append(l1)
        
        loadingView!.addSubview(loader)
        loader.startAnimating()
        
        loader.translatesAutoresizingMaskIntoConstraints = false
        loadingView!.addConstraints(constraints)
        
    }
    
    static func hideLoader() {
        if let lv = loadingView {
            lv.removeFromSuperview()
        }
    }
}
