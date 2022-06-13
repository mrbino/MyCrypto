//
//  WelcomeScreen.swift
//  MyCrypto
//
//  Created by Albino Alindogan on 2022/06/07.
//

import UIKit

class WelcomeScreen: UIView {
    @IBOutlet var containerWelcomeText: UIView!
    @IBOutlet var lblWelcomeText: UILabel!
    @IBOutlet var lblMessage: UILabel!
    @IBOutlet var lblRedirectedMessage: UILabel!
    
    var controller: UIViewController?
    var waitSec : Int = 5
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setUpView()
    }
    
    private func setUpView() {
        guard let view = loadViewFromNib(nibName: "WelcomeScreen")
        else {
            return
        }
        view.frame = self.bounds
        addSubview(view)
        
        if UserdefaultsUtils.bool(forKey: .didShowInitialWelcomeScreen) {
            lblWelcomeText.text = "Welcome back, user!"
        } else {
            UserdefaultsUtils.set(true, forKey: .didShowInitialWelcomeScreen)
            lblWelcomeText.text = "Welcome user!"
        }
        
        containerWelcomeText.layer.cornerRadius = 8.0
        
        // redirect timer
        Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { (Timer) in
            if self.waitSec > 0 {
                self.waitSec -= 1
                self.lblRedirectedMessage.text = String(format: "You will be redirected in %d seconds.", self.waitSec)
            } else {
                Timer.invalidate()
                
                self.lblMessage.isHidden = true
                self.lblRedirectedMessage.text = "If you want to be redirected, tap screen."
                
                // add tap gesture once the initial redirect is finished
                let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.onTransitionToCryptoList))
                view.addGestureRecognizer(tap)
                
                // push second controller
                self.onTransitionToCryptoList()
            }
        }
    }
    
    @objc func onTransitionToCryptoList() {
        if let ctr = controller {
            CryptoListViewController.open(ctr)
        }
    }
}
