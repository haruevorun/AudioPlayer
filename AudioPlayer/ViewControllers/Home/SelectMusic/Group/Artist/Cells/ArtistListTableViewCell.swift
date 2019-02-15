//
//  ArtistListTableViewCell.swift
//  AudioPlayer
//
//  Created by haruta yamada on 2019/02/09.
//  Copyright © 2019 teranyan. All rights reserved.
//

import UIKit

class ArtistListTableViewCell: UITableViewCell {

    @IBOutlet private weak var artistLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    func updateView(artist: String?) {
        artistLabel.text = artist
    }
}
