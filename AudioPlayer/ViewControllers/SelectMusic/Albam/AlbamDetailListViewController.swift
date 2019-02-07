//
//  AlbamDetailListViewController.swift
//  AudioPlayer
//
//  Created by haruta yamada on 2019/02/07.
//  Copyright © 2019 teranyan. All rights reserved.
//

import UIKit

class AlbamDetailListViewController: BaseListViewController {

    private let albamViewHeight: CGFloat = 150
    private let listViewHeight: CGFloat = 50
    
    var albamTitle: String? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.register(UINib(nibName: "AlbamDetailTableViewCell", bundle: nil), forCellReuseIdentifier: "Albam")
        self.tableView.register(UINib(nibName: "AlbamPlayListTableViewCell", bundle: nil), forCellReuseIdentifier: "List")
        self.tableView.dataSource = self
        self.tableView.delegate = self
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.fetcher.fetch(with: self.albamTitle, fetchGroup: .album, isAppleMusic: false)
    }
}
extension AlbamDetailListViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 1
        default:
            return self.query?.items?.count ?? 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "Albam", for: indexPath) as? AlbamDetailTableViewCell else {
                fatalError()
            }
            let item = self.query?.collections?[0].representativeItem
            cell.updateView(item: item)
            return cell
        default:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "List", for: indexPath) as? AlbamPlayListTableViewCell else {
                fatalError()
            }
            cell.updateCell(index: indexPath.item, title: self.query?.items?[indexPath.item].title ?? "")
            return cell
        }
    }
}
extension AlbamDetailListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.section {
        case 0:
            return self.albamViewHeight
        default:
            return self.listViewHeight
        }
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let query = query else {
            return
        }
        self.queueController.setQueue(query: query, firstPlayIndex: indexPath.item, isPlay: true)
    }
}
