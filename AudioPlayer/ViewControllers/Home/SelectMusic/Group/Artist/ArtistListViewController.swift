//
//  ArtistListViewController.swift
//  AudioPlayer
//
//  Created by haruta yamada on 2019/02/03.
//  Copyright © 2019 teranyan. All rights reserved.
//

import UIKit
import MediaPlayer

class ArtistListViewController: BaseListViewController {
    
    let cellHeight: CGFloat = 50
    let headerHeight: CGFloat = 70
    deinit {
        DebugUtil.log("ArtistList is deinit")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.register(UINib(nibName: "ArtistListTableViewCell", bundle: nil), forCellReuseIdentifier: "List")
        self.tableView.register(UINib(nibName: "HomeHeaderView", bundle: nil), forHeaderFooterViewReuseIdentifier: "header")
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.queryFetch(case: .artist)
    }
    private func uniqueCollection(collection: [MPMediaItemCollection]) -> [String] {
        let orderSet: NSOrderedSet = NSOrderedSet(array: collection.compactMap {$0.representativeItem?.albumArtist})
        guard let array = orderSet.array as? [String] else {
            fatalError()
        }
        return array
    }
}
extension ArtistListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return self.cellHeight
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return self.headerHeight
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let detailView = AritistDetailListViewController()
        guard let collection = self.query?.collections else {
            return
        }
        detailView.artistName = self.uniqueCollection(collection: collection)[indexPath.item]
        self.navigationController?.show(detailView, sender: nil)
    }
}
extension ArtistListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let collection = self.query?.collections else {
            return 0
        }
        return uniqueCollection(collection: collection).count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "List", for: indexPath) as? ArtistListTableViewCell else {
            fatalError()
        }
        guard let collection = self.query?.collections else {
            return cell
        }
        cell.updateView(artist: self.uniqueCollection(collection: collection)[indexPath.item])
        return cell
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let view = tableView.dequeueReusableHeaderFooterView(withIdentifier: "header") as? HomeHeaderView else {
            fatalError()
        }
        view.updateView(text: "Artist")
        return view
    }
}
