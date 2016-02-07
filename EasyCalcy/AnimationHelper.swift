//
//  AnimationHelper.swift
//  EasyCalcy
//
//  Created by Sayali Joshi Hande on 2/7/16.
//  Copyright © 2016 Sayali. All rights reserved.
//

import Foundation
import UIKit

class AnimationHelper
{
    static func addAnimation(clickButton: UIButton)
    {
        UIView.animateWithDuration(0.01 ,
            animations: {
                clickButton.transform = CGAffineTransformMakeScale(0.9, 0.9)
            },
            completion: { finish in
                UIView.animateWithDuration(0.01){
                    clickButton.transform = CGAffineTransformIdentity
                }
        })
        
    }

}