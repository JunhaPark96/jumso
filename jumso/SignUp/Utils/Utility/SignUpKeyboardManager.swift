import UIKit

class SignUpKeyboardManager {
    private weak var currentBottomConstraint: NSLayoutConstraint?
    private var originalBottomConstraint: CGFloat = 0
    private weak var currentViewController: UIViewController?
    
    // Constraint 등록 메서드 추가
    func registerConstraint(
        bottomConstraint: NSLayoutConstraint,
        originalConstraintValue: CGFloat
    ) {
        self.currentBottomConstraint = bottomConstraint
        self.originalBottomConstraint = originalConstraintValue
    }
    
    // 추가된 상태 검사 클로저
    var canAdjustForKeyboard: (() -> Bool)?
    
    private func adjustKeyboard(
        in viewController: UIViewController, // UIViewController 인스턴스를 추가
        isShowing: Bool,
        keyboardHeight: CGFloat,
        animationDuration: Double,
        animationCurve: UIView.AnimationOptions,
        extraPadding: CGFloat = 10
    ) {
        if let canAdjustForKeyboard = canAdjustForKeyboard, !canAdjustForKeyboard() {
            return
        }
        
        guard let bottomConstraint = currentBottomConstraint else { return }
        
        let newKeyboardHeight = isShowing ? keyboardHeight + extraPadding : originalBottomConstraint
        
        let animator = UIViewPropertyAnimator(duration: animationDuration, curve: .easeInOut) {
            bottomConstraint.constant = newKeyboardHeight
            viewController.view.layoutIfNeeded() // 전달된 viewController의 view 레이아웃 업데이트
        }
        animator.startAnimation()
    }

    
    // 키보드 옵저버 설정
    func setupKeyboardObservers(for viewController: UIViewController) {
        currentViewController = viewController
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(notification:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(notification:)), name: UIResponder.keyboardWillHideNotification, object: nil)
        
        let tapGesture = UITapGestureRecognizer(target: viewController, action: #selector(viewController.dismissKeyboard))
        tapGesture.cancelsTouchesInView = false
        viewController.view.addGestureRecognizer(tapGesture)
    }
    
    func removeKeyboardNotificationObservers(for viewController: UIViewController) {
        NotificationCenter.default.removeObserver(viewController, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(viewController, name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @objc private func keyboardWillShow(notification: NSNotification) {
        if let keyboardFrame = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue,
           let animationDuration = notification.userInfo?[UIResponder.keyboardAnimationDurationUserInfoKey] as? Double,
           let animationCurveRawValue = notification.userInfo?[UIResponder.keyboardAnimationCurveUserInfoKey] as? UInt,
           let viewController = currentViewController { // viewController를 가져옴
           
            let keyboardHeight = keyboardFrame.cgRectValue.height
            let animationCurve = UIView.AnimationOptions(rawValue: animationCurveRawValue << 16)
            adjustKeyboard(in: viewController, isShowing: true, keyboardHeight: keyboardHeight, animationDuration: animationDuration, animationCurve: animationCurve)
        }
    }

    @objc private func keyboardWillHide(notification: NSNotification) {
        if let animationDuration = notification.userInfo?[UIResponder.keyboardAnimationDurationUserInfoKey] as? Double,
           let animationCurveRawValue = notification.userInfo?[UIResponder.keyboardAnimationCurveUserInfoKey] as? UInt,
           let viewController = currentViewController { // viewController를 가져옴
           
            let animationCurve = UIView.AnimationOptions(rawValue: animationCurveRawValue << 16)
            adjustKeyboard(in: viewController, isShowing: false, keyboardHeight: 0, animationDuration: animationDuration, animationCurve: animationCurve)
        }
    }

}
