//
//  MagicMove.swift
//  MagicMove
//
//  Created by Patrick Reynolds on 1/24/16.
//  Copyright © 2016 Patrick Reynolds. All rights reserved.
//

import UIKit

// MARK: - MagicMoveable Protocol
@objc protocol MagicMoveable {
    
    var duration: NSTimeInterval  { get }
    
    var magicViews: [UIView] { get }
    
    optional var spring: CGFloat { get }
}

// MARK: - MagicMoveTransition Delegate
class MagicMoveTransition: NSObject, UIViewControllerAnimatedTransitioning {
    
    // MARK: Delegate Properties
    let duration: NSTimeInterval
    let spring: CGFloat
    
    let from: MagicMoveable
    let to: MagicMoveable
    
    var fromViews: [UIView] {
        return from.magicViews
    }
    
    var toViews: [UIView] {
        return to.magicViews
    }
    
    // MARK: Initializer(s)
    init(from: MagicMoveable, to: MagicMoveable, duration: NSTimeInterval, spring: CGFloat) {
        self.from = from
        self.to = to
        self.duration = duration
        self.spring = spring
    }
    
    // MARK: Delegate Methods
    func transitionDuration(transitionContext: UIViewControllerContextTransitioning?) -> NSTimeInterval {
        return duration
    }
    
    func animateTransition(transitionContext: UIViewControllerContextTransitioning) {
        let fromVC = transitionContext.viewControllerForKey(UITransitionContextFromViewControllerKey)!
        let toVC = transitionContext.viewControllerForKey(UITransitionContextToViewControllerKey)!
        let containerView = transitionContext.containerView()!
        
        magicAnimationFromViewController(fromVC, toViewController: toVC, containerView: containerView, duration: duration, transitionContext: transitionContext)
    }
    
    private func magicAnimationFromViewController(fromViewController: UIViewController, toViewController: UIViewController, containerView: UIView, duration: NSTimeInterval, transitionContext: UIViewControllerContextTransitioning) {
        
        assert(self.fromViews.count == self.toViews.count, "The count of fromviews and toviews musts be the same!")
        
        for toView in self.toViews {
            toView.hidden = true
        }
        
        let snapshots: [UIImageView] = self.fromViews.map {
            let snapshot = UIImageView(image: getImageFromView($0))
            snapshot.frame = containerView.convertRect($0.frame, fromView: $0.superview)
            $0.hidden = true
            return snapshot
        }
        
        toViewController.view.frame = transitionContext.finalFrameForViewController(toViewController)
        toViewController.view.alpha = 0
        containerView.addSubview(toViewController.view)
        
        for view in snapshots {
            containerView.addSubview(view)
        }
        
        containerView.layoutIfNeeded()
        
        UIView.animateWithDuration(duration, delay: 0.0, usingSpringWithDamping: spring, initialSpringVelocity: 1.0, options: .CurveEaseInOut, animations: {
            toViewController.view.alpha = 1.0
            for (index, toView) in self.toViews.enumerate() {
                snapshots[index].frame = containerView.convertRect(toView.frame, fromView: toView.superview)
            }
            }, completion: { _ in
                for (index, toView) in self.toViews.enumerate() {
                    toView.hidden = false
                    self.fromViews[index].hidden = false
                    
                    snapshots[index].removeFromSuperview()
                }
                
                transitionContext.completeTransition(!transitionContext.transitionWasCancelled())
        })
    }
    
    // Private Helpers
    private func getImageFromView(view: UIView) -> UIImage {
        UIGraphicsBeginImageContextWithOptions(view.bounds.size, false, 0.0)
        view.layer.renderInContext(UIGraphicsGetCurrentContext()!)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image
    }
}


class CustomTransitioningDelegate: NSObject, UIViewControllerTransitioningDelegate {
    let transition: UIViewControllerAnimatedTransitioning
    
    init(transition: UIViewControllerAnimatedTransitioning) {
        self.transition = transition
    }
    
    func animationControllerForPresentedController(presented: UIViewController, presentingController presenting: UIViewController, sourceController source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return transition
    }
    
    func animationControllerForDismissedController(dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return nil
    }
}

private var UIViewControllerCustomTransitionDelegateKey = 0

class AnimatedTransitioningBox: NSObject {
    let transitioningDelegate: UIViewControllerTransitioningDelegate
    
    init(transitioningDelegate: UIViewControllerTransitioningDelegate) {
        self.transitioningDelegate = transitioningDelegate
    }
}

extension UIViewController {
    var customTransitioningDelegate: UIViewControllerTransitioningDelegate? {
        get {
            let box = objc_getAssociatedObject(self, &UIViewControllerCustomTransitionDelegateKey) as? AnimatedTransitioningBox
            return box?.transitioningDelegate
        }
        set(newValue) {
            if let newValue = newValue {
                let box = AnimatedTransitioningBox(transitioningDelegate: newValue)
                objc_setAssociatedObject(self, &UIViewControllerCustomTransitionDelegateKey, box, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
                self.transitioningDelegate = newValue
            }
        }
    }
}

extension UIViewController {
    func presentViewControllerCustomTrasition(to: UIViewController, transition: UIViewControllerAnimatedTransitioning, animated: Bool, completed: (() -> ())? = nil) {
        to.customTransitioningDelegate = CustomTransitioningDelegate(transition: transition)
        presentViewController(to, animated: animated, completion: completed)
    }
}


extension UIViewController {
    func presentViewControllerMagically<F: UIViewController, T: UIViewController where F: MagicMoveable, T: MagicMoveable>(from: F, to: T, animated: Bool, duration: NSTimeInterval = 0.3, spring: CGFloat = 1.0, completed: (() -> ())? = nil) {
        let transition = MagicMoveTransition(from: from, to: to, duration: duration, spring: spring)
        from.presentViewControllerCustomTrasition(to, transition: transition, animated: animated, completed: completed)
    }
}
