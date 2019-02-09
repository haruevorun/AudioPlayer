//
//  HomeViewController.swift
//  AudioPlayer
//
//  Created by haruta yamada on 2019/02/09.
//  Copyright © 2019 teranyan. All rights reserved.
//

import Foundation
import UIKit

class HomeViewController: BaseListViewController {
    var collection: [String] = ["Albams","Artist","PlayList","Genre"]
    let cellHeight: CGFloat = 50
    let headerHeight: CGFloat = 70
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.register(UINib(nibName: "HomeListTableViewCell", bundle: nil), forCellReuseIdentifier: "List")
        self.tableView.register(UINib(nibName: "HomeHeaderView", bundle: nil), forHeaderFooterViewReuseIdentifier: "header")
        self.tableView.dataSource = self
        self.tableView.delegate = self
        self.tableView.tableFooterView = UIView(frame: CGRect.zero)
        self.tableView.backgroundColor = UIColor.white
    }
}
extension HomeViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return cellHeight
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return headerHeight
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.item {
        case 0:
            let albamview = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "Albam")
            self.navigationController?.show(albamview, sender: nil)
        default:
            return
        }
    }
}
extension HomeViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.collection.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "List", for: indexPath) as? HomeListTableViewCell else {
            fatalError()
        }
        cell.updateView(text: collection[indexPath.item])
        return cell
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let view = tableView.dequeueReusableHeaderFooterView(withIdentifier: "header") as? HomeHeaderView else {
            fatalError()
        }
        return view
    }
}
