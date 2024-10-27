import UIKit

class EmailAuthenticationViewController: SignUpBaseViewController {
    var originalBottomConstraint: CGFloat = 0
    var isButtonTapped: Bool = false
    var companyEmailDomains: [String]?
    var selectedEmailDomain: String?
    
    @IBOutlet weak var InputEmailIDTextField: UITextField!
    @IBOutlet weak var EmailAddressLabel: UILabel!
    @IBOutlet weak var EmailDomainLabel: UILabel!
    @IBOutlet weak var EmailDomainButton: UIButton!
    @IBOutlet weak var EmailAuthenticationButton: UIButton!
    @IBOutlet weak var buttonBottomConstraint: NSLayoutConstraint!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let originalConstraintValue = buttonBottomConstraint.constant
        registerBottomConstraint(bottomConstraint: buttonBottomConstraint, originalValue: originalConstraintValue)
        
        keyboardManager.canAdjustForKeyboard = { [weak self] in
            return !(self?.isButtonTapped ?? true)
        }
        
        EmailAuthenticationButton.isEnabled = false
        
        if let emailDomains = companyEmailDomains {
            EmailDomainLabel.text = emailDomains.joined(separator: ", ")
        }
        
        SignUpAppearance.configureEmailDomainUI(controller: self, emailDomains: companyEmailDomains)
        
        InputEmailIDTextField.addTarget(self, action: #selector(textFieldsDidChange), for: .editingChanged)
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleButtonTap))
        EmailAuthenticationButton.addGestureRecognizer(tapGesture)
    }
    
    @objc func textFieldsDidChange() {
        // 두 패스워드 필드가 모두 채워져 있으면 버튼 활성화
        let isNameFilled = InputEmailIDTextField.text?.isEmpty == false
        
        // 필드가 모두 채워지면 회원가입 버튼 활성화
        EmailAuthenticationButton.isEnabled = isNameFilled
    }
    
    @objc func handleButtonTap() {
        isButtonTapped = true
        
        guard let email = InputEmailIDTextField.text, let domain = selectedEmailDomain else {
            print("EmailAuthentication - 이메일 또는 도메인이 선택되지 않았습니다.")
            // TODO: 팝업창 띄우기
            return
        }
        
        let completeEmail = "\(email)@\(domain)"
        print("EmailAuthentication - 이메일 인증할 주소: \(completeEmail)")
        
        // TODO: 실제 이메일 주소로 인증API 데이터 전달
        
        
        let storyboard = UIStoryboard(name: "SignUp", bundle: nil)
        let authenticationCodeViewController = storyboard.instantiateViewController(withIdentifier: "AuthenticationCodeVC") as! AuthenticationCodeViewController
        authenticationCodeViewController.fullEmailAddress = completeEmail
        
        self.navigationController?.pushViewController(authenticationCodeViewController, animated: true)
    }
    
    @objc override func dismissKeyboard() {
        isButtonTapped = false // 다른 곳을 터치하면 다시 플래그 해제
        view.endEditing(true)
    }
}

