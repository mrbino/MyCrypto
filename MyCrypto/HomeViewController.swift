//
//  ViewController.swift
//  MyCrypto
//
//  Created by Albino Alindogan on 2022/06/07.
//

import UIKit

class HomeViewController: UIViewController {

    @IBOutlet var welcomeScreenView: WelcomeScreen!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadUI()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        loadData()
    }
    
    func loadUI() {
        welcomeScreenView.controller = self
    }
    
    func loadData() {
        
    }
}

