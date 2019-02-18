//
//  ExtensionUIImage.swift
//  AudioPlayer
//
//  Created by haruta yamada on 2019/02/18.
//  Copyright © 2019 teranyan. All rights reserved.
//

import Foundation
import UIKit

extension UIImage {
    enum iconSize {
        case regular
        case mini
    }
    static func playIcon(size: iconSize) -> UIImage? {
        switch size {
        case .regular:
            return UIImage(named: "round-play_arrow")
        case .mini:
            return UIImage(named: "round_play_arrow_black_48pt")
        }
    }
    static func pauseIcon(size: iconSize) -> UIImage? {
        switch size {
        case .regular:
            return UIImage(named: "round-pause")
        case .mini:
            return UIImage(named: "round_pause_black_48pt")
        }
    }
    static func skipIcon(size: iconSize) -> UIImage? {
        switch size {
        case .regular:
            return UIImage(named: "round-skip_next")
        case .mini:
            return UIImage(named: "round_skip_next_black_48pt")
        }
    }
    static func skipPreviousIcon(size: iconSize) -> UIImage? {
        switch size {
        case .regular:
            return UIImage(named: "round-skip_previous")
        case .mini:
            return UIImage(named: "round_skip_previous_black_48pt")
        }
    }
}
