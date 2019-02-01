//
//  AudioQueueCell.swift
//  AudioPlayer
//
//  Created by haruta yamada on 2019/01/28.
//  Copyright © 2019 teranyan. All rights reserved.
//

import UIKit

class AudioQueueCell: UITableViewCell {

    @IBOutlet private weak var artworkView: UIImageView!
    @IBOutlet private weak var titleView: UILabel!
    @IBOutlet private weak var artistView: UILabel!
    var title: String? {
        get {
            return self.titleView.text
        }
        set(value) {
            self.titleView.text = value
        }
    }
    var artist: String? {
        get {
            return self.artistView.text
        }
        set(value) {
            self.artistView.text = value
        }
    }
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
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
}
