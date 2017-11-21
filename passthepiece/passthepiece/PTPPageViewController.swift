//
//  PTPPageViewController.swift
//  passthepiece
//
//  Created by brianna on 11/19/17.
//  Copyright © 2017 brianna. All rights reserved.
//

import UIKit

class PTPPageViewController: UIPageViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        dataSource = self
        
        if let firstViewController = orderedViewControllers.first {
            setViewControllers([firstViewController],
                               direction: .forward,
                               animated: true,
                               completion: nil)
        }
        
        navigationItem.titleView = UIImageView(image: UIImage(named: "logo-title"))
    }
    
    private(set) lazy var orderedViewControllers: [UIViewController] = {
        return [storyboard?.instantiateViewController(withIdentifier: "Feed"), storyboard?.instantiateViewController(withIdentifier: "Camera")]
        }() as! [UIViewController]

}

// MARK: UIPageViewControllerDataSource

extension PTPPageViewController: UIPageViewControllerDataSource {
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let viewControllerIndex = orderedViewControllers.index(of: viewController) else {
            return nil
        }
        
        let previousIndex = viewControllerIndex - 1
        
        guard previousIndex >= 0 else {
            return nil
        }
        
        guard orderedViewControllers.count > previousIndex else {
            return nil
        }
        
        return orderedViewControllers[previousIndex]
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let viewControllerIndex = orderedViewControllers.index(of: viewController) else {
            return nil
        }
        
        let nextIndex = viewControllerIndex + 1
        let orderedViewControllersCount = orderedViewControllers.count
        
        guard orderedViewControllersCount != nextIndex else {
            return nil
        }
        
        guard orderedViewControllersCount > nextIndex else {
            return nil
        }
        
        return orderedViewControllers[nextIndex]
    }
    
}
