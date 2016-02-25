//
//  StartupAnimator.swift
//  TestfulApp
//
//  Created by Andrey Morichev on 25/02/16.
//  Copyright © 2016 Andrey Morichev. All rights reserved.
//

import UIKit

class StartupAnimator: NSObject, UIViewControllerAnimatedTransitioning {

    static let toViewInitialScale: CGFloat = 0.7
    
    func transitionDuration(transitionContext: UIViewControllerContextTransitioning?) -> NSTimeInterval {
        return 1.0
    }

    func animateTransition(transitionContext: UIViewControllerContextTransitioning) {
        guard let fromView = transitionContext.viewControllerForKey(UITransitionContextFromViewControllerKey)?.view,
            let toView = transitionContext.viewControllerForKey(UITransitionContextToViewControllerKey)?.view,
            let containerView = transitionContext.containerView() else {
                return
        }
        
        containerView.addSubview(toView)
        containerView.addSubview(fromView)
        containerView.backgroundColor = UIColor.whiteColor()
        
        toView.transform = CGAffineTransformScale(CGAffineTransformIdentity, StartupAnimator.toViewInitialScale, StartupAnimator.toViewInitialScale)
        
        UIView.animateWithDuration(self.transitionDuration(transitionContext), animations: { () -> Void in
            toView.transform = CGAffineTransformScale(CGAffineTransformIdentity, 1.0, 1.0)
            fromView.transform = CGAffineTransformScale(CGAffineTransformIdentity, 1.0 / StartupAnimator.toViewInitialScale, 1.0 / StartupAnimator.toViewInitialScale)
            fromView.alpha = 0.0
        }) { (finished: Bool) -> Void in
            transitionContext.completeTransition(finished)
        }
    }

}
