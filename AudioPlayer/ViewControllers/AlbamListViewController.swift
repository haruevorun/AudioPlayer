//
//  AlbamListViewController.swift
//  AudioPlayer
//
//  Created by haruta yamada on 2019/01/29.
//  Copyright © 2019 teranyan. All rights reserved.
//

import Foundation
import UIKit

class AlbamListViewController: UIViewController {
    
    @IBOutlet weak var albamTable: UITableView!
    
    var datasource = AlbamListDataSource()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.albamTable.register(UINib(nibName: "AlbamListCell", bundle: nil), forCellReuseIdentifier: "AlbamCell")
        self.albamTable.dataSource = self.datasource
        self.albamTable.delegate = self
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
}
