//
//  CustomMiniAudioPlayerSlider.swift
//  AudioPlayer
//
//  Created by haruta yamada on 2019/02/08.
//  Copyright © 2019 teranyan. All rights reserved.
//

import Foundation
import UIKit

class CustomMiniAudioPlayerSlider: UISlider {

    override func thumbImage(for state: UIControl.State) -> UIImage? {
        return nil
    }
    override func beginTracking(_ touch: UITouch, with event: UIEvent?) -> Bool {
        return true
    }
    override func point(inside point: CGPoint, with event: UIEvent?) -> Bool {
        var bounds = self.bounds
        bounds.size.height += 10
        return bounds.contains(point)
    }
    override func minimumValueImageRect(forBounds bounds: CGRect) -> CGRect {
        var newbounds = bounds
        newbounds.size.height = self.bounds.height
        return newbounds
    }
    override func maximumValueImageRect(forBounds bounds: CGRect) -> CGRect {
        var newbounds = bounds
        newbounds.size.height = self.bounds.height
        return newbounds
    }
}
