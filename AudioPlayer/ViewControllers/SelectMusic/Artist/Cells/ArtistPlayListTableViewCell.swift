//
//  ArtistPlayListTableViewCell.swift
//  AudioPlayer
//
//  Created by haruta yamada on 2019/02/09.
//  Copyright © 2019 teranyan. All rights reserved.
//

import UIKit
import MediaPlayer

class ArtistPlayListTableViewCell: UITableViewCell {

    @IBOutlet private weak var artworkImageShadowView: UIView!
    @IBOutlet private weak var artworkImageView: UIImageView!
    @IBOutlet private weak var albamTitleLabel: UILabel!
    @IBOutlet private weak var composerLabel: UILabel!
    @IBOutlet private weak var dateLabel: UILabel!
    @IBOutlet private weak var rateLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.artworkImageView.layer.cornerRadius = 10
        self.artworkImageShadowView.layer.cornerRadius = 10
        self.artworkImageView.layer.masksToBounds = true
        self.artworkImageShadowView.layer.shadowOffset = CGSize(width: 1, height: 1)
        self.artworkImageShadowView.layer.shadowRadius = 5
        self.artworkImageShadowView.layer.shadowOpacity = 0.4
    }
    
    func updateView(collection: MPMediaItemCollection?) {
        self.artworkImageView.image = collection?.representativeItem?.artwork?.image(at: MPMediaItem.albamJacketThumbnailSize) ?? UIImage(named: "app_Icon")
        self.albamTitleLabel.text = collection?.representativeItem?.albumTitle
        self.composerLabel.text = collection?.representativeItem?.artist
        self.dateLabel.text = dateConvert(date: collection?.representativeItem?.releaseDate)
        self.rateLabel.text = rate(count: collection?.representativeItem?.rating ?? 0)
    }
    private func rate(count: Int) -> String {
        switch count {
        case 1:
            return "Rate: ★ ☆ ☆ ☆ ☆"
        case 2:
            return "Rate: ★ ★ ☆ ☆ ☆"
        case 3:
            return "Rate: ★ ★ ★ ☆ ☆"
        case 4:
            return "Rate: ★ ★ ★ ★ ☆"
        case 5:
            return "Rate: ★ ★ ★ ★ ★"
        default:
            return "Rate: ☆ ☆ ☆ ☆ ☆"
        }
    }
    private func dateConvert(date: Date?) -> String? {
        guard let date = date else {
            return nil
        }
        let formatter = DateFormatter()
        formatter.dateFormat = DateFormatter.dateFormat(fromTemplate: "yyyy", options: 0, locale: Locale.current)
        return formatter.string(from: date)
    }
    
}
