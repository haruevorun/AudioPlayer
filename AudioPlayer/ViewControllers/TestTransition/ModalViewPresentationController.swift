//
//  ModalViewPresentationController.swift
//  AudioPlayer
//
//  Created by haruta yamada on 2019/01/19.
//  Copyright © 2019 teranyan. All rights reserved.
//

import Foundation
import UIKit

class ModalViewPresentationController: UIPresentationController {
    override var frameOfPresentedViewInContainerView: CGRect {
        guard var rect: CGRect = self.containerView?.frame else {
            return CGRect.zero
        }
        rect.origin = CGPoint(x: rect.origin.x, y: rect.height - self.modalViewHeight)
        rect.size = CGSize(width: rect.size.width, height: self.modalViewHeight)
        return rect
    }
    
    private var topMargin = 60
    private var modalViewHeight: CGFloat = 0
    
    override func containerViewWillLayoutSubviews() {
        self.presentedView?.frame = self.frameOfPresentedViewInContainerView
    }
    
    func setModalViewHeight(_ height: CGFloat) {
        self.modalViewHeight = height
        presentedView?.frame = self.frameOfPresentedViewInContainerView
    }
}
