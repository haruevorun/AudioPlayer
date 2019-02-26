//
//  TestQueueViewController.swift
//  AudioPlayer
//
//  Created by haruta yamada on 2019/02/18.
//  Copyright © 2019 teranyan. All rights reserved.
//

import UIKit
import MediaPlayer

class TestQueueViewController: UIViewController {

    @IBOutlet weak var previousButton: UIButton!
    @IBOutlet weak var playBackButton: UIButton!
    @IBOutlet weak var skipButton: UIButton!
    
    let player: MediaPlayerControlProtocol = AudioPlayerController.sharedPlayerController
    let input: ProvisionalInputProtocol = AudioPlayerController.sharedPlayerController
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.input.inputQueue(query: MPMediaQuery.albums())
        
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.player.play()
    }
    
    @IBAction func previous(_ sender: Any) {
        self.player.skipToPrevious()
    }
    
    @IBAction func playback(_ sender: Any) {
    }
    
    @IBAction func skip(_ sender: Any) {
        self.player.skipToNext()
    }
}
