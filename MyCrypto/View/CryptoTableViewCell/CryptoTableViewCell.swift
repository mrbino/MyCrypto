//
//  CryptoTableViewCell.swift
//  MyCrypto
//
//  Created by Albino Alindogan on 2022/06/07.
//

import UIKit

class CryptoTableViewCell: UITableViewCell {

    static let nibName = "CryptoTableViewCell"
    
    @IBOutlet var lblCrypto: UILabel!
    @IBOutlet var lblCoinName: UILabel!
    @IBOutlet var lblPrice: UILabel!
    
    var refreshTimer : Timer?
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func setData(_ crypto : CryptoModel) {
        lblCrypto.text = crypto.name
        lblCoinName.text = String(format: "(%@)", crypto.coinName)
    }
    
    func updateCryptoPrice(_ price : Double) {
        self.lblPrice.text = String(format: "%f USD", price)
        self.lblPrice.textColor = .tintColor
    }
    
    func priceNotTracked() {
        self.lblPrice.text = "Market data is untracked"
        self.lblPrice.textColor = .red
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
