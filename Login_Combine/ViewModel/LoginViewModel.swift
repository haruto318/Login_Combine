//
//  LoginViewModel.swift
//  Login_Combine
//
//  Created by 濱野遥斗 on 2024/06/19.
//

import Foundation
import Combine

final class LoginViewModel {
    private var subscriptions = Set<AnyCancellable>()
    private let loginModel = LoginModel()
    
    let userId = CurrentValueSubject<String?, Never>(nil)
    let password = CurrentValueSubject<String?, Never>(nil)
    let loginButtonTap = PassthroughSubject<Void, Never>()
    let loginButtonIsEnabled: AnyPublisher<Bool, Never>
    let validLabelText: AnyPublisher<String?, Never>
    
    init(){
        
//        loginButtonIsEnabled = loginModel.$isValid
//            .map{ $0 }
//            .eraseToAnyPublisher()
//        
//        validLabelText = loginModel.$isValid
//            .map { isValid in
//                isValid ? "Valid" : "Invalid"
//            }
//            .eraseToAnyPublisher()
        
        loginButtonIsEnabled = loginModel.isValidPub
            .map{ $0 }
            .eraseToAnyPublisher()
        
        validLabelText = loginModel.isValidPub
            .map { isValid in
                isValid ? "Valid" : "Invalid"
            }
            .eraseToAnyPublisher()
        
        userId.compactMap { $0 }
            .combineLatest(password.compactMap{ $0 })
            .sink{ userId, password in
                self.loginModel.update(userId: userId, password: password)
            }
            .store(in: &subscriptions)
        
        loginButtonTap
            .sink {
                self.loginModel.login()
            }
            .store(in: &subscriptions)
    }

}
