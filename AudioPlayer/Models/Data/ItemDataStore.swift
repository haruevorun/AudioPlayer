//
//  ItemDataStore.swift
//  AudioPlayer
//
//  Created by haruta yamada on 2019/02/03.
//  Copyright © 2019 teranyan. All rights reserved.
//

import Foundation
import MediaPlayer
protocol ItemDataStore: class {
    func fetchAllItem() -> MPMediaQuery
    func searchItem(keyword: String) -> MPMediaQuery
}
