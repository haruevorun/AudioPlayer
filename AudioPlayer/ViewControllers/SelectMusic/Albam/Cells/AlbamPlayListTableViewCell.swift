//
//  AlbamPlayListTableViewCell.swift
//  AudioPlayer
//
//  Created by haruta yamada on 2019/02/07.
//  Copyright © 2019 teranyan. All rights reserved.
//

import UIKit

class AlbamPlayListTableViewCell: UITableViewCell {

    @IBOutlet private weak var numberLabel: UILabel!
    @IBOutlet private weak var titleLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    func updateCell(index: Int, title: String) {
        self.numberLabel.text = String(index)
        self.titleLabel.text = title
    }
}
