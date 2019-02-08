//
//  AlbamListViewController.swift
//  AudioPlayer
//
//  Created by haruta yamada on 2019/01/29.
//  Copyright © 2019 teranyan. All rights reserved.
//

import Foundation
import UIKit
import MediaPlayer

class AlbamListViewController: UIViewController {
    
    @IBOutlet weak var albamTable: UITableView!
    
    var datasource = AlbamListDataSource()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.albamTable.register(UINib(nibName: "AlbamListCell", bundle: nil), forCellReuseIdentifier: "AlbamCell")
        self.albamTable.dataSource = self.datasource
        self.albamTable.delegate = self
        self.albamTable.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 60, right: 0)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.generateAlbamTable()
    }
    private func generateAlbamTable() {
        guard datasource.fetchAlbam() else {
            return
        }
        self.albamTable.reloadData()
    }
}
extension AlbamListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
    func tableView(_ tableView: UITableView, didHighlightRowAt indexPath: IndexPath) {
        let albamDetailView = AlbamDetailListViewController()
        guard let title = datasource.requestItem(index: indexPath.item)?.representativeItem?.albumTitle else {
            return
        }
        albamDetailView.albamTitle = title
        self.navigationController?.show(albamDetailView, sender: nil)
    }
}
