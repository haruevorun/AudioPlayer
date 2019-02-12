//
//  ItemSectionHeader.swift
//  AudioPlayer
//
//  Created by haruta yamada on 2019/02/12.
//  Copyright © 2019 teranyan. All rights reserved.
//

import UIKit

class ItemSectionHeader: UITableViewHeaderFooterView {

    @IBOutlet weak var backGroundView: UIImageView!
    @IBOutlet weak var EffectView: UIView!
    @IBOutlet private weak var sectionTitleText: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func updateTitle(text: String?) {
        self.sectionTitleText.text = text
    }

}
