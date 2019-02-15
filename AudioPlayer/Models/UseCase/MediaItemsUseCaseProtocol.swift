//
//  ArtistGatewayProtocol.swift
//  AudioPlayer
//
//  Created by haruta yamada on 2019/02/02.
//  Copyright © 2019 teranyan. All rights reserved.
//

import Foundation
import MediaPlayer
protocol MediaItemsUseCaseProtocol {
    func fetch(filter: Set<MPMediaPropertyPredicate>,completion: @escaping (( _ query: MPMediaQuery?)->Void))
}
