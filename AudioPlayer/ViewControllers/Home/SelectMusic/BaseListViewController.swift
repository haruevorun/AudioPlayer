//
//  AlbamDetailViewController.swift
//  AudioPlayer
//
//  Created by haruta yamada on 2019/02/07.
//  Copyright © 2019 teranyan. All rights reserved.
//

import UIKit
import MediaPlayer

class BaseListViewController: UIViewController {
    
    let miniControllerHeight: CGFloat = 60
    
    private let backgroundView: UIView = {
        let view = UIView(frame: UIScreen.main.bounds)
        return view
    }()
    private(set) var query: MPMediaQuery? {
        didSet {
            self.tableView.reloadData()
        }
    }
    private(set) lazy var fetcher: MediaQueryFetcher = {
        let fetcher = MediaQueryFetcher()
        fetcher.output = self
        return fetcher
    }()
    let queueController: MediaPlayerInputQueueProtocol = AudioPlayer.shared
    let queue: MediaPlayerOutputQueueProtocol = AudioPlayer.shared
    
    private(set) lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    override func loadView() {
        super.loadView()
        self.view = backgroundView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.view.addSubview(tableView)
        self.tableView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
        self.tableView.topAnchor.constraint(equalTo: self.view.topAnchor).isActive = true
        self.tableView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
        self.tableView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        self.tableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 60, right: 0)
        self.tableView.tableFooterView = UIView(frame: CGRect.zero)
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if let selectIndex = self.tableView.indexPathForSelectedRow {
            self.tableView.deselectRow(at: selectIndex, animated: true)
        }
    }
}
extension BaseListViewController: MediaItemsFetchResult {
    func finishedFetchQuery(query: MPMediaQuery?) {
        self.query = query
    }
}
