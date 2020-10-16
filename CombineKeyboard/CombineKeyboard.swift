//
//  CombineKeyboard.swift
//  CombineKeyboard
//
//  Created by 이병찬 on 2020/10/16.
//

import UIKit
import Foundation
import Combine

@available(iOS 13.0, *)
public class CombineKeyboard {
    public static let shared = CombineKeyboard()
    
    private let _frame: CurrentValueSubject<CGRect, Never>
    private var cancellables = Set<AnyCancellable>()
    
    /// 현재 Keyboard의 Frame을 방출합니다. 관찰 한 직후 가장 최근 값이 방출됩니다.
    public var frame: AnyPublisher<CGRect, Never> {
        _frame.removeDuplicates().eraseToAnyPublisher()
    }
    
    /// 현재 Keyboard의 Height를 방출합니다. 관찰 한 직후 가장 최근 값이 방출됩니다.
    public var height: AnyPublisher<CGFloat, Never> {
        frame.map { UIScreen.main.bounds.height - $0.origin.y }.eraseToAnyPublisher()
    }
    
    /// Keyboard의 Height가 변경될 때 Height의 값이 방출됩니다.
    public var heightUpdated: AnyPublisher<CGFloat, Never> {
        height.dropFirst().eraseToAnyPublisher()
    }
    
    private init() {
        let defaultFrame = CGRect(x: 0, y: UIScreen.main.bounds.height, width: UIScreen.main.bounds.width, height: 0)
        self._frame = .init(defaultFrame)
        
        /// MARK: Keyboard will change frame
        NotificationCenter.default.publisher(for: UIResponder.keyboardWillChangeFrameNotification)
            .map { $0.keyboardFrame(defaultFrame) }
            .subscribe(_frame)
            .store(in: &cancellables)
        
        /// MARK: Keyboard will hide
        NotificationCenter.default.publisher(for: UIResponder.keyboardWillHideNotification)
            .map { $0.keyboardFrame(defaultFrame) }
            .subscribe(_frame)
            .store(in: &cancellables)
    }
}

fileprivate extension Notification {
    func keyboardFrame(_ defaultFrame: CGRect) -> CGRect {
        let value = self.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue
        return value?.cgRectValue ?? defaultFrame
    }
}
