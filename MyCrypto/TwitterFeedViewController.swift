//
//  TwitterFeedViewController.swift
//  MyCrypto
//
//  Created by Albino Alindogan on 2022/06/07.
//

import UIKit


class TwitterFeedViewController: UIViewController, TweetListScreenViewDelegate {
    
    var listView : TweetListScreenView?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        loadUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        loadData()
    }
    
    func loadUI() {
        let list = TweetListScreenView(frame: self.view.frame)
        list.controller = self
        list.delegate = self
        listView = list
        self.view.addSubview(list)
    }
    
    func loadData() {
        getRecentTweets(withHashtag: "btc")
    }
    
    func getRecentTweets(withHashtag : String) {
        APIClient.searchTweet(hashtag: withHashtag, completion: { (ret) in
            DispatchQueue.main.async {
                if let result = ret {
                    if let data = result.tryGetJsonArray(key: "statuses") {
                        
                        var arrList: [TweetModel] = []
                        for item in data {
                            let tweet = TweetModel(json: item)
                            arrList.append(tweet)
                        }
                    
                        if let list = self.listView {
                            list.reloadListWith(data: arrList)
                        }
                    }
                }
            }
        })
    }
    
    func onRefreshList() {
        loadData()
    }
}
