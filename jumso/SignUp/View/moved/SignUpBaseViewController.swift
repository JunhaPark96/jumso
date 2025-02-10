//
//import UIKit
//
//class SignUpBaseViewController: UIViewController {
//    
//    @IBOutlet var progressBars: [UIProgressView]?
//    var totalSignUpSteps: Int = 8
//    
//    
//    var shouldManageKeyboardObservers: Bool = true
//    let keyboardManager = SignUpKeyboardManager()
//    
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        setupProgressBars()
//        
//        if shouldManageKeyboardObservers {
//            keyboardManager.setupKeyboardObservers(for: self)
//        }
//    }
//    
//    // 각 뷰에서 Constraint 등록
//    func registerBottomConstraint(bottomConstraint: NSLayoutConstraint, originalValue: CGFloat) {
//            keyboardManager.registerConstraint(bottomConstraint: bottomConstraint, originalConstraintValue: originalValue)
//        }
//    
//    
//    
//    // 모든 ProgressBar에 대한 레이아웃 설정
//    func setupProgressBars() {
//        guard let progressBars = progressBars else { return }
//        for progressBar in progressBars {
//            SignUpAppearance.styleProgressBar(progressBar)
//        }
//    }
//    
//    // 모든 ProgressBar에 대한 업데이트
//    func updateProgress(currentSignUpStep: Int) {
//        guard let progressBars = progressBars else { return }
//        let progress = Float(currentSignUpStep) / Float(totalSignUpSteps)
//        
//        for progressBar in progressBars {
//            progressBar.setProgress(progress, animated: true)
//        }
//    }
//    
//    
//    deinit {
//        if shouldManageKeyboardObservers {
//            keyboardManager.removeKeyboardNotificationObservers(for: self)
//        }
//    }
//    // 이 메소드를 각 ViewController에서 오버라이드할 수 있게 기본 클래스에 정의합니다.
//    func adjustForKeyboardAppearance(keyboardShowing: Bool, keyboardHeight: CGFloat) {
//        // 기본적으로 아무 동작도 하지 않음.
//        // 각 VC에서 오버라이드하여 필요한 동작을 수행할 수 있음
//
//    }
//    
//    
//}
//
//
