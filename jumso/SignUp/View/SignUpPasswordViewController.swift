import UIKit

class SignUpPasswordViewController: SignUpBaseViewController {
    var passwordChecked: Bool = false;
    var originalBottomConstraint: CGFloat = 0
    
    @IBOutlet weak var PasswordInputTextField: UITextField!
    @IBOutlet weak var PasswordConfirmInputTextField: UITextField!
    @IBOutlet weak var buttonBottomConstraint: NSLayoutConstraint!
    @IBOutlet weak var SignUpPasswordButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        originalBottomConstraint = buttonBottomConstraint.constant
        SignUpPasswordButton.isEnabled = false
        
        // 텍스트 필드에 변경이 있을 때마다 호출
        PasswordInputTextField.addTarget(self, action: #selector(textFieldsDidChange), for: .editingChanged)
        PasswordConfirmInputTextField.addTarget(self, action: #selector(textFieldsDidChange), for: .editingChanged)
    }
    
//    override func adjustForKeyboardAppearance(keyboardShowing: Bool, keyboardHeight: CGFloat) {
//        SignUpKeyboardManager.adjustKeyboardForView(
//            viewController: self,
//            isShowing: keyboardShowing,
//            keyboardHeight: keyboardHeight,
//            bottomConstraint: buttonBottomConstraint,
//            originalBottomConstraint: originalBottomConstraint
//        )
//    }
    
    private func passwordConfirmCheck(firstPassword: String, secondPassword: String) -> Bool {
        if firstPassword == secondPassword {
            passwordChecked = true
            return passwordChecked
        } else {
            return passwordChecked
        }
    }
    // 텍스트 필드 값 변경 시 호출되는 메서드
    @objc func textFieldsDidChange() {
        // 두 패스워드 필드가 모두 채워져 있으면 버튼 활성화
        let isPasswordFilled = PasswordInputTextField.text?.isEmpty == false
        let isConfirmPasswordFilled = PasswordConfirmInputTextField.text?.isEmpty == false
        
        // 두 필드가 모두 채워지면 회원가입 버튼 활성화
        SignUpPasswordButton.isEnabled = isPasswordFilled && isConfirmPasswordFilled
    }
    
    @IBAction func SignUpPasswordDidTap(_ sender: UIButton) {
        
        guard let firstPassword = PasswordInputTextField.text, let secondPassword = PasswordConfirmInputTextField.text else {
            print("SignUpPasswordViewController - 비밀번호 입력란이 비어있습니다.")
            return
        }
        
        let storyboard = UIStoryboard(name: "SignUp", bundle: nil)
        let signUpNameViewController = storyboard.instantiateViewController(withIdentifier: "SignUpNameVC") as! SignUpNameViewController
        
        print("SignUpPasswordViewController - 첫 번째 비밀번호는 \(firstPassword)")
        print("SignUpPasswordViewController - 두 번째 비밀번호는 \(secondPassword)")
        
        
        if passwordConfirmCheck(firstPassword: firstPassword, secondPassword: secondPassword) {
            self.navigationController?.pushViewController(signUpNameViewController, animated: true)
        } else {
            print("SignUpPasswordViewController - 비밀번호가 일치하지 않습니다.")
        }
        
    }
    
    
    
}
