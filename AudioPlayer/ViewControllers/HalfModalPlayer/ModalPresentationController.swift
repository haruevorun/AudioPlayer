//
//  ModalPresentationController.swift
//  AudioPlayer
//
//  Created by haruta yamada on 2019/02/14.
//  Copyright © 2019 teranyan. All rights reserved.
//

import Foundation
import UIKit

class ModalPresentationViewController: UIPresentationController {
    
    private(set) var tapGestureRecognizer: UITapGestureRecognizer?
    private let overlay = UIView()
    let margin: CGFloat = 60
    private var modalViewHeight: CGFloat = 0
    
    override var frameOfPresentedViewInContainerView: CGRect {
        var frame = containerView!.frame
        frame.origin.y = frame.height - self.modalViewHeight
        frame.size.height = self.modalViewHeight
        return frame
    }
    
    var backdropViewController: UIViewController {
        return self.presentingViewController
    }
    
    var frontViewController: UIViewController {
        return self.presentedViewController
    }
    
    func setModalViewHeight(_ newHeight: CGFloat, animated: Bool) {
        guard let presentedView = self.presentedView else {
            return
        }
        
        self.modalViewHeight = newHeight
        
        let frame = self.frameOfPresentedViewInContainerView
        
        if animated == false {
            presentedView.frame = frame
            return
        }
        UIView.perform(.delete,
                       on: [],
                       options: [.beginFromCurrentState, .allowUserInteraction],
                       animations: {
                        presentedView.frame = frame
                        presentedView.layoutIfNeeded()
        }, completion: nil)
    }
    
    private func setupOverlay(toContainerView: UIView) {
        self.tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(tapOnOverlay(_:)))
        self.tapGestureRecognizer!.isEnabled = true
        
        self.overlay.frame = toContainerView.bounds
        self.overlay.backgroundColor = UIColor.black
        self.overlay.alpha = 0.0
        self.overlay.gestureRecognizers = [self.tapGestureRecognizer!]
        
        toContainerView.insertSubview(self.overlay, at: 0)
    }
    @objc private func tapOnOverlay(_ gesture: UITapGestureRecognizer) {
        self.frontViewController.dismiss(animated: true, completion: nil)
    }
}
