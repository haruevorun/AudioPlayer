//
//  AudioArtworkCollectionViewCell.swift
//  AudioPlayer
//
//  Created by haruta yamada on 2019/01/18.
//  Copyright © 2019 teranyan. All rights reserved.
//

import UIKit
import MediaPlayer

class AudioArtworkCell: UITableViewCell {

    @IBOutlet private weak var artworkShadowView: UIView!
    @IBOutlet private weak var artworkView: UIImageView!
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var artistLabel: UILabel!
    
    private var artwork: MediaPlayerArtworkProtocol = AudioPlayer.shared
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.artworkShadowView.layer.cornerRadius = 10
        self.artworkView.layer.cornerRadius = 10
        
        self.artworkView.layer.masksToBounds = true
        
        self.artworkShadowView.layer.shadowOffset = CGSize(width: 4, height: 4)
        self.artworkShadowView.layer.shadowRadius = 4
        self.artworkShadowView.layer.shadowOpacity = 0.5
        self.updateArtwork()
        NotificationCenter.default.addObserver(self, selector: #selector(updateArtwork), name: UIApplication.willEnterForegroundNotification, object: nil)
        MPMusicPlayerApplicationController.applicationQueuePlayer.beginGeneratingPlaybackNotifications()
        NotificationCenter.default.addObserver(self, selector: #selector(updateArtwork), name: NSNotification.Name.MPMusicPlayerControllerNowPlayingItemDidChange, object: nil)
        MPMusicPlayerApplicationController.applicationQueuePlayer.endGeneratingPlaybackNotifications()
        // Initialization code
    }
    @objc private func updateArtwork() {
        self.artworkView.image = artwork.image ?? UIImage(named: "app_Icon")
        self.titleLabel.text = artwork.title
        self.artistLabel.text = artwork.artist
    }
}
