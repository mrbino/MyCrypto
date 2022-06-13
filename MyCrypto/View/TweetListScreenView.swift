//
//  TweetListScreenView.swift
//  MyCrypto
//
//  Created by Albino Alindogan on 2022/06/10.
//

import UIKit


protocol TweetListScreenViewDelegate {
    func onRefreshList()
}

class TweetListScreenView: UIView {

    @IBOutlet var listTweet: UITableView!
    
    var controller: UIViewController?
    var delegate : TweetListScreenViewDelegate?
    private var items: [TweetModel] = []
    private let refreshControl = UIRefreshControl()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setUpView()
    }
    
    private func setUpView() {
        guard let view = loadViewFromNib(nibName: "TweetListScreenView")
        else {
            return
        }
        view.frame = self.bounds
        addSubview(view)
        
        listTweet.delegate = self
        listTweet.dataSource = self
        listTweet.register(UINib(nibName: TweetTableViewCell.nibName, bundle: nil), forCellReuseIdentifier: TweetTableViewCell.nibName)
        
        listTweet.refreshControl = refreshControl
        refreshControl.addTarget(self, action: #selector(refreshRecentTweets), for: .valueChanged)
    }
    
    func reloadListWith(data: [TweetModel]) {
        items = data
        listTweet.reloadData()
    }
    
    @objc private func refreshRecentTweets() {
        if let del = delegate {
            del.onRefreshList()
        }
        refreshControl.endRefreshing()
    }
}

extension TweetListScreenView: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: TweetTableViewCell.nibName, for: indexPath) as? TweetTableViewCell else {
            return UITableViewCell()
        }
        
        cell.setData(items[indexPath.row])
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        if let ctr = controller {
            TweetDetailViewController.open(ctr, items[indexPath.row])
        }
    }
}

