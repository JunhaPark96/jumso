import UIKit

class ViewController: UIViewController {
    var shouldManageKeyboardObservers: Bool = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if shouldManageKeyboardObservers {
            setupKeyBoardDismissal()
        }
    }

    deinit {
        if shouldManageKeyboardObservers {
            removeKeyboardNotificationObservers()
        }
    }
}

extension UIViewController {
    func setupKeyBoardDismissal() {
        // 화면 탭 시 키보드 내리기
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        tapGesture.cancelsTouchesInView = false
        self.view.addGestureRecognizer(tapGesture)
        
        // 키보드 이벤트 옵저버 등록
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(notification:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(notification:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @objc func dismissKeyboard() {
        self.view.endEditing(true)
    }
    
    @objc func keyboardWillShow(notification: NSNotification) {
        if let keyboardFrame = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue {
            let keyboardHeight = keyboardFrame.cgRectValue.height
            
            // EmailAuthenticationViewController에서 buttonBottomConstraint만 변경
            if let emailAuthVC = self as? EmailAuthenticationViewController {
                UIView.animate(withDuration: 0.3) {
                    emailAuthVC.buttonBottomConstraint.constant = keyboardHeight + 10 // 키보드 바로 위로 10pt 여유
                    emailAuthVC.view.layoutIfNeeded() // 레이아웃 업데이트
                }
            }
        }
    }
    
    @objc func keyboardWillHide(notification: NSNotification) {
        if let emailAuthVC = self as? EmailAuthenticationViewController {
            UIView.animate(withDuration: 0.3) {
//                emailAuthVC.buttonBottomConstraint.constant = 50 // 원래 위치로 복원
                emailAuthVC.view.layoutIfNeeded() // 레이아웃 업데이트
            }
        }
    }

    func removeKeyboardNotificationObservers() {
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }
}
