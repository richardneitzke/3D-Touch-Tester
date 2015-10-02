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

    override func viewDidLoad() {
        super.viewDidLoad()
        
        switch self.traitCollection.forceTouchCapability {
        case .Available: return
        default: adviseLabel.text = "Unsupported device!"
            percentLabel.text = "Error!"
        }
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        handleTouch(touches.first!)
    }
    
    override func touchesMoved(touches: Set<UITouch>, withEvent event: UIEvent?) {
        handleTouch(touches.first!)
    }
    
    override func touchesEnded(touches: Set<UITouch>, withEvent event: UIEvent?) {
        self.view.backgroundColor = UIColor(white: 1, alpha: 1)
        
        adviseLabel.textColor = UIColor.blackColor()
        percentLabel.textColor = UIColor.blackColor()
        
        percentLabel.text = "0%"
    }
    
    func handleTouch(touch:UITouch) {
        
        let exactPercent = touch.force/touch.maximumPossibleForce*100
        let percent = String(format: "%.0f%%", exactPercent)
        
        percentLabel.text = percent
        
        self.view.backgroundColor = UIColor(red: touch.force/touch.maximumPossibleForce, green: touch.force/touch.maximumPossibleForce, blue: touch.force/touch.maximumPossibleForce, alpha: 1).inverse()
        
        adviseLabel.textColor = UIColor(red: touch.force/touch.maximumPossibleForce, green: touch.force/touch.maximumPossibleForce, blue: touch.force/touch.maximumPossibleForce, alpha: 1)
        percentLabel.textColor = UIColor(red: touch.force/touch.maximumPossibleForce, green: touch.force/touch.maximumPossibleForce, blue: touch.force/touch.maximumPossibleForce, alpha: 1)
        
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