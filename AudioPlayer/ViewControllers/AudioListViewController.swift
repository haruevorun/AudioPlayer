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
        view.backgroundColor = UIColor.white
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
        
        guard let viewController = self.storyboard?.instantiateViewController(withIdentifier: "MusicPlayer") as? MusicPlayer else {
            return
        }
        viewController.item = item
        self.navigationController?.show(viewController, sender: nil)
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
extension AudioListViewController: AudioListDataSourceDelegate {
    func updateItem() {
        self.adapter.performUpdates(animated: true, completion: nil)
    }
}
