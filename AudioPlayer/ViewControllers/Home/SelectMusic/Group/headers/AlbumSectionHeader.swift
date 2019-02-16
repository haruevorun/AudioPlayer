//
//  AlbumSectionHeader.swift
//  AudioPlayer
//
//  Created by haruta yamada on 2019/02/12.
//  Copyright © 2019 teranyan. All rights reserved.
//

import UIKit
import MediaPlayer

class AlbumSectionHeader: UITableViewHeaderFooterView {

    @IBOutlet private weak var albumTitle: UILabel!
    @IBOutlet private weak var albumArtist: UILabel!
    @IBOutlet private weak var artworkImageView: UIImageView!
    @IBOutlet private weak var artworkImageShadowView: UIView!
    override func awakeFromNib() {
        super.awakeFromNib()
        self.artworkImageView.layer.cornerRadius = 10
        self.artworkImageShadowView.layer.cornerRadius = 10
        self.artworkImageView.layer.masksToBounds = true
        self.artworkImageShadowView.layer.shadowOffset = CGSize(width: 1, height: 1)
        self.artworkImageShadowView.layer.shadowRadius = 4
        self.artworkImageShadowView.layer.shadowOpacity = 0.4
    }
    func updateView(item: MPMediaItem?) {
        self.artworkImageView.image = item?.artwork?.image(at: MPMediaItem.albumJacketThumbnailSize)
        self.albumTitle.text = item?.albumTitle
        self.albumArtist.text = item?.artist
    }
    

}
