//
//  AudioPlayListNavigationViewController.swift
//  AudioPlayer
//
//  Created by haruta yamada on 2019/02/08.
//  Copyright © 2019 teranyan. All rights reserved.
//

import UIKit

class AudioPlayListNavigationViewController: UINavigationController {

    let miniControllerHeight: CGFloat = 60
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        //self.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        self.navigationBar.shadowImage = UIImage()
        // Do any additional setup after loading the view.
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    @objc func openPlayer() {
        let viewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "Player")
        self.present(viewController, animated: true, completion: nil)
    }

}
