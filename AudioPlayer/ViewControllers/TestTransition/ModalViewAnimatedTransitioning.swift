//
//  ModalViewAnimatedTransitioning.swift
//  AudioPlayer
//
//  Created by haruta yamada on 2019/01/19.
//  Copyright © 2019 teranyan. All rights reserved.
//

import Foundation
import UIKit

class ModalViewAnimatedTransitioning: NSObject, UIViewControllerTransitioningDelegate {
    
    func presentationController(forPresented presented: UIViewController, presenting: UIViewController?, source: UIViewController) -> UIPresentationController? {
        return ModalViewPresentationController(presentedViewController: presented, presenting: presenting)
    }
}
