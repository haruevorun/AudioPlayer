//
//  GenreListViewController.swift
//  AudioPlayer
//
//  Created by haruta yamada on 2019/02/10.
//  Copyright © 2019 teranyan. All rights reserved.
//

import Foundation
import UIKit
import MediaPlayer

class GenreListViewController: BaseListViewController {
    let cellHeight: CGFloat = 50
    let headerHeight: CGFloat = 70
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.register(UINib(nibName: "GenreListTableViewCell", bundle: nil), forCellReuseIdentifier: "List")
        self.tableView.register(UINib(nibName: "HomeHeaderView", bundle: nil), forHeaderFooterViewReuseIdentifier: "header")
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.queryFetch(case: .genres)
    }
}
extension GenreListViewController: UITableViewDelegate {
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
        view.updateView(text: "Genre")
        return view
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let detailView = GenreDetailListViewController()
        detailView.genre = self.query?.collections?.map {$0.representativeItem?.genre}[indexPath.item]
        self.navigationController?.show(detailView, sender: nil)
    }
}
extension GenreListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.query?.collections?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "List", for: indexPath) as? GenreListTableViewCell else {
            fatalError()
        }
        cell.updateView(text: self.query?.collections?.map {$0.representativeItem?.genre}[indexPath.item])
        return cell
    }
}
