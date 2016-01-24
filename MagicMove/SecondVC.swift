//
//  SecondVC.swift
//  MagicMove
//
//  Created by Patrick Reynolds on 1/24/16.
//  Copyright © 2016 Patrick Reynolds. All rights reserved.
//

import UIKit

class SecondVC: UIViewController {
    
    @IBOutlet weak var redView: UIView!
    @IBOutlet weak var greenLabel: UILabel!
    @IBOutlet weak var blueButton: UIButton!
    
    @IBOutlet weak var backButton: UIButton!
    
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
            self.nextButtonTappedHandler()
        }
        
        backButton.tapped { _ in
            self.backButtonTappedHander()
        }
    }
    
    private func nextButtonTappedHandler() {
        let thirdVC = UIStoryboard(name: Storyboards.Main.storyboard, bundle: nil).instantiateViewControllerWithIdentifier(String(ThirdVC)) as! ThirdVC
        
        presentViewControllerMagically(self, to: thirdVC, animated: true)
    }
    
    private func backButtonTappedHander() {
        let firstVC = UIStoryboard(name: Storyboards.Main.storyboard, bundle: nil).instantiateViewControllerWithIdentifier(String(FirstVC)) as! FirstVC
        
        presentViewControllerMagically(self, to: firstVC, animated: true)
    }
}

extension SecondVC: MagicMoveable {
    var isMagic: Bool {
        return true
    }
    
    var duration: NSTimeInterval {
        return 0.7
    }
    
    var spring: CGFloat {
        return 0.9
    }
    
    var magicViews: [UIView] {
        return [redView, greenLabel, blueButton]
    }
}
