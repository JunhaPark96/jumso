import UIKit

extension UIViewController {
    
    @objc func dismissKeyboard() {
        self.view.endEditing(true)
    }
    
//    @objc func keyboardWillShow(notification: NSNotification) {
//        if let keyboardFrame = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue {
//            let keyboardHeight = keyboardFrame.cgRectValue.height
//            
//            
//            // 부모 클래스의 메서드 호출 (오버라이드 가능)
//            if let viewController = self as? SignUpBaseViewController {
//                viewController.adjustForKeyboardAppearance(keyboardShowing: true, keyboardHeight: keyboardHeight)
//            }
//            
//        }
//    }
//    
//    @objc func keyboardWillHide(notification: NSNotification) {
//        // 부모 클래스의 메서드 호출 (오버라이드 가능)
//        if let viewController = self as? SignUpBaseViewController {
//            viewController.adjustForKeyboardAppearance(keyboardShowing: false, keyboardHeight: 0)
//        }
//    }
}
