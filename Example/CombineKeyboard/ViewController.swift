//
//  ViewController.swift
//  CombineKeyboard
//
//  Created by Woollim on 10/16/2020.
//  Copyright (c) 2020 Woollim. All rights reserved.
//

import Combine
import CombineKeyboard
import Then
import SnapKit
import UIKit

class ViewController: UIViewController {
    var cancellables = Set<AnyCancellable>()
    
    let scrollView = UIScrollView()
    let keyboardFrameLabel = UILabel()
    let textField = UITextField()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        bind()
        attribute()
        layout()
    }
    
    func bind() {
        CombineKeyboard.shared.height
            .sink(receiveValue: { [weak self] currentHeight in
                self?.keyboardFrameLabel.text = "Height: \(currentHeight)"
            })
            .store(in: &cancellables)
        
        CombineKeyboard.shared.heightUpdated
            .sink(receiveValue: { [weak self] keyboardHeight in
                let bottomInset = max(self?.safeAreaInset ?? 0, keyboardHeight)
                self?.textField.snp.updateConstraints {
                    $0.bottom.equalToSuperview().offset(-bottomInset)
                }
                self?.view.layoutIfNeeded()
            })
            .store(in: &cancellables)
    }
    
    /// MARK: Component setup.
    func attribute() {
        keyboardFrameLabel.do {
            $0.textAlignment = .center
            $0.textColor = .black
            $0.font = .systemFont(ofSize: 20, weight: .bold)
        }
        
        scrollView.do {
            $0.keyboardDismissMode = .interactive
            $0.alwaysBounceVertical = true
        }
        
        textField.do {
            $0.placeholder = "Enter Text..."
            $0.textColor = .darkGray
            $0.font = .systemFont(ofSize: 15)
            $0.borderStyle = .roundedRect
        }
    }
    
    lazy var safeAreaInset = view.safeAreaInsets.bottom + 16
    func layout() {
        view.addSubview(scrollView)
        scrollView.addSubview(keyboardFrameLabel)
        view.addSubview(textField)
        
        scrollView.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview()
            $0.bottom.equalTo(textField.snp.top)
        }
        
        keyboardFrameLabel.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview()
            $0.center.equalToSuperview()
        }
        
        textField.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(16)
            $0.bottom.equalToSuperview().offset(-safeAreaInset)
        }
    }
}
