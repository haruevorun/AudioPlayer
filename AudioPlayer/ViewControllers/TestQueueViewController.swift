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

    let output: MediaPlayerQueueControllerOutputProtocol = AudioQueueController.shared
    var input: MediaPlayerQueueControllerInputProtocol = AudioQueueController.shared
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.input.setQueue(query: MPMediaQuery.albums())
        self.input.isShuffled = true
        // Do any additional setup after loading the view.
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        DebugUtil.log(self.output.setPlayItem()?.title)
        DebugUtil.log(self.output.setNextItem()?.title)
        DebugUtil.log(self.output.setNextItem()?.title)
        DebugUtil.log(self.output.setNextItem()?.title)
        DebugUtil.log(self.output.setPreviousItem()?.title)
        DebugUtil.log(self.output.setPreviousItem()?.title)
        DebugUtil.log(self.output.setPreviousItem()?.title)
        DebugUtil.log(self.output.setPreviousItem()?.title)
        DebugUtil.log(self.output.setSelectItem(index: 2)?.title)
        DebugUtil.log(self.output.setNextItem()?.title)
        DebugUtil.log(self.output.setPreviousItem()?.title)
        DebugUtil.log(self.output.setPlayItem()?.title)
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
