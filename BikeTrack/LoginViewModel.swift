//
//  LoginViewModel.swift
//  BikeTrack
//
//  Created by Gil Felot on 20/05/16.
//  Copyright © 2016 Gil Felot. All rights reserved.
//

import RxSwift
import RxCocoa
import Moya

class LoginViewModel {
    // Input
    let loginText = Variable("")
    let passwordText = Variable("")
    let loginTaps = PublishSubject<Void>()
    let signupTaps = PublishSubject<Void>()
    
    // Output
    let minCharacterCount = 5
    let loginValidTrigger = PublishSubject<Bool>()
    let passwordValidTrigger = PublishSubject<Bool>()
    let loginEnabledTrigger = Variable<Bool>(false)
    let loginFinished: Driver<Void>
    let signupFinished: Driver<Void>
    
    private let disposeBag = DisposeBag()
    
    init() {
        let login = loginText.asDriver()
        let password = passwordText.asDriver()
        let loginAndPassword = Driver.combineLatest(login, password) { ($0, $1) }
        
        loginFinished = loginTaps.asDriver(onErrorJustReturn: ())
            .withLatestFrom(loginAndPassword)
            .flatMap { (username, password) in
                BikeTrackProvider.request(.Login(username: username, password: password))
                    .filterSuccessfulStatusCodes()
                    .doOnError { _ in print("Error") }
                    .catchError { _ in Observable.empty() }
                    .mapObject(UserToken.self)
                    .doOnNext { print($0) }
                    .map { _ in () }
                    .asDriver(onErrorJustReturn: ())
        }
        
        signupFinished = signupTaps.asDriver(onErrorJustReturn: ())
            .withLatestFrom(loginAndPassword)
            .flatMap { (username, password) in
                BikeTrackProvider.request(.SignUp(username: username, password: password))
                    .filterSuccessfulStatusCodes()
                    .doOnError { _ in print("Error") }
                    .catchError { _ in Observable.empty() }
                    .mapJSON()
                    .doOnNext { print($0) }
                    .map { _ in () }
                    .asDriver(onErrorJustReturn: ())
        }
        
        let validatedLogin = login.map { [weak self] in $0.characters.count >= self?.minCharacterCount }
        let validatedPassword = password.map { [weak self] in $0.characters.count >= self?.minCharacterCount }
        let validated = Driver.combineLatest(validatedLogin, validatedPassword) { $0 && $1 }
        
        validated
            .drive(loginEnabledTrigger)
            .addDisposableTo(disposeBag)
        
        validatedLogin
            .drive(loginValidTrigger)
            .addDisposableTo(disposeBag)
        
        validatedPassword
            .drive(passwordValidTrigger)
            .addDisposableTo(disposeBag)
    }
}