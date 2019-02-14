//
//  ArtistDetailListViewController.swift
//  AudioPlayer
//
//  Created by haruta yamada on 2019/02/09.
//  Copyright © 2019 teranyan. All rights reserved.
//

import UIKit
import MediaPlayer

class ArtistDetailListViewController: BaseListViewController {

    var artistName: String?
    
    private var artistHeight: CGFloat = 70
    private var albumHeight: CGFloat = 100
    deinit {
        DebugUtil.log("ArtistDetailList is deinit")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.register(UINib(nibName: "ArtistPlayListTableViewCell", bundle: nil), forCellReuseIdentifier: "PlayList")
        self.tableView.register(UINib(nibName: "ArtistDetailTableViewCell", bundle: nil), forCellReuseIdentifier: "Detail")
        self.tableView.dataSource = self
        self.tableView.delegate = self
        self.queryFilter = [MPMediaPropertyPredicate(value: artistName, forProperty: MPMediaItemPropertyArtist, comparisonType: .equalTo)]
        self.queryFetch(case: .album)
    }
}
extension ArtistDetailListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.section {
        case 0:
            return artistHeight
        default:
            return albumHeight
        }
    }
    func tableView(_ tableView: UITableView, shouldHighlightRowAt indexPath: IndexPath) -> Bool {
        switch indexPath.section {
        case 0:
            return false
        default:
            return true
        }
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let albumDetailView = AlbumDetailListViewController()
        guard let title = query?.collections?[indexPath.item].representativeItem?.albumTitle else {
            return
        }
        albumDetailView.albumTitle = title
        self.navigationController?.show(albumDetailView, sender: nil)
    }
}
extension ArtistDetailListViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 1
        default:
            return query?.collections?.count ?? 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "Detail", for: indexPath) as? ArtistDetailTableViewCell else {
                fatalError()
            }
            cell.updateView(artist: artistName)
            return cell
        default:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "PlayList", for: indexPath) as? ArtistPlayListTableViewCell else {
                fatalError()
            }
            cell.updateView(collection: query?.collections?[indexPath.item])
            return cell
        }
    }
}
