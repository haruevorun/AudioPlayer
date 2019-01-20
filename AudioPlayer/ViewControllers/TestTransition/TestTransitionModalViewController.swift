//
//  TestTransitionModalViewController.swift
//  AudioPlayer
//
//  Created by haruta yamada on 2019/01/19.
//  Copyright © 2019 teranyan. All rights reserved.
//

import UIKit
import IGListKit
import MediaPlayer

class TestTransitionModalViewController: UIViewController {

    @IBOutlet weak var contentViewOriginConstraint: NSLayoutConstraint!
    @IBOutlet weak var backview: UIView!
    @IBOutlet weak var collectionView: UICollectionView!
    var collection: MPMediaItemCollection?
    lazy var adapter: ListAdapter = ListAdapter(updater: ListAdapterUpdater(), viewController: self)
    override func viewDidLoad() {
        super.viewDidLoad()
        self.adapter.collectionView = self.collectionView
        self.adapter.dataSource = self
        self.adapter.scrollViewDelegate = self
        // Do any additional setup after loading the view.
    }
    var initializeOrigin: CGPoint = CGPoint.zero
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
    }
    private func transitionContentOffsetY(_ offsetY: CGFloat) {
        let move = min(offsetY, 0)
        print(move)
        self.backview.frame.origin = CGPoint(x: 0, y: 60 - move)
        
    }
    private func checkDismissViewController(offsetY: CGFloat) {
        if offsetY > self.view.frame.height / 6 {
            self.collectionView.isScrollEnabled = false
            self.collectionView.setContentOffset(self.collectionView.contentOffset, animated: false) // 慣性スクロールを強制停止
            self.collectionView.contentOffset = CGPoint(x: 0, y: offsetY)
            self.dismiss(animated: true, completion: nil)
        } else {
            UIView.animate(withDuration: 0.3) {
                self.backview.frame.origin = self.initializeOrigin
            }
        }
    }

}
extension TestTransitionModalViewController: UIScrollViewDelegate {
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        self.initializeOrigin = self.backview.frame.origin
        return
    }
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        self.transitionContentOffsetY(scrollView.contentOffset.y)
    }
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        checkDismissViewController(offsetY: scrollView.contentOffset.y)
    }
}
extension TestTransitionModalViewController: ListAdapterDataSource {
    func objects(for listAdapter: ListAdapter) -> [ListDiffable] {
        return [collection!]
    }
    
    func listAdapter(_ listAdapter: ListAdapter, sectionControllerFor object: Any) -> ListSectionController {
        return AudioPlayerSectionController()
    }
    
    func emptyView(for listAdapter: ListAdapter) -> UIView? {
        return nil
    }
}
