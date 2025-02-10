//import UIKit
//
//class SignUpNameViewController: SignUpBaseViewController {
//    var originalBottomConstraint: CGFloat = 0
//    var isButtonTapped: Bool = false
//    var nameChecked: Bool = false;
//    
//    
//    @IBOutlet weak var buttonBottomConstraint: NSLayoutConstraint!
//    @IBOutlet weak var NameInputTextField: UITextField!
//    @IBOutlet weak var SignUpNameButton: UIButton!
//    
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        let originalConstraintValue = buttonBottomConstraint.constant
//        registerBottomConstraint(bottomConstraint: buttonBottomConstraint, originalValue: originalConstraintValue)
//        
//        keyboardManager.canAdjustForKeyboard = { [weak self] in
//            return !(self?.isButtonTapped ?? true)
//        }
//        
//        updateProgress(currentSignUpStep: 1)
//        SignUpNameButton.isEnabled = false
//        
//        NameInputTextField.addTarget(self, action: #selector(textFieldsDidChange), for: .editingChanged)
//        
//        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleButtonTap))
//        SignUpNameButton.addGestureRecognizer(tapGesture)
//    }
//    
//    @objc func textFieldsDidChange() {
//        // 두 패스워드 필드가 모두 채워져 있으면 버튼 활성화
//        let isNameFilled = NameInputTextField.text?.isEmpty == false
//        
//        // 필드가 모두 채워지면 회원가입 버튼 활성화
//        SignUpNameButton.isEnabled = isNameFilled
//    }
//    
//    @objc func handleButtonTap() {
//        isButtonTapped = true
//        
//        // TODO: 닉네임 중복 시 알림 창
//        
//        let storyboard = UIStoryboard(name: "SignUp", bundle: nil)
//        let signUpBirthDayViewController = storyboard.instantiateViewController(withIdentifier: "SignUpBirthDayVC") as! SignUpBirthDayViewController
//        
//        // 버튼 동작 처리 (키보드를 내리지 않도록 함)
//        self.navigationController?.pushViewController(signUpBirthDayViewController, animated: true)
//    }
//    
//    @objc override func dismissKeyboard() {
//        isButtonTapped = false // 다른 곳을 터치하면 다시 플래그 해제
//        view.endEditing(true)
//    }
//    
//}
