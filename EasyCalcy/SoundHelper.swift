//
//  SoundHelper.swift
//  EasyCalcy
//
//  Created by Sayali Joshi on 2/6/16.
//  Copyright © 2016 Sayali Joshi. All rights reserved.
//

import Foundation
import AVFoundation

class SoundHelper
{
    static func play(systemSoundID: SystemSoundID)
    {
        AudioServicesPlaySystemSound (systemSoundID)
    }
}