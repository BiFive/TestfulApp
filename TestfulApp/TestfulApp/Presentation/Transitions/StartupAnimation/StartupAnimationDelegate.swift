//
//  StartupAnimationDelegate.swift
//  TestfulApp
//
//  Created by Andrey Morichev on 25/02/16.
//  Copyright © 2016 Andrey Morichev. All rights reserved.
//

import UIKit

class StartupAnimationDelegate: NSObject, UIViewControllerTransitioningDelegate {
    
    func animationControllerForDismissedController(dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return StartupAnimator()
    }
}
