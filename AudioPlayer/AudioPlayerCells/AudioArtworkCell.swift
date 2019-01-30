//
//  AudioArtworkCollectionViewCell.swift
//  AudioPlayer
//
//  Created by haruta yamada on 2019/01/18.
//  Copyright © 2019 teranyan. All rights reserved.
//

import UIKit

class AudioArtworkCell: UITableViewCell {

    @IBOutlet private weak var artworkShadowView: UIView!
    @IBOutlet private weak var artworkView: UIImageView!
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var artistLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.artworkShadowView.layer.cornerRadius = 10
        self.artworkView.layer.cornerRadius = 10
        
        self.artworkView.layer.masksToBounds = true
        
        self.artworkShadowView.layer.shadowOffset = CGSize(width: 4, height: 4)
        self.artworkShadowView.layer.shadowRadius = 4
        self.artworkShadowView.layer.shadowOpacity = 0.5
        // Initialization code
    }
    
    func setupItem(_ title: String?, _ artist: String?,_ artworkImage: UIImage?) {
        self.titleLabel.text = title
        self.artistLabel.text = artist
        self.artworkView.image = artworkImage
    }
}
