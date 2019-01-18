//
//  AudioArtworkCollectionViewCell.swift
//  AudioPlayer
//
//  Created by haruta yamada on 2019/01/18.
//  Copyright © 2019 teranyan. All rights reserved.
//

import UIKit
import MediaPlayer

class AudioArtworkCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var artworkShadowView: UIView!
    @IBOutlet weak var artworkView: UIImageView!
    
    var image: UIImage? {
        didSet {
            self.setArtworkView(image: self.image)
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.artworkView.layer.cornerRadius = 10
        self.artworkShadowView.layer.cornerRadius = 10
        
        self.artworkView.layer.masksToBounds = true
        
        self.artworkShadowView.layer.shadowOffset = CGSize(width: 1, height: 1)
        self.artworkShadowView.layer.shadowRadius = 10
        self.artworkShadowView.layer.shadowOpacity = 0.6
    }
    private func setArtworkView(image: UIImage?) {
        self.artworkView.image = image
    }
}
