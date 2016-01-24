//
//  CustomTransitionExamples.swift
//  MagicMove
//
//  Created by Patrick Reynolds on 1/24/16.
//  Copyright © 2016 Patrick Reynolds. All rights reserved.
//

import UIKit

// MARK: Fade Transition
class FadeTransition: NSObject, UIViewControllerAnimatedTransitioning {
    
    let duration = 1.0
    let originFrame = CGRect.zero
    
    func transitionDuration(transitionContext: UIViewControllerContextTransitioning?) -> NSTimeInterval {
        return duration
    }
    
    func animateTransition(transitionContext: UIViewControllerContextTransitioning) {
        let containerView = transitionContext.containerView()!
        let toView =
        transitionContext.viewForKey(UITransitionContextToViewKey)!
        
        containerView.addSubview(toView)
        toView.alpha = 0.0
        UIView.animateWithDuration(duration, animations: {
            toView.alpha = 1.0
            }, completion: { _ in
                transitionContext.completeTransition(true)
        })
    }
}

// MARK: Spin Transition

enum SpinTransitionConstants: String {
    
    case BasicAnimationKeyPath
    case RotationAnimationKey
    
    var value: String {
        switch self {
        case .BasicAnimationKeyPath: return "transform.rotation.z"
        case .RotationAnimationKey:  return "rotationAnimation"
        }
    }
}

class SpinTransition: NSObject, UIViewControllerAnimatedTransitioning {
    
    let duration = 0.5
    let originFrame = CGRect.zero
    let rotations = 1.0
    
    func transitionDuration(transitionContext: UIViewControllerContextTransitioning?) -> NSTimeInterval {
        return duration
    }
    
    func animateTransition(transitionContext: UIViewControllerContextTransitioning) {
        let containerView = transitionContext.containerView()!
        let fromView = transitionContext.viewForKey(UITransitionContextFromViewKey)!
        let toView = transitionContext.viewForKey(UITransitionContextToViewKey)!
        
        toView.alpha = 0.0
        
        containerView.addSubview(fromView)
        containerView.addSubview(toView)
        
        spinView(fromView, duration: duration, rotations: rotations)
        
        UIView.animateWithDuration(duration, delay: 0, options: .CurveEaseInOut, animations: {
            fromView.alpha = 0.0
            toView.alpha = 1.0
            }, completion: { _ in
                transitionContext.completeTransition(true)
        })
    }
    
    // Private Helpers
    private func spinView(view: UIView, duration: NSTimeInterval, rotations: Double) {
        let rotationAnimation = CABasicAnimation(keyPath: SpinTransitionConstants.BasicAnimationKeyPath.value)
        rotationAnimation.toValue = Double(M_PI) * rotations * 2.0
        rotationAnimation.duration = duration
        rotationAnimation.cumulative = true
        
        view.layer.addAnimation(rotationAnimation, forKey: SpinTransitionConstants.RotationAnimationKey.value)
    }
}
