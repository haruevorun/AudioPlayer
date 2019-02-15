//
//  GenreDetailListTableViewCell.swift
//  AudioPlayer
//
//  Created by haruta yamada on 2019/02/10.
//  Copyright © 2019 teranyan. All rights reserved.
//

import UIKit
import MediaPlayer

class GenreDetailListTableViewCell: UITableViewCell {

    @IBOutlet private weak var indexLabel: UILabel!
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var durationLabel: UILabel!
    
    func updateView(item: MPMediaItem?, index: Int) {
        self.indexLabel.text = nil
        self.titleLabel.text = item?.title
        self.durationLabel.text = Calendar.timeToString(time: Float(item?.playbackDuration ?? 0))
    }
    
}
