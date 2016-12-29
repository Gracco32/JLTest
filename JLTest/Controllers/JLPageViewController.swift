//
//  JLPageViewController.swift
//  JLTest
//
//  Created by Fabio on 29/12/2016.
//  Copyright © 2016 Fabio. All rights reserved.
//

import UIKit

class JLPageViewController: UIPageViewController, UIPageViewControllerDataSource {
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.dataSource = self
        
        let vc: JLContentPageViewController = self.viewControllerAtIndex(index: 0)
        
        let viewControllers:[UIViewController] = NSArray(object: vc) as! [UIViewController]
        
        self.setViewControllers(viewControllers, direction: .forward, animated: true, completion: nil)
        
        let pageControl = UIPageControl.appearance(whenContainedInInstancesOf: [JLPageViewController.self])
        
        pageControl.pageIndicatorTintColor = .lightGray
        pageControl.currentPageIndicatorTintColor = .black
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func viewControllerAtIndex(index: Int) -> JLContentPageViewController {
    print(index)
        let vc: JLContentPageViewController = self.storyboard?.instantiateViewController(withIdentifier: "ContentPageControllerID") as! JLContentPageViewController
        vc.pageIndex = index
        
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
        
        if index == 4 {
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
        return 4
    }
    
    func presentationIndexForPageViewController(pageViewController: UIPageViewController) -> Int {
        return 0
    }
 
    func presentationCount(for pageViewController: UIPageViewController) -> Int {
        return 4
    }
    
    func presentationIndex(for pageViewController: UIPageViewController) -> Int {
        return 0
    }

}
