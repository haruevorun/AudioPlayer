//
//  AlbamListCell.swift
//  AudioPlayer
//
//  Created by haruta yamada on 2019/01/29.
//  Copyright © 2019 teranyan. All rights reserved.
//

import UIKit
import MediaPlayer

class AlbamListCell: UITableViewCell {

    @IBOutlet private weak var artworkImageView: UIImageView!
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var artistLabel: UILabel!
    @IBOutlet private weak var genreLabel: UILabel!
    @IBOutlet weak var playCountLabel: UILabel!
    
    var collection: MPMediaItemCollection? {
        didSet {
            guard let representativeItem = collection?.representativeItem else {
                return
            }
            self.setupView(representativeItem: representativeItem)
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    private func setupView(representativeItem: MPMediaItem) {
        self.artworkImageView.image = representativeItem.artwork?.image(at: MPMediaItem.albamJacketThumbnailSize)
        self.titleLabel.text = representativeItem.albumTitle
        self.artistLabel.text = representativeItem.artist
        self.genreLabel.text = representativeItem.genre
        self.playCountLabel.text = "再生数:\(representativeItem.playCount)"
    }
}
