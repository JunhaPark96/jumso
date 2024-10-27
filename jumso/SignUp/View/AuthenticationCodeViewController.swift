import UIKit

class AuthenticationCodeViewController: SignUpBaseViewController {
    var originalBottomConstraint: CGFloat = 0
    var fullEmailAddress: String?
    var authenticationCodeInput: String?
    var isButtonTapped: Bool = false
    let tempAuthenticationCode = "q"
    
    @IBOutlet weak var buttonBottomConstraint: NSLayoutConstraint!
    @IBOutlet weak var FullEmailAddressLabel: UILabel!
    @IBOutlet weak var AuthenticationCodeInputTextField: UITextField!
    @IBOutlet weak var AuthenticationCodeButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        originalBottomConstraint = buttonBottomConstraint.constant
        
        AuthenticationCodeButton.isEnabled = false
        
        // 이전 화면에서 전달 받은 completeEmail
        if let fullEmailAddress {
            FullEmailAddressLabel.text = fullEmailAddress
        }
        
        AuthenticationCodeInputTextField.addTarget(self, action: #selector(textFieldsDidChange), for: .editingChanged)
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleButtonTap))
        AuthenticationCodeButton.addGestureRecognizer(tapGesture)
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
    
    @objc func textFieldsDidChange() {
        // 두 패스워드 필드가 모두 채워져 있으면 버튼 활성화
        let isNameFilled = AuthenticationCodeInputTextField.text?.isEmpty == false
        
        // 필드가 모두 채워지면 회원가입 버튼 활성화
        AuthenticationCodeButton.isEnabled = isNameFilled
    }
    
    private func emailAuthentication(authorizaitonCode: String) {
        // TODO: 이메일 인증 처리 로직
    }
    
    @objc func handleButtonTap() {
        isButtonTapped = true
        
        authenticationCodeInput = AuthenticationCodeInputTextField.text
        print("AuthenticationCode - 입력된 인증번호는  \(authenticationCodeInput!)")
        
        
        // 1. 스토리보드 생성
        let storyboard = UIStoryboard(name: "SignUp", bundle: nil)
        
        // 2. 뷰 컨트롤러 생성
        let signUpPasswordViewController = storyboard.instantiateViewController(withIdentifier: "SignUpPasswordVC") as! SignUpPasswordViewController
        
        guard let emailCode = authenticationCodeInput else {
            print("AuthenticationCode - 인증번호가 틀렸습니다.")
            print("AuthenticationCode - 인증번호를 입력하지 않았습니다.")
            return
        }
        // TODO: API통신으로 전달받은 값과 일치하는지 확인하는 코드
        if emailCode == tempAuthenticationCode {
            self.navigationController?.pushViewController(signUpPasswordViewController, animated: true)
        }
       
    }
    @objc override func dismissKeyboard() {
        isButtonTapped = false // 다른 곳을 터치하면 다시 플래그 해제
        view.endEditing(true)
    }
        
}
