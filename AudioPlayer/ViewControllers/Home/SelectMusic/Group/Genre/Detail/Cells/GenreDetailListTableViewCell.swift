//
//  GenreDetailListTableViewCell.swift
//  AudioPlayer
//
//  Created by haruta yamada on 2019/02/10.
//  Copyright © 2019 teranyan. All rights reserved.
//

import UIKit
import MediaPlayer

class GenreDetailListTableViewCell: UITableViewCell {

    @IBOutlet private weak var artworkImageView: UIImageView!
    @IBOutlet private weak var artworkImageShadowView: UIView!
    @IBOutlet private weak var albumTitleLabel: UILabel!
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var artistLabel: UILabel!
    @IBOutlet private weak var durationLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.artworkImageView.layer.cornerRadius = 10
        self.artworkImageShadowView.layer.cornerRadius = 10
        self.artworkImageView.layer.masksToBounds = true
        self.artworkImageShadowView.layer.shadowOffset = CGSize(width: 1, height: 1)
        self.artworkImageShadowView.layer.shadowRadius = 4
        self.artworkImageShadowView.layer.shadowOpacity = 0.4
    }
    func updateView(item: MPMediaItem?) {
        self.artworkImageView.image = item?.artwork?.image(at: MPMediaItem.albamJacketThumbnailSize) ?? UIImage(named: "app_Icon")
        self.albumTitleLabel.text = item?.albumTitle
        self.titleLabel.text = item?.title
        self.artistLabel.text = item?.artist
        self.durationLabel.text = Calendar.timeToString(time: Float(item?.playbackDuration ?? 0))
    }
    
}
