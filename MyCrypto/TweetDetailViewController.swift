//
//  TweetDetailViewController.swift
//  MyCrypto
//
//  Created by Albino Alindogan on 2022/06/11.
//

import UIKit

class TweetDetailViewController: UIViewController {

    static func open(_ controller: UIViewController, _ tweetInfo : TweetModel) {
        DispatchQueue.main.async {
            guard let vc = UIStoryboard.main.instantiateViewController(withIdentifier: "TweetDetailViewController") as? TweetDetailViewController else {
                return
            }
            
            vc.tweetInfo = tweetInfo
            
            controller.present(vc, animated: true, completion: nil)
        }
    }
    
    @IBOutlet var tweetDetailView: TweetDetailScreenView!
    
    var tweetInfo : TweetModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        loadUI()
    }
    
    func loadUI() {
        tweetDetailView.tweetInfo = tweetInfo
    }
}
