//
//  ModalAudioPlayViewController.swift
//  AudioPlayer
//
//  Created by haruta yamada on 2019/01/18.
//  Copyright © 2019 teranyan. All rights reserved.
//

import Foundation
import UIKit
import MediaPlayer
import IGListKit

class ModalAudioPlayViewController: UIViewController {
    @IBOutlet weak var collectionView: UICollectionView!
    var collection: MPMediaItemCollection?
    lazy var adapter: ListAdapter = ListAdapter(updater: ListAdapterUpdater(), viewController: self)
    override func viewDidLoad() {
        super.viewDidLoad()
        self.adapter.collectionView = collectionView
        self.adapter.dataSource = self
    }
}
extension ModalAudioPlayViewController: ListAdapterDataSource {
    func objects(for listAdapter: ListAdapter) -> [ListDiffable] {
        return [collection!]
    }
    
    func listAdapter(_ listAdapter: ListAdapter, sectionControllerFor object: Any) -> ListSectionController {
        return AudioPlayerSectionController()
    }
    
    func emptyView(for listAdapter: ListAdapter) -> UIView? {
        return nil
    }
}
