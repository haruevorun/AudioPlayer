//
//  AlbamListDataSource.swift
//  AudioPlayer
//
//  Created by haruta yamada on 2019/01/29.
//  Copyright © 2019 teranyan. All rights reserved.
//

import Foundation
import UIKit
import MediaPlayer

class AlbamListDataSource: NSObject, UITableViewDataSource {
    private var albams: [MPMediaItemCollection]
    override init() {
        self.albams = []
        super.init()
    }
    func fetchAlbam() -> Bool {
        let albamQuery = MPMediaQuery.albums()
        guard let albams = albamQuery.collections else {
            return false
        }
        self.albams = albams
        return true
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print(albams.count)
        return albams.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "AlbamCell", for: indexPath) as? AlbamListCell else {
            fatalError()
        }
        cell.titleLabel.text = albams[indexPath.item].representativeItem?.albumTitle
        return cell
    }
}
