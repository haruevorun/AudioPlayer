//
//  ViewController.swift
//  AudioPlayer
//
//  Created by haruta yamada on 2019/01/17.
//  Copyright © 2019 teranyan. All rights reserved.
//

import UIKit
import IGListKit

class AudioListViewController: UIViewController {

    @IBOutlet weak var audioListView: UICollectionView!
    
    private var dataSource: AudioListDataSource = AudioListDataSource()
    lazy var adapter: ListAdapter = {
       return ListAdapter(updater: ListAdapterUpdater(), viewController: self)
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        adapter.collectionView = self.audioListView
    }

}

