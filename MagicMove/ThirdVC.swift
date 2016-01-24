//
//  ThirdVC.swift
//  MagicMove
//
//  Created by Patrick Reynolds on 1/24/16.
//  Copyright © 2016 Patrick Reynolds. All rights reserved.
//

import UIKit

class ThirdVC: UIViewController {
    
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
        
        presentViewControllerCustomTrasition(secondVC, transition: SpinTransition(), animated: true)
    }
}

extension ThirdVC: MagicMoveable {
    var isMagic: Bool {
        return true
    }
    
    var duration: NSTimeInterval {
        return 0.3
    }
    
    var magicViews: [UIView] {
        return [redView, greenLabel, blueButton]
    }
}
