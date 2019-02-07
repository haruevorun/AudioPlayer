//
//  DebugPrint.swift
//  AudioPlayer
//
//  Created by haruta yamada on 2019/02/01.
//  Copyright © 2019 teranyan. All rights reserved.
//

import Foundation

class DebugUtil {
    static func log( _ log: Any?) {
        #if DEBUG
        print(log as Any)
        #endif
    }
    static func debuglog( _ log: Any?) {
        #if DEBUG
        debugPrint(log as Any)
        #endif
    }
    static func debugdump( _ log: Any?) {
        #if DEBUG
        dump(log)
        #endif
    }
}
