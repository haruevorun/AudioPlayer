//
//  DismissModalViewAnimation.swift
//  AudioPlayer
//
//  Created by haruta yamada on 2019/01/18.
//  Copyright © 2019 teranyan. All rights reserved.
//

import Foundation
import UIKit
protocol NavigationTransitionerDelegate: class {
    func shouldBeginGesture(gesture: UIGestureRecognizer) -> Bool
    func pop()
}

class DismissModalViewAnimation: NSObject, UIViewControllerAnimatedTransitioning {
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.5
    }
    
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        let container = transitionContext.containerView
        guard let toVC: UIViewController = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.to), let fromVC: UIViewController = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.from) else {
            return
        }
        fromVC.view.removeFromSuperview()
        container.addSubview(toVC.view)
        container.addSubview(fromVC.view)
        toVC.view.layer.shadowOffset = CGSize(width: 1, height: 1)
        toVC.view.layer.shadowRadius = 3
        toVC.view.layer.shadowOpacity = 8
        
        toVC.view.layoutIfNeeded()
        UIView.animate(withDuration: 0.5,
                       delay: 0.0,
                       usingSpringWithDamping: 0.8,
                       initialSpringVelocity: 0.3,
                       options: .curveEaseIn,
                       animations:  {
                        fromVC.view.frame.origin = CGPoint(x: toVC.view.frame.origin.x, y: container.frame.height + container.frame.origin.y)
        },
                       completion: { (isFinish) in
                        transitionContext.completeTransition(true)
        })
    }
}
