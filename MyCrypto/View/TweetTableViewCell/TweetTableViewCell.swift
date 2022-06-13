//
//  TweetTableViewCell.swift
//  MyCrypto
//
//  Created by Albino Alindogan on 2022/06/10.
//

import UIKit

class TweetTableViewCell: UITableViewCell {

    static let nibName = "TweetTableViewCell"
    
    @IBOutlet var lblUsername: UILabel!
    @IBOutlet var lblDate: UILabel!
    @IBOutlet var lblTweet: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func setData(_ tweet : TweetModel) {
        lblUsername.text = "@" + tweet.user.screen_name
        
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "en_US_POSIX")
        formatter.dateFormat = "E MMM dd HH:mm:ss Z yyyy"
        if let date = formatter.date(from: tweet.date) {
            let rformatter = RelativeDateTimeFormatter()
            rformatter.unitsStyle = .full
            lblDate.text = rformatter.localizedString(for: date, relativeTo: Date())
        }
        
        lblTweet.text = tweet.tweet
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
}
