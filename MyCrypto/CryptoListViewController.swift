//
//  CryptoListViewController.swift
//  MyCrypto
//
//  Created by Albino Alindogan on 2022/06/07.
//

import UIKit

class CryptoListViewController: UIViewController, CryptoListScreenViewDelegate {

    var listView : CryptoListScreenView?
    var refreshTimer : Timer?
    var throttle : Int = 120
    
    static func open(_ controller: UIViewController) {
        DispatchQueue.main.async {
            guard let vc = UIStoryboard.main.instantiateViewController(withIdentifier: "CryptoListViewController") as? CryptoListViewController else {
                return
            }
            
            if let navigation = controller.navigationController {
                navigation.pushViewController(vc, animated: true)
            } else {
                controller.present(vc, animated: true, completion: nil)
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        loadUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        loadData()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        if let timer = self.refreshTimer {
            timer.invalidate()
            self.refreshTimer = nil
        }
    }
    
    func onRefreshList() {
        loadData()
    }
    
    func loadUI() {
        let list = CryptoListScreenView(frame: self.view.frame)
        list.delegate = self
        listView = list
        self.view.addSubview(list)
    }
    
    func loadData() {
        getCoinList()
    }
    
    func getCoinList() {
        // use basic URL session request to access API and, then parse JSON data
        // TODO: improve API Client (parameters, request, parsing) by creating model for each
        APIClient.getCoinList(completion: { (ret) in
            DispatchQueue.main.async {
                if let result = ret {
                    if let data = result.tryGetJson(key: "Data") {
                        
                        var arrList: [CryptoModel] = []
                        for item in data {
                            if let info = item.value as? [String:Any] {
                                let crypto = CryptoModel(json: info)
                                arrList.append(crypto)
                            }
                        }
                        
                        if let list = self.listView {
                            // shuffle the list, for the purpose of getting random 5 items
                            list.reloadListWith(data: arrList.shuffled())
                            
                            self.fetchCryptoPrices()
                        }
                    }
                }
            }
        })
    }
    
    func fetchCryptoPrices() {
        if let timer = self.refreshTimer {
            timer.invalidate()
            self.refreshTimer = nil
        }
        // refresh every 120 seconds, as the API uses cached data for as long as 120 seconds
        self.refreshTimer = Timer.scheduledTimer(withTimeInterval: TimeInterval(throttle), repeats: false) { _ in
            self.fetchCryptoPrices()
        }
        
        if let list = self.listView {
            let arrList = list.getCryptoListData()
            for index in 0..<arrList.count {
                fetch(atIndex: index, crypto: arrList[index].name)
            }
        }
    }
    
    func fetch(atIndex : Int, crypto : String) {
        // use basic URL session request to access API and, then parse JSON data
        // TODO: improve API Client (parameters, request, parsing) by creating model for each
        // TODO: currency "USD" is hardcoded, but can be dynamic in the future implementation
        APIClient.getCoinPrice(name: crypto, currencies: ["USD"], completion: { (ret) in
            DispatchQueue.main.async {
                if let result = ret {
                    if let list = self.listView {
                        var currentPrice : Double = -1
                        if let price = result.tryGetDouble(key: "USD") {
                            currentPrice = price
                        }
                        list.updateCryptoPrice(atIndex, price: currentPrice)
                    }
                }
            }
        })
    }
}
