//
//  ArtistDetailTableViewCell.swift
//  AudioPlayer
//
//  Created by haruta yamada on 2019/02/09.
//  Copyright © 2019 teranyan. All rights reserved.
//

import UIKit

class ArtistDetailTableViewCell: UITableViewCell {

    @IBOutlet private weak var artistLabel: UILabel!
    func updateView(artist: String?) {
        self.artistLabel.text = artist
    }
    
}
