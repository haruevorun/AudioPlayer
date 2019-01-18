//
//  ModalAudioPlayViewController.swift
//  AudioPlayer
//
//  Created by haruta yamada on 2019/01/18.
//  Copyright © 2019 teranyan. All rights reserved.
//

import Foundation
import UIKit

class ModalAudioPlayViewController: UIViewController {
    @IBOutlet weak var modalView: UIView!
    let interacter = UIPercentDrivenInteractiveTransition()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //self.modalView.addGestureRecognizer(UIPanGestureRecognizer(target: self, action: #selector(verticalSwipe(_:))))
        //self.transitioningDelegate = self
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
    }
    @objc private func verticalSwipe(_ sender: UIPanGestureRecognizer) {
        guard let view = sender.view else { return }
        switch sender.state {
        case .began:
            self.dismiss(animated: true, completion: nil)
        case .changed:
            let progress = sender.translation(in: view).y / view.bounds.height
            interacter.update(progress)
        case .cancelled, .ended:
            let progress = sender.translation(in: view).y / view.bounds.height
            if progress > 0.8 {
              interacter.finish()
            } else {
              interacter.cancel()
            }
        default: return
        }
    }
}
extension ModalAudioPlayViewController: NavigationTransitionerDelegate {
    func shouldBeginGesture(gesture: UIGestureRecognizer) -> Bool {
        return true
    }
    
    func pop() {
        self.dismiss(animated: true, completion: nil)
    }
}
extension ModalAudioPlayViewController: UIViewControllerTransitioningDelegate {
    func interactionControllerForDismissal(using animator: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning? {
        return interacter
    }
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return DismissModalViewAnimation()
    }
}
