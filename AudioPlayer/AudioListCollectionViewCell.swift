//
//  AudioListCollectionViewCell.swift
//  AudioPlayer
//
//  Created by haruta yamada on 2019/01/18.
//  Copyright © 2019 teranyan. All rights reserved.
//

import UIKit

class AudioListCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var titleLabe: UILabel!
    var item: AudioItem? {
        didSet {
            self.titleLabe.text = item?.title
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
