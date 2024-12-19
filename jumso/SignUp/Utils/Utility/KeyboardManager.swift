import Combine
import SwiftUI

final class KeyboardManager: ObservableObject {
    static let shared = KeyboardManager()
    
    @Published var keyboardHeight: CGFloat = 0
    private var cancellables = Set<AnyCancellable>()
    
    private init() {
        // 키보드가 나타날 때
        let keyboardWillShow = NotificationCenter.default
            .publisher(for: UIResponder.keyboardWillShowNotification)
            .merge(with: NotificationCenter.default.publisher(for: UIResponder.keyboardDidShowNotification))
            .compactMap { notification -> CGFloat? in
                if let keyboardFrame = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect {
                    return UIScreen.main.bounds.height - keyboardFrame.origin.y
                }
                return nil
            }
        
        // 키보드가 사라질 때
        let keyboardWillHide = NotificationCenter.default
            .publisher(for: UIResponder.keyboardWillHideNotification)
            .map { _ in CGFloat(0) }
        
        // 이벤트 병합
        Publishers.Merge(keyboardWillShow, keyboardWillHide)
            .receive(on: RunLoop.main)
            .assign(to: &$keyboardHeight)
    }
    
    // MARK: - 키보드 숨기기
    func hideKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
//import Combine
//import SwiftUI
//
//final class KeyboardManager: ObservableObject {
//    static let shared = KeyboardManager()
//    @Published var keyboardHeight: CGFloat = 0
//    private var cancellables = Set<AnyCancellable>()
//
//    private init() {
//        // 키보드 프레임 변경 시 높이 감지
//        let keyboardWillChangeFrame = NotificationCenter.default
//            .publisher(for: UIResponder.keyboardWillChangeFrameNotification)
//            .map { notification -> CGFloat in
//                if let keyboardFrame = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect {
//                    // 화면에서 키보드가 차지하는 높이 반환
//                    let height = UIScreen.main.bounds.height - keyboardFrame.origin.y
//                    return max(0, height) // 음수 값 방지
//                }
//                return 0
//            }
//
//        // 키보드 숨김 이벤트 시 높이 0 설정
//        let keyboardWillHide = NotificationCenter.default
//            .publisher(for: UIResponder.keyboardWillHideNotification)
//            .map { _ in CGFloat(0) }
//
//        // 두 이벤트를 Merge
//        Publishers.Merge(keyboardWillChangeFrame, keyboardWillHide)
//            .receive(on: RunLoop.main)
//            .sink { [weak self] height in
//                self?.keyboardHeight = height
//            }
//            .store(in: &cancellables)
//    }
//    // MARK: - 키보드 숨기기
//    public func hideKeyboard() {
//        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
//    }
//}

