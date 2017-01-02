//
//  JLPageViewController.swift
//  JLTest
//
//  Created by Fabio on 29/12/2016.
//  Copyright © 2016 Fabio. All rights reserved.
//

import UIKit

class JLPageViewController: UIPageViewController, UIPageViewControllerDataSource {
    
    var urls: [String]?
    // indicates if a new product detail has been selected, in order to load the first image properly
    var isNewProduct: Bool?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.dataSource = self
        
        let pageControl = UIPageControl.appearance(whenContainedInInstancesOf: [JLPageViewController.self])
        
        pageControl.pageIndicatorTintColor = .lightGray
        pageControl.currentPageIndicatorTintColor = .black
    }

    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
        if let isNew = isNewProduct, isNew == true {
            isNewProduct = false
            let vc: JLContentPageViewController = self.viewControllerAtIndex(index: 0)
            let viewControllers:[UIViewController] = NSArray(object: vc) as! [UIViewController]
            self.setViewControllers(viewControllers, direction: .forward, animated: true, completion: nil)
        }
    }
    
    func viewControllerAtIndex(index: Int) -> JLContentPageViewController {
    
        let vc: JLContentPageViewController = self.storyboard?.instantiateViewController(withIdentifier: "ContentPageControllerID") as! JLContentPageViewController
        
        vc.pageIndex = index
        
        if let urlArray = urls {
            let url = URL(string: "https:\(urlArray[index])")
            vc.url = url
        }
        
        return vc
    }
    
    //MARK - UIPageViewControllerDataSource
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
     
        let vc = viewController as! JLContentPageViewController
        var index = vc.pageIndex as Int
        
        if index == NSNotFound {
            return nil
        }
        
        index += 1
        
        if index == urls?.count {
            return nil
        }
        
        return  self.viewControllerAtIndex(index: index)
        
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        
        let vc = viewController as! JLContentPageViewController
        var index = vc.pageIndex as Int
        
        if index == 0 || index == NSNotFound {
            return nil
        }
        
        index -= 1
        
        return  self.viewControllerAtIndex(index: index)
       
    }
    
    func presentationCountForPageViewController(pageViewController: UIPageViewController) -> Int {
        if let urlArray = urls {
            return urlArray.count
        }
        return 0
    }
    
    func presentationIndexForPageViewController(pageViewController: UIPageViewController) -> Int {
        return 0
    }
 
    func presentationCount(for pageViewController: UIPageViewController) -> Int {
        if let urlArray = urls {
            return urlArray.count
        }
        return 0
    }
    
    func presentationIndex(for pageViewController: UIPageViewController) -> Int {
        return 0
    }

}
