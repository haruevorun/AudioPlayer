//
//  TransitionDelegate.swift
//  AudioPlayer
//
//  Created by haruta yamada on 2019/02/14.
//  Copyright © 2019 teranyan. All rights reserved.
//

import Foundation
import UIKit

class TransitionDelegate: NSObject, UIViewControllerTransitioningDelegate {
    func presentationController(forPresented presented: UIViewController, presenting: UIViewController?, source: UIViewController) -> UIPresentationController? {
        return nil
    }
}
