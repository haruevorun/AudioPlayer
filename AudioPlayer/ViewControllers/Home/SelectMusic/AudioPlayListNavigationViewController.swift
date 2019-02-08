//
//  AudioPlayListNavigationViewController.swift
//  AudioPlayer
//
//  Created by haruta yamada on 2019/02/08.
//  Copyright © 2019 teranyan. All rights reserved.
//

import UIKit

class AudioPlayListNavigationViewController: UINavigationController {

    lazy var miniController: MiniAudioController = {
        let view = MiniAudioController(frame: CGRect(x: 0, y: self.view.frame.origin.y + self.view.frame.height - miniControllerHeight - self.view.safeAreaInsets.bottom, width: self.view.frame.width, height: miniControllerHeight))
        return view
    }()
    let miniControllerHeight: CGFloat = 60
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        //self.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        self.navigationBar.shadowImage = UIImage()
        // Do any additional setup after loading the view.
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        /*
        for subview in self.view.subviews {
            if subview.isKind(of: NSClassFromString("UINavigationTransitionView")!) {
                subview.frame.size.height = UIScreen.main.bounds.height - miniControllerHeight - self.view.safeAreaInsets.bottom
            }
        }*/
        self.view.addSubview(miniController)
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
