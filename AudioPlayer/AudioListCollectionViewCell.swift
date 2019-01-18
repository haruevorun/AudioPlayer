//
//  AudioListCollectionViewCell.swift
//  AudioPlayer
//
//  Created by haruta yamada on 2019/01/18.
//  Copyright © 2019 teranyan. All rights reserved.
//

import UIKit
import MediaPlayer

class AudioListCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var albamLabel: UILabel!
    @IBOutlet weak var artistLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var backGroundView: UIView!
    @IBOutlet weak var artworkView: UIImageView!
    var item: MPMediaItem? {
        didSet {
            self.titleLabel.text = item?.title ?? "Unknown"
            self.albamLabel.text = item?.albumTitle ?? "Unknown"
            self.artistLabel.text = item?.artist ?? "Unknown"
            self.artworkView.image = item?.artwork?.image(at: CGSize(width: 100, height: 100))
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.backGroundView.layer.cornerRadius = 10
        self.backGroundView.layer.shadowOffset = CGSize(width: 1, height: 1)
        self.backGroundView.layer.shadowRadius = 2
        self.backGroundView.layer.shadowOpacity = 1
        
        self.artworkView.layer.cornerRadius = 5
        self.artworkView.layer.masksToBounds = true
        
    }
    private func animation(textView: UITextView) {
        if textView.frame.width > textView.contentSize.width {
            UIView.animate(withDuration: 3, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .repeat, animations: {
                textView.contentOffset = CGPoint(x: textView.contentSize.width - textView.frame.width, y: 0)
            }, completion: nil)
        }
    }
}
