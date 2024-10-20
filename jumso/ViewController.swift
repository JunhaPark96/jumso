import UIKit

class ViewController: UIViewController {
//    var shouldManageKeyboardObservers: Bool = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        if shouldManageKeyboardObservers {
//            setupKeyBoardDismissal()
//        }
    }
    
//    deinit {
//        if shouldManageKeyboardObservers {
//            removeKeyboardNotificationObservers()
//        }
//    }
//    // 이 메소드를 각 ViewController에서 오버라이드할 수 있게 기본 클래스에 정의합니다.
//    func adjustForKeyboardAppearance(keyboardShowing: Bool, keyboardHeight: CGFloat) {
//        // 기본적으로 아무 동작도 하지 않음.
//        // 각 VC에서 오버라이드하여 필요한 동작을 수행할 수 있음
//    }
    
}

//extension UIViewController {
//    func setupKeyBoardDismissal() {
//        // 화면 탭 시 키보드 내리기
//        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
//        tapGesture.cancelsTouchesInView = false
//        self.view.addGestureRecognizer(tapGesture)
//        
//        // 키보드 이벤트 옵저버 등록
//        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(notification:)), name: UIResponder.keyboardWillShowNotification, object: nil)
//        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(notification:)), name: UIResponder.keyboardWillHideNotification, object: nil)
//    }
//    
//    @objc func dismissKeyboard() {
//        self.view.endEditing(true)
//    }
//    
//    @objc func keyboardWillShow(notification: NSNotification) {
//        if let keyboardFrame = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue {
//            let keyboardHeight = keyboardFrame.cgRectValue.height
//            
//            
//            // 부모 클래스의 메서드 호출 (오버라이드 가능)
//            if let viewController = self as? ViewController {
//                viewController.adjustForKeyboardAppearance(keyboardShowing: true, keyboardHeight: keyboardHeight)
//            }
//            
//        }
//    }
//    
//    @objc func keyboardWillHide(notification: NSNotification) {
//        // 부모 클래스의 메서드 호출 (오버라이드 가능)
//        if let viewController = self as? ViewController {
//            viewController.adjustForKeyboardAppearance(keyboardShowing: false, keyboardHeight: 0)
//        }
//    }
//    
//    
//    
//    func removeKeyboardNotificationObservers() {
//        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
//        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
//    }
//}
