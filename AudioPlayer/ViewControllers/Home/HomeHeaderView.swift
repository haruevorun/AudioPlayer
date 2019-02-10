//
//  HomeViewHeaderView.swift
//  AudioPlayer
//
//  Created by haruta yamada on 2019/02/09.
//  Copyright © 2019 teranyan. All rights reserved.
//

import Foundation
import UIKit

class HomeHeaderView: UITableViewHeaderFooterView {
    @IBOutlet weak var label: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    func updateView(text: String) {
        self.label.text = text
    }
}
