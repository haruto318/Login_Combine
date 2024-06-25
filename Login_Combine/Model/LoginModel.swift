//
//  LoginModel.swift
//  Login_Combine
//
//  Created by 濱野遥斗 on 2024/06/19.
//

import Foundation
import Combine

final class LoginModel {
    private(set) var userId = ""
    private(set) var password = ""
//    @Published private(set) var isValid = false
    private let isValid = CurrentValueSubject<Bool, Never>(false)
    
    var isValidPub: AnyPublisher<Bool, Never> {
        isValid.eraseToAnyPublisher()
    }
    
    func update(userId: String, password: String){
        self.userId = userId
        self.password = password
//        isValid = userId.count >= 4 && password.count >= 4
        isValid.value = userId.count >= 4 && password.count >= 4
    }
    
    func login() {
        print("login userId:\(userId) password:\(password)")
    }
}
