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
    
    private let viewModel = LoginViewModel()
    private let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loginLabel.text = "Login must be at leat \(viewModel.minCharacterCount) characters"
        passwordLabel.text = "Password must be at leat \(viewModel.minCharacterCount) characters"
        
        loginButton.rx_tap
            .bindTo(viewModel.loginTaps)
            .addDisposableTo(disposeBag)
        
        signupButton.rx_tap
            .bindTo(viewModel.signupTaps)
            .addDisposableTo(disposeBag)
        
        loginTextField.rx_text
            .bindTo(viewModel.loginText)
            .addDisposableTo(disposeBag)
        
        passwordTextField.rx_text
            .bindTo(viewModel.passwordText)
            .addDisposableTo(disposeBag)
        
        viewModel.loginValidTrigger
            .bindTo(loginLabel.rx_hidden)
            .addDisposableTo(disposeBag)
        
        viewModel.passwordValidTrigger
            .bindTo(passwordLabel.rx_hidden)
            .addDisposableTo(disposeBag)
        
        viewModel.loginEnabledTrigger.asObservable()
            .bindTo(loginButton.rx_enabled)
            .addDisposableTo(disposeBag)
        
        viewModel.loginEnabledTrigger.asObservable()
            .bindTo(signupButton.rx_enabled)
            .addDisposableTo(disposeBag)
        
        viewModel.loginFinished
            .driveNext { [weak self] in
                let alert = UIAlertController(title: "Logged In", message: nil, preferredStyle: .Alert)
                let cancelAction = UIAlertAction(title: "OK", style: .Cancel, handler: .None)
                alert.addAction(cancelAction)
                self?.presentViewController(alert, animated: true, completion: .None)
            }
            .addDisposableTo(disposeBag)
        
        viewModel.signupFinished
            .driveNext { [weak self] in
                let alert = UIAlertController(title: "Signed Up", message: nil, preferredStyle: .Alert)
                let cancelAction = UIAlertAction(title: "OK", style: .Cancel, handler: .None)
                alert.addAction(cancelAction)
                self?.presentViewController(alert, animated: true, completion: .None)
            }
            .addDisposableTo(disposeBag)
    }
    
}

