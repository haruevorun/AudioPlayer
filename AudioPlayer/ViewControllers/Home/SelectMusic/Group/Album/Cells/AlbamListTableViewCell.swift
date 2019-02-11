//
//  AlbamListTableViewCell.swift
//  AudioPlayer
//
//  Created by haruta yamada on 2019/02/09.
//  Copyright © 2019 teranyan. All rights reserved.
//

import Foundation
import UIKit
import MediaPlayer

class AlbumListTableViewCell: UITableViewCell {

    @IBOutlet weak var artworkImageView: UIImageView!
    @IBOutlet weak var artworkImageShadowView: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var artistLabel: UILabel!
    @IBOutlet weak var releaseLabel: UILabel!
    @IBOutlet weak var detailButton: UIButton!
    override func awakeFromNib() {
        super.awakeFromNib()
        self.artworkImageView.layer.cornerRadius = 10
        self.artworkImageShadowView.layer.cornerRadius = 10
        self.artworkImageView.layer.masksToBounds = true
        self.artworkImageShadowView.layer.shadowRadius = 4
        self.artworkImageShadowView.layer.shadowOffset = CGSize(width: 1, height: 1)
        self.artworkImageShadowView.layer.shadowOpacity = 0.4
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    func updateView(item: MPMediaItem?) {
        self.artworkImageView.image = item?.artwork?.image(at: MPMediaItem.albamJacketSize) ?? UIImage(named: "app_Icon")
        if item?.albumTitle != "", item?.albumTitle != nil {
            self.titleLabel.text = item?.albumTitle
        } else if item?.title != "", item?.title != nil {
            self.titleLabel.text = item?.title
        } else {
            self.artistLabel.text = "unknown"
        }
        if item?.albumArtist != "", item?.albumArtist != nil {
            self.artistLabel.text = item?.albumArtist
        } else if item?.artist != "", item?.artist != nil {
            self.artistLabel.text = item?.artist
        } else {
            self.artistLabel.text = "unknown"
        }
        self.releaseLabel.text = Calendar.dateConvert(date: item?.releaseDate)
    }
}
