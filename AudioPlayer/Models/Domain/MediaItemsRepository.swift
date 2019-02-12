//
//  ItemRepository.swift
//  AudioPlayer
//
//  Created by haruta yamada on 2019/02/03.
//  Copyright © 2019 teranyan. All rights reserved.
//

import Foundation
import MediaPlayer
protocol MediaItemsRepository: class {
    func fetch(queryCase: MediaItemsUseCase.QueryCase,filter: Set<MPMediaPropertyPredicate>,completion: @escaping (_ query: MPMediaQuery?)-> Void)
}
