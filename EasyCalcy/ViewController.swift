//
//  ViewController.swift
//  EasyCalcy
//
//  Created by Sayali Joshi on 2/1/16.
//  Copyright © 2016 Sayali. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController
{
    
    var calculator: Calculator = Calculator()
    @IBOutlet var historyLabel: UILabel!

    @IBOutlet var displayResult: UILabel!
    var player : AVAudioPlayer = AVAudioPlayer()

    override func viewDidLoad()
    {
        super.viewDidLoad()
        self.calculator.setLabel(displayResult, historyLabel: historyLabel)
    }
    
    override func canBecomeFirstResponder() -> Bool
    {
        return true
    }
    
    override func motionEnded(motion: UIEventSubtype, withEvent event: UIEvent?)
    {
        if motion == .MotionShake //Just shake the phone to reset !
        {
            calculator.resetAll()
        }
    }
    
    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
   
    @IBAction func resetAll(sender: UIButton)
    {
        self.onButtonClickActivities(sender)
        calculator.resetAll()
    }
   
    @IBAction func plusMinusOperator(sender: UIButton)
    {
        self.onButtonClickActivities(sender)
        calculator.negationOperator(sender)
    }
    
    @IBAction func dotPressed(sender: UIButton)
    {
        self.onButtonClickActivities(sender)
        calculator.dotEntered(sender)
    }
    @IBAction func digitPressed(sender: UIButton)
    {
        self.onButtonClickActivities(sender)
        self.calculator.digitEntered(sender.titleLabel!.text!)
    }

    @IBAction func operatorPressed(sender: UIButton)
    {
        self.onButtonClickActivities(sender)
        self.calculator.operatorEntered(sender.titleLabel!.text!)
    }
    
    func onButtonClickActivities(sender: UIButton)
    {
        AnimationHelper.addAnimation(sender)
        SoundHelper.play(1104)
    }
    
    
}
