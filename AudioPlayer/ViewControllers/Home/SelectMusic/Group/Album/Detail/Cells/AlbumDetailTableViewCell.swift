//
//  AlbamDetailTableViewCell.swift
//  AudioPlayer
//
//  Created by haruta yamada on 2019/02/07.
//  Copyright © 2019 teranyan. All rights reserved.
//

import UIKit
import MediaPlayer

class AlbumDetailTableViewCell: UITableViewCell {
    @IBOutlet private weak var shadowView: UIView!
    @IBOutlet private weak var artworkImageView: UIImageView!
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var artistLabel: UIButton!
    @IBOutlet private weak var descriptionLabel: UILabel!
    @IBOutlet private weak var offlineCheckLabel: UILabel!
    @IBOutlet private weak var settingButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.shadowView.layer.cornerRadius = 10
        self.shadowView.layer.shadowOffset = CGSize(width: 1, height: 1)
        self.shadowView.layer.shadowRadius = 10
        self.shadowView.layer.shadowOpacity = 0.3
        self.artworkImageView.layer.cornerRadius = 5
        self.artworkImageView.layer.masksToBounds = true
        // Initialization code
    }
    func updateView(item: MPMediaItem?) {
        self.titleLabel.text = item?.albumTitle
        self.artistLabel.setTitle(item?.albumArtist, for: .normal)
        self.descriptionLabel.text = item?.genre
        self.artworkImageView.image = item?.artwork?.image(at: MPMediaItem.albumJacketThumbnailSize) ?? UIImage(named: "app_Icon")
    }
    @IBAction func artist(_ sender: Any) {
        
    }
}
