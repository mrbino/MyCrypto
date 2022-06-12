//
//  TweetDetailScreenView.swift
//  MyCrypto
//
//  Created by Albino Alindogan on 2022/06/11.
//

import UIKit

class TweetDetailScreenView: UIView {

    @IBOutlet var imgProfile: UIImageView!
    @IBOutlet var lblName: UILabel!
    @IBOutlet var lblScreenName: UILabel!
    @IBOutlet var lblTweet: UILabel!
    @IBOutlet var lblDate: UILabel!
    
    var tweetInfo : TweetModel? {
        didSet {
            if let info = tweetInfo {
                loadData(info)
            }
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setUpView()
    }
    
    private func setUpView() {
        guard let view = loadViewFromNib(nibName: "TweetDetailScreenView")
        else {
            return
        }
        view.frame = self.bounds
        addSubview(view)
    }
    
    private func loadData(_ info : TweetModel) {
        if let imgUrl = URL(string: info.user.avatar) {
            if let data = try? Data(contentsOf: imgUrl) {
                if let img = UIImage(data: data) {
                    self.imgProfile.image = img
                }
            }
        }
        
        lblName.text = info.user.name
        lblScreenName.text = "@" + info.user.screen_name
        
        lblTweet.text = info.tweet
        
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "en_US_POSIX")
        formatter.dateFormat = "E MMM dd HH:mm:ss Z yyyy"
        if let date = formatter.date(from: info.date) {
            formatter.dateFormat = "h:mm a'・'MM/dd/yy"
            formatter.amSymbol = "AM"
            formatter.pmSymbol = "PM"
            lblDate.text = formatter.string(from: date)
        }
    }
}
