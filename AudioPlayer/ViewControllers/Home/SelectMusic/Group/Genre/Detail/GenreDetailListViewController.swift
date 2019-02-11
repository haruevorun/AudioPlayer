//
//  GenreDetailViewController.swift
//  AudioPlayer
//
//  Created by haruta yamada on 2019/02/10.
//  Copyright © 2019 teranyan. All rights reserved.
//

import Foundation
import UIKit
import MediaPlayer

class GenreDetailListViewController: BaseListViewController {
    let cellHeight: CGFloat = 60
    let headerHeight: CGFloat = 70
    var genre: String?
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.register(UINib(nibName: "HomeHeaderView", bundle: nil), forHeaderFooterViewReuseIdentifier: "header")
        self.tableView.register(UINib(nibName: "GenreDetailListTableViewCell", bundle: nil), forCellReuseIdentifier: "List")
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.fetcher.fetch(with: genre, fetchGroup: .genre, isAppleMusic: false)
    }
}
extension GenreDetailListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return cellHeight
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return headerHeight
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let view = tableView.dequeueReusableHeaderFooterView(withIdentifier: "header") as? HomeHeaderView else {
            fatalError()
        }
        view.updateView(text: genre ?? "")
        return view
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        guard let query = query else {
            return
        }
        guard queue.currentQueue?.persistentID != query.items?[indexPath.item].persistentID else {
            return
        }
        self.queueController.setQueue(query: query, firstPlayIndex: indexPath.item, isPlay: true)
    }
}
extension GenreDetailListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return query?.items?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "List", for: indexPath) as? GenreDetailListTableViewCell else {
            fatalError()
        }
        cell.updateView(item: self.query?.items?[indexPath.item])
        return cell
    }
}
