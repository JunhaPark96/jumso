
import UIKit

class SignUpBaseViewController: UIViewController {
    
    @IBOutlet var progressBars: [UIProgressView]?
    @IBOutlet var buttonBottomConstraints: [NSLayoutConstraint]?
    var totalSignUpSteps: Int = 8
    var originalBottomConstraints: [CGFloat] = []
    
    
    var shouldManageKeyboardObservers: Bool = true
    let keyboardManager = SignUpKeyboardManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupProgressBars()
        
        if let buttonBottomConstraints = buttonBottomConstraints {
            for constraint in buttonBottomConstraints {
                originalBottomConstraints.append(constraint.constant)
            }
        }
        
        if shouldManageKeyboardObservers {
            keyboardManager.setupKeyBoardDismissal(for: self)
        }
    }
    
    // 모든 ProgressBar에 대한 레이아웃 설정
    func setupProgressBars() {
        guard let progressBars = progressBars else { return }
        for progressBar in progressBars {
            SignUpAppearance.styleProgressBar(progressBar)
        }
    }
    
    // 모든 ProgressBar에 대한 업데이트
    func updateProgress(currentSignUpStep: Int) {
        guard let progressBars = progressBars else { return }
        let progress = Float(currentSignUpStep) / Float(totalSignUpSteps)
        
        for progressBar in progressBars {
            progressBar.setProgress(progress, animated: true)
        }
    }
    
    
    deinit {
        if shouldManageKeyboardObservers {
            keyboardManager.removeKeyboardNotificationObservers(for: self)
        }
    }
    // 이 메소드를 각 ViewController에서 오버라이드할 수 있게 기본 클래스에 정의합니다.
    func adjustForKeyboardAppearance(keyboardShowing: Bool, keyboardHeight: CGFloat) {
        // 기본적으로 아무 동작도 하지 않음.
        // 각 VC에서 오버라이드하여 필요한 동작을 수행할 수 있음
//        guard let buttonBottomConstraints = buttonBottomConstraints else { return }
//        
//        for (index, constraint) in buttonBottomConstraints.enumerated() {
//            let originalConstant = originalBottomConstraints[index]
//            let newKeyboardHeight = keyboardShowing ? keyboardHeight + 10 : originalConstant
//            
//            UIView.animate(withDuration: 0.3) {
//                constraint.constant = newKeyboardHeight
//                self.view.layoutIfNeeded()
//            }
//        }
    }
    
    
}


