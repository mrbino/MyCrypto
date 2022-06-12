//
//  CryptoListScreenView.swift
//  MyCrypto
//
//  Created by Albino Alindogan on 2022/06/07.
//

import UIKit

protocol CryptoListScreenViewDelegate {
    func onRefreshList()
}

class CryptoListScreenView: UIView {

    @IBOutlet var listCrypto: UITableView!
    
    var delegate : CryptoListScreenViewDelegate?
    private var items: [CryptoModel] = []
    private let refreshControl = UIRefreshControl()
    private let maxItem : Int = 5
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setUpView()
    }
    
    private func setUpView() {
        guard let view = loadViewFromNib(nibName: "CryptoListScreenView")
        else {
            return
        }
        view.frame = self.bounds
        addSubview(view)
        
        listCrypto.delegate = self
        listCrypto.dataSource = self
        listCrypto.register(UINib(nibName: CryptoTableViewCell.nibName, bundle: nil), forCellReuseIdentifier: CryptoTableViewCell.nibName)
        
        listCrypto.refreshControl = refreshControl
        refreshControl.addTarget(self, action: #selector(refreshCryptoList), for: .valueChanged)
    }
    
    func reloadListWith(data: [CryptoModel]) {
        items = data
        listCrypto.reloadData()
    }
    
    func getCryptoListData() -> [CryptoModel] {
        if items.count < maxItem {
            return items
        }
        
        return Array(items.prefix(maxItem))
    }
    
    func updateCryptoPrice(_ atIndex: Int, price : Double) {
        let indexPath = IndexPath(item: atIndex, section: 0)
        if let cell = listCrypto.cellForRow(at: indexPath) as? CryptoTableViewCell {
            if price >= 0 {
                cell.updateCryptoPrice(price)
            } else {
                cell.priceNotTracked()
            }
        }
    }
    
    @objc private func refreshCryptoList() {
        if let del = delegate {
            del.onRefreshList()
        }
        refreshControl.endRefreshing()
    }
}

extension CryptoListScreenView: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // display only 5 cryptos, make sure the app doesn't crash (index of bounds) when list is less than 5
        if items.count < maxItem {
            return items.count
        }
        
        return maxItem
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CryptoTableViewCell.nibName, for: indexPath) as? CryptoTableViewCell else {
            return UITableViewCell()
        }
        let index = indexPath.row
        
        cell.setData(items[index])
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
}
