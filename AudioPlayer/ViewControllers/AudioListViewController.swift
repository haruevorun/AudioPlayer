//
//  ViewController.swift
//  AudioPlayer
//
//  Created by haruta yamada on 2019/01/17.
//  Copyright © 2019 teranyan. All rights reserved.
//

import UIKit
import IGListKit
import MediaPlayer

class AudioListViewController: UIViewController {

    @IBOutlet weak var audioListView: UICollectionView!
    
    private let modalViewRatio: CGFloat = 0.8
    private var initializePoint: CGPoint = CGPoint.zero
    
    private var audioPlayerController: ModalAudioPlayViewController = {
        guard let viewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "modal") as? ModalAudioPlayViewController else {
            fatalError()
        }
        return viewController
    }()
    
    private lazy var modalPlayerContainer: UIView = {
        let view = UIView(frame: CGRect(x: 0, y: UIScreen.main.bounds.height * (1.0 - self.modalViewRatio), width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height * modalViewRatio))
        view.addGestureRecognizer(UIPanGestureRecognizer(target: self, action: #selector(verticalSwipe(_:))))
        view.backgroundColor = UIColor.white
        view.layer.cornerRadius = 10
        view.clipsToBounds = true
        view.layer.shadowOffset = CGSize(width: 2, height: 2)
        view.layer.shadowRadius = 4
        view.layer.shadowOpacity = 0.8
        return view
    }()
    
    private var dataSource: AudioListDataSource = AudioListDataSource()
    lazy var adapter: ListAdapter = {
       return ListAdapter(updater: ListAdapterUpdater(), viewController: self)
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.dataSource.delegate = self
        dataSource.request()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.adapter.collectionView = self.audioListView
        self.adapter.dataSource = self.dataSource
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    func presentAudioView(item: MPMediaItem) {
        self.modalPlayerContainer.removeFromSuperview()
        let modalView = self.modalPlayerContainer
        audioPlayerController.collection = MPMediaItemCollection(items: [item])
        //audioPlayerController.delegate = self
        self.hideContentController(content: self.audioPlayerController)
        displayContentController(content: audioPlayerController, container: modalView)
        modalView.frame.origin = CGPoint(x: 0, y: self.view.frame.height)
        let pangesture = UIPanGestureRecognizer(target: self, action: #selector(verticalSwipe(_:)))
        pangesture.delegate = self
        modalView.addGestureRecognizer(pangesture)
        modalView.backgroundColor = UIColor.cyan
        self.view.addSubview(modalView)
        UIView.animate(withDuration: 1.2, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0, options: .curveEaseInOut, animations: {
            modalView.frame.origin = CGPoint(x: 0, y: UIScreen.main.bounds.height * (1.0 - self.modalViewRatio))
        }, completion: nil)
    }
    
    @objc private func verticalSwipe(_ sender: UIPanGestureRecognizer) {
        guard let view = sender.view else {
            return
        }
        let point = sender.translation(in: self.view)
        switch sender.state {
        case .began:
            self.initializePoint = point
        case .changed:
            guard self.audioPlayerController.collectionView.contentOffset.y == 0 else {
                return
            }
            let len = point.y - self.initializePoint.y
            guard len > 0 else {
                return
            }
            self.modalPlayerContainer.frame.origin = CGPoint(x: view.frame.origin.x, y: (UIScreen.main.bounds.height * (1.0 - self.modalViewRatio)) + len * 0.9)
        case .cancelled, .ended:
            let len = point.y  - self.initializePoint.y
            defer {
                self.initializePoint = CGPoint.zero
            }
            guard len > self.view.frame.height * 0.2 else {
                UIView.animate(withDuration: 0.5) {
                    self.modalPlayerContainer.frame.origin = CGPoint(x: 0, y: UIScreen.main.bounds.height * (1.0 - self.modalViewRatio))
                }
                return
            }
            UIView.animate(withDuration: 0.5, animations: {
                self.modalPlayerContainer.frame.origin = CGPoint(x: 0, y: self.view.frame.height)
            })
        default:
            return
        }
    }
}
extension AudioListViewController {
    func displayContentController(content:UIViewController, container:UIView){
        addChild(content)
        content.view.frame = container.bounds
        container.addSubview(content.view)
        content.didMove(toParent: self)
    }
    func hideContentController(content:UIViewController){
        content.willMove(toParent: self)
        content.view.removeFromSuperview()
        content.removeFromParent()
    }
}
extension AudioListViewController: UIGestureRecognizerDelegate {
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
}
extension AudioListViewController: AudioListDataSourceDelegate {
    func updateItem() {
        self.adapter.performUpdates(animated: true, completion: nil)
    }
}
