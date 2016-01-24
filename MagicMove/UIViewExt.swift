//
//  UIViewExt.swift
//  MagicMove
//
//  Created by Patrick Reynolds on 1/24/16.
//  Copyright © 2016 Patrick Reynolds. All rights reserved.
//

import UIKit

// MARK: - UIView GestureRecognizer Extensions
public extension UIView {
    
    /**
     * Adds a tap gesture to the view with a block that will be invoked whenever
     * the gesture's state changes, e.g., when a tap completes.
     *
     * - parameter callback: Invoked whenever the gesture's state changes.
     * - returns: The tap gesture.
     */
    public func tapped(callback: UITapGestureRecognizer -> ()) -> UITapGestureRecognizer {
        let tap = UITapGestureRecognizer().any(callback)
        addGestureRecognizer(tap)
        return tap
    }
    
    /**
     * Adds a pinch gesture to the view with a block that will be invoked
     * whenever the gesture's state changes.
     *
     * - parameter callback: Invoked whenever the gesture's state changes.
     * - returns: The pinch gesture.
     */
    public func pinched(callback: UIPinchGestureRecognizer -> ()) -> UIPinchGestureRecognizer {
        let pinch = UIPinchGestureRecognizer().any(callback)
        addGestureRecognizer(pinch)
        return pinch
    }
    
    /**
     * Adds a pan gesture to the view with a block that will be invoked whenever
     * the gesture's state changes.
     *
     * - parameter callback: Invoked whenever the gesture's state changes.
     * - returns: The pan gesture.
     */
    public func panned(callback: UIPanGestureRecognizer -> ()) -> UIPanGestureRecognizer {
        let pan = UIPanGestureRecognizer().any(callback)
        addGestureRecognizer(pan)
        return pan
    }
    
    /**
     * Adds a swipe gesture to the view with a block that will be invoked
     * whenever the gesture's state changes, e.g., when a swipe completes.
     *
     * - parameter callback: Invoked whenever the gesture's state changes.
     * - returns: The swipe gesture.
     */
    public func swiped(callback: UISwipeGestureRecognizer -> ()) -> UISwipeGestureRecognizer {
        let swipe = UISwipeGestureRecognizer().any(callback)
        addGestureRecognizer(swipe)
        return swipe
    }
    
    /**
     * Adds a rotation gesture to the view with a block that will be invoked
     * whenever the gesture's state changes.
     *
     * - parameter callback: Invoked whenever the gesture's state changes.
     * - returns: The rotation gesture.
     */
    public func rotated(callback: UIRotationGestureRecognizer -> ()) -> UIRotationGestureRecognizer {
        let rotation = UIRotationGestureRecognizer().any(callback)
        addGestureRecognizer(rotation)
        return rotation
    }
    
    /**
     * Adds a long-press gesture to the view with a block that will be invoked
     * whenever the gesture's state changes, e.g., when a tap completes.
     *
     * - parameter callback: Invoked whenever the gesture's state changes.
     * - returns: The long-press gesture.
     */
    public func longPressed(callback: UILongPressGestureRecognizer -> ()) -> UILongPressGestureRecognizer {
        let longPress = UILongPressGestureRecognizer().any(callback)
        addGestureRecognizer(longPress)
        return longPress
    }
}
