//
//  LoginViewController.swift
//  BikeTrack
//
//  Created by Gil Felot on 14/05/16.
//  Copyright © 2016 Gil Felot. All rights reserved.
//

import UIKit
import Moya
import Moya_ModelMapper
import RxCocoa
import RxSwift

class LoginViewController: UIViewController {

    @IBOutlet weak var loginTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBOutlet weak var loginLabel: UILabel!
    @IBOutlet weak var passwordLabel: UILabel!
    
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var signupButton: UIButton!
    
    let minimalCharCount = 5
    
    var provider: RxMoyaProvider<BikeTrack>!
    let disposeBag = DisposeBag() // Bag of disposables to release them when view is being deallocated (protect against retain cycle)

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupVerification()
        setupConnexion()
        
        
    }
    
    func setupConnexion() {
        provider = RxMoyaProvider<BikeTrack>()
        
        loginButton.rx_tap
            .subscribeNext{[weak self] in self?.showToken(_)}
            .addDisposableTo(disposeBag)
    }

    func showToken(token: String) {
        print("token = \(token)")
    }
    
    func setupVerification() {
        loginLabel.text = "Login must be at leat \(minimalCharCount) characters"
        passwordLabel.text = "Password must be at leat \(minimalCharCount) characters"
        
        let loginVerification = loginTextField.rx_text
            .map{$0.characters.count >= self.minimalCharCount}
            .shareReplay(1)
        
        let passwordVerification = passwordTextField.rx_text
            .map{$0.characters.count >= self.minimalCharCount}
            .shareReplay(1)
        
        //        let everythingValid = Observable.combineLatest(loginVerification, passwordVerification) { $0 && $1 }
        //            .shareReplay(1)
        
        loginVerification
            .bindTo(passwordTextField.rx_enabled)
            .addDisposableTo(disposeBag)
        
        loginVerification
            .bindTo(loginLabel.rx_hidden)
            .addDisposableTo(disposeBag)
        
        passwordVerification
            .bindTo(passwordLabel.rx_hidden)
            .addDisposableTo(disposeBag)
    }
    
}

