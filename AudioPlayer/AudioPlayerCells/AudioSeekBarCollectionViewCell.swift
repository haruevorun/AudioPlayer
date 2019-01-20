//
//  AudioSeekBarCollectionViewCell.swift
//  AudioPlayer
//
//  Created by haruta yamada on 2019/01/18.
//  Copyright © 2019 teranyan. All rights reserved.
//

import UIKit

class AudioSeekBarCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var seekBar: UISlider!
    @IBOutlet weak var remainingTimeLabel: UILabel!
    @IBOutlet weak var playTimeLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        seekBar.setValue(0, animated: true)
        remainingTimeLabel.text = "- 3:00"
        playTimeLabel.text = "0:00"
    }
}
