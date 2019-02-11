//
//  PlaylistDetailTableViewCell.swift
//  AudioPlayer
//
//  Created by haruta yamada on 2019/02/10.
//  Copyright © 2019 teranyan. All rights reserved.
//

import UIKit
import MediaPlayer

class PlaylistDetailTableViewCell: UITableViewCell {

    @IBOutlet private weak var artworkImageShadowView: UIView!
    @IBOutlet private weak var artworkImageView: UIImageView!
    @IBOutlet private weak var titleLabel: UILabel!
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

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    func updateView(item: MPMediaItem?) {
        self.titleLabel.text = item?.title
        self.artworkImageView.image = item?.artwork?.image(at: MPMediaItem.albamJacketThumbnailSize) ?? UIImage(named: "app_Icon")
        self.durationLabel.text = Calendar.timeToString(time: Float(item?.playbackDuration ?? 0))
    }
    
}
