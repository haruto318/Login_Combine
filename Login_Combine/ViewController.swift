//
//  ViewController.swift
//  Login_Combine
//
//  Created by 濱野遥斗 on 2024/06/19.
//

import UIKit
import CombineCocoa
import Combine

class ViewController: UIViewController {
    private var subscriptions = Set<AnyCancellable>()
    private let viewModel = LoginViewModel()
    
    @IBOutlet private var userIdTextField: UITextField!
    @IBOutlet private var passwordTextField: UITextField!
    @IBOutlet private var loginButton: UIButton!
    @IBOutlet private var validLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        userIdTextField.textPublisher
            .sink(receiveValue: viewModel.userId.send)
            .store(in: &subscriptions)
        passwordTextField.textPublisher
            .sink(receiveValue: viewModel.password.send)
            .store(in: &subscriptions)
        loginButton.tapPublisher
            .debounce(for: 0.5, scheduler: DispatchQueue.main)
            .sink(receiveValue: viewModel.loginButtonTap.send)
            .store(in: &subscriptions)
        viewModel.loginButtonIsEnabled
            .assign(to: \.isEnabled, on: loginButton)
            .store(in: &subscriptions)
        viewModel.validLabelText
            .assign(to: \.text, on: validLabel)
            .store(in: &subscriptions)
    }


}

