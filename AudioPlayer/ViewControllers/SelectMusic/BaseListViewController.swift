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
    
    private let backGroundView: UIView = {
        let view = UIView(frame: UIScreen.main.bounds)
        view.backgroundColor = UIColor.white
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
    private(set) var queueController: MediaPlayerInputQueueProtocol = AudioPlayer.shared
    
    private(set) lazy var tableView: UITableView = {
        let tableView = UITableView(frame: self.view.frame, style: UITableView.Style.plain)
        return tableView
    }()
    override func loadView() {
        super.loadView()
        self.view = backGroundView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.view.addSubview(tableView)
    }

}
extension BaseListViewController: MediaItemsFetchResult {
    func finishedFetchQuery(query: MPMediaQuery?) {
        self.query = query
    }
}
