//
//  ArtistListViewController.swift
//  AudioPlayer
//
//  Created by haruta yamada on 2019/02/03.
//  Copyright © 2019 teranyan. All rights reserved.
//

import UIKit
import MediaPlayer

class ArtistListViewController: UIViewController, PresenterOutput {
    func finishedFetchQuery(query: MPMediaQuery?) {
        guard let collections: [MPMediaItemCollection] = query?.collections else {
            return
        }
        DebugUtil.log(collections.map {$0.representativeItem?.artist})
        DebugUtil.log(collections.map {$0.representativeItem?.albumTitle})
    }
    
    
    let fetcher = MediaQueryFetcher()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.fetcher.output = self
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.fetcher.output = self
        self.fetcher.fetch(with: "Tu", fetchGroup: .album, isAppleMusic: false)
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

