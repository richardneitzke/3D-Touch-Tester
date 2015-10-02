//
//  ViewController.swift
//  3D Tester
//
//  Created by Richard Neitzke on 10/1/15.
//  Copyright © 2015 Richard Neitzke. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var adviseLabel: UILabel!
    @IBOutlet weak var percentLabel: UILabel!

    var forceAmount: CGFloat = 0.0
    var compatible: Bool

    override func viewDidLoad() {
        super.viewDidLoad()
        
        switch self.traitCollection.forceTouchCapability {
        case .Available: compatible = true
        default: adviseLabel.text = 
            compatible = false
            "Unsupported device!"
            percentLabel.text = "Error!"
        }
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        if compatible { handleTouch(touches.first!) }
    }
    
    override func touchesMoved(touches: Set<UITouch>, withEvent event: UIEvent?) {
        if compatible { handleTouch(touches.first!) }
    }
    
    override func touchesEnded(touches: Set<UITouch>, withEvent event: UIEvent?) {
        if compatible {
        
            self.view.backgroundColor = UIColor(white: 1, alpha: 1)
        
            adviseLabel.textColor = UIColor.blackColor()
            percentLabel.textColor = UIColor.blackColor()
        
            percentLabel.text = "0%"
            
         }
    }
    
    func handleTouch(touch:UITouch) {

        forceAmount = touch.force/touch.maximumPossibleForce
        let exactPercent = forceAmount*100
        let percent = String(format: "%.0f%%", exactPercent)
        
        percentLabel.text = percent
        
        self.view.backgroundColor = UIColor(red: forceAmount, green: forceAmount, blue: forceAmount, alpha: 1).inverse()
        
        adviseLabel.textColor = UIColor(red: forceAmount, green: forceAmount, blue: forceAmount, alpha: 1)
        percentLabel.textColor = UIColor(red: forceAmount, green: forceAmount, blue: forceAmount, alpha: 1)

        setNeedsStatusBarAppearanceUpdate()
    }

    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return forceAmount > 0.5 ? .LightContent : .Default
    }
}

extension UIColor {
    func inverse () -> UIColor {
        var r:CGFloat = 0.0; var g:CGFloat = 0.0; var b:CGFloat = 0.0; var a:CGFloat = 0.0;
        if self.getRed(&r, green: &g, blue: &b, alpha: &a) {
            return UIColor(red: 1.0-r, green: 1.0 - g, blue: 1.0 - b, alpha: a)
        }
        return self
    }
}
