//
//  StartupManager.swift
//  TestfulApp
//
//  Created by Andrey Morichev on 25/02/16.
//  Copyright © 2016 Andrey Morichev. All rights reserved.
//

import UIKit

class StartupManager: NSObject {
    
    var startupViewController: StartupViewController?
    var rootViewController: UIViewController?
    var transitionDelegate = StartupAnimationDelegate()
    
    func setupUI(window: UIWindow, rootViewController: UIViewController) {
        self.rootViewController = rootViewController
        window.rootViewController = rootViewController
        window.makeKeyAndVisible()
        
        let startupViewController = StartupViewController(nibName: "StartupViewController", bundle: nil)
        startupViewController.transitioningDelegate = self.transitionDelegate
        rootViewController.presentViewController(startupViewController, animated: false, completion: nil)
        self.startupViewController = startupViewController
        
        let delayTime = dispatch_time(DISPATCH_TIME_NOW, Int64(1.5 * Double(NSEC_PER_SEC)))
        dispatch_after(delayTime, dispatch_get_main_queue()) {
            rootViewController.dismissViewControllerAnimated(true, completion: nil)
        }
    }
    
    func didFinishAppInitialization() {
        
    }
    
    private func animateToRootViewController() {
        
    }
}
