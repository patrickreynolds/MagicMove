//
//  FirstVC.swift
//  MagicMove
//
//  Created by Patrick Reynolds on 1/24/16.
//  Copyright © 2016 Patrick Reynolds. All rights reserved.
//

import UIKit

class FirstVC: UIViewController {
    
    @IBOutlet weak var redView: UIView!
    @IBOutlet weak var greenLabel: UILabel!
    @IBOutlet weak var blueButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupTapHandler()
        
    }
    
    private func setupViews() {
        redView.backgroundColor = UIColor.redColor()
        greenLabel.textColor = UIColor.greenColor()
        blueButton.setTitleColor(UIColor.blueColor(), forState: .Normal)
    }
    
    private func setupTapHandler() {
        blueButton.tapped { _ in
            self.buttonTappedHandler()
        }
    }
    
    private func buttonTappedHandler() {
        let secondVC = UIStoryboard(name: Storyboards.Main.storyboard, bundle: nil).instantiateViewControllerWithIdentifier(String(SecondVC)) as! SecondVC
        
        presentViewControllerMagically(self, to: secondVC, animated: true, duration: duration, spring: spring)
    }
}

extension FirstVC: MagicMoveable {
    var isMagic: Bool {
        return true
    }
    
    var duration: NSTimeInterval {
        return 0.5
    }
    
    var spring: CGFloat {
        return 0.7
    }
    
    var magicViews: [UIView] {
        return [redView, greenLabel, blueButton]
    }
}
