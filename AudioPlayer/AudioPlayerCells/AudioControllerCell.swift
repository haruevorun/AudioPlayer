//
//  AudioControllerCollectionViewCell.swift
//  AudioPlayer
//
//  Created by haruta yamada on 2019/01/18.
//  Copyright © 2019 teranyan. All rights reserved.
//

import UIKit
import MediaPlayer

protocol AudioControlProtocol: class {
    func playback(isPlay: Bool)
    func skip()
    func backToBeginning()
    func seek(value: Float)
}

class AudioControllerCell: UITableViewCell {

    @IBOutlet private weak var seekbar: UISlider!
    @IBOutlet private weak var playbackButton: UIButton!
    @IBOutlet private weak var skipNextButton: UIButton!
    @IBOutlet private weak var skipPreviousButton: UIButton!
    var maximumValue: Float = 0 {
        didSet {
            self.seekbar.maximumValue = maximumValue
        }
    }
    var currentPlayBackValue: Float {
        get {
            return seekbar.value
        }
        set(value) {
            self.seekbar.setValue(value, animated: true)
        }
    }
    var isPlay: Bool = false {
        didSet {
            if isPlay {
                self.playbackButton.setImage(UIImage(named: "pause_icon"), for: .normal)
            } else {
                self.playbackButton.setImage(UIImage(named: "play_icon"), for: .normal)
            }
        }
    }
    var delegate: AudioControlProtocol?
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    @IBAction func playback(_ sender: Any) {
        delegate?.playback(isPlay: self.isPlay)
    }
    @IBAction func skip(_ sender: Any) {
        delegate?.skip()
    }
    @IBAction func backToBeginning(_ sender: Any) {
        delegate?.backToBeginning()
    }
    @IBAction func seek(_ sender: UISlider) {
        delegate?.seek(value: sender.value)
    }
}
