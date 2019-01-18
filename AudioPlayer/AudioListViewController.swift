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

}
extension AudioListViewController: AudioListDataSourceDelegate {
    func updateItem() {
        self.adapter.performUpdates(animated: true, completion: nil)
    }
}

