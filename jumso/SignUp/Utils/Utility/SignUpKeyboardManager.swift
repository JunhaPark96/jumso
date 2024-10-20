import UIKit

class SignUpKeyboardManager {
    static func adjustKeyboardForView (
        viewController: UIViewController,
        isShowing: Bool,
        keyboardHeight: CGFloat,
        bottomConstraint: NSLayoutConstraint,
        originalBottomConstraint: CGFloat,
        extraPadding: CGFloat = 10
    ) {
        let newKeyboardHeight = isShowing ? keyboardHeight + extraPadding : originalBottomConstraint
        UIView.animate(withDuration: 0.3, animations: {
            bottomConstraint.constant = newKeyboardHeight
            viewController.view.layoutIfNeeded()
        })
    }
    
    
    
    func setupKeyBoardDismissal(for viewController: UIViewController) {
        // 화면 탭 시 키보드 내리기
        let tapGesture = UITapGestureRecognizer(target: viewController, action: #selector(viewController.dismissKeyboard))
        tapGesture.cancelsTouchesInView = false
        viewController.view.addGestureRecognizer(tapGesture)
        
        // 키보드 이벤트 옵저버 등록
        NotificationCenter.default.addObserver(viewController, selector: #selector(viewController.keyboardWillShow(notification:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(viewController, selector: #selector(viewController.keyboardWillHide(notification:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    
    
    func removeKeyboardNotificationObservers(for viewController: UIViewController) {
        NotificationCenter.default.removeObserver(viewController, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(viewController, name: UIResponder.keyboardWillHideNotification, object: nil)
    }
}
