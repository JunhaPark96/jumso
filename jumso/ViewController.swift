import UIKit

extension UIViewController {
    func setupKeyBoardDismissal() {
        // 키보드 외 화면 탭 시 키보드 내리기
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        tapGesture.cancelsTouchesInView = false
        self.view.addGestureRecognizer(tapGesture)
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(notification:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(notification:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @objc func dismissKeyboard() {
        self.view.endEditing(true)
    }
    
    
    
    @objc func keyboardWillShow(notification: NSNotification){
        if let keyboardFrame = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue {
            let keyboardHeight = keyboardFrame.cgRectValue.height
            
            // 버튼의 제약 조건을 키보드 위로 이동
            if let emailAuthVC = self as? EmailAuthenticationViewController {
                UIView.animate(withDuration: 0.3) {
                    emailAuthVC.buttonBottomConstraint.constant = keyboardHeight + 5  // 키보드 위로 20pt 여유
                    emailAuthVC.view.layoutIfNeeded()  // 레이아웃 업데이트
                }
            }
        }
    }
    
    @objc func keyboardWillHide(notification: NSNotification){
        // 키보드가 내려가면 버튼의 하단 제약을 원래 위치로 복원
        if let emailAuthVC = self as? EmailAuthenticationViewController {
            UIView.animate(withDuration: 0.3) {
                emailAuthVC.buttonBottomConstraint.constant = 50  // 원래 위치로 복원 (필요시 마진 조정)
                emailAuthVC.view.layoutIfNeeded()  // 레이아웃 업데이트
            }
        }
    }
    
    // 옵저버 해제
    func removeKeyboardNotificationObservers() {
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }
}
