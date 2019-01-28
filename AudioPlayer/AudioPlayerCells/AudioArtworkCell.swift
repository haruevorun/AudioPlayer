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
    var artworkImage: UIImage? {
        get {
            return artworkView.image
        }
        set(value) {
            self.artworkView.image = value
        }
    }
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
}
