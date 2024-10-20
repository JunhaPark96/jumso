import UIKit

class EmailAuthenticationViewController: SignUpBaseViewController {
    
    var companyEmailDomains: [String]?
    
    @IBOutlet weak var InputEmailIDTextField: UITextField!
    @IBOutlet weak var EmailAddressLabel: UILabel!
    @IBOutlet weak var EmailDomainLabel: UILabel!
    @IBOutlet weak var EmailDomainButton: UIButton!
    @IBOutlet weak var EmailAuthenticationButton: UIButton!
    @IBOutlet weak var buttonBottomConstraint: NSLayoutConstraint!
    
    var selectedEmailDomain: String?
    var originalBottomConstraint: CGFloat = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        originalBottomConstraint = buttonBottomConstraint.constant
        
        if let emailDomains = companyEmailDomains {
            EmailDomainLabel.text = emailDomains.joined(separator: ", ")
        }
        
//        configureEmailDomainUI()
        SignUpAppearance.configureEmailDomainUI(controller: self, emailDomains: companyEmailDomains)
    }
    
    override func adjustForKeyboardAppearance(keyboardShowing: Bool, keyboardHeight: CGFloat) {
        SignUpKeyboardManager.adjustKeyboardForView(
            viewController: self,
            isShowing: keyboardShowing,
            keyboardHeight: keyboardHeight,
            bottomConstraint: buttonBottomConstraint,
            originalBottomConstraint: originalBottomConstraint
        )
    }
    
    @IBAction func emailAuthenticateDidTap(_ sender: UIButton) {
//        SignUpKeyboardManager.removeKeyboardNotificationObservers(for: self)
        
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
}

