import UIKit


class EmailAuthenticationViewController: UIViewController {
    
    var shouldManageKeyboardObservers: Bool = true
    var companyEmailDomains: [String]?
    
    
    @IBOutlet weak var InputEmailIDTextField: UITextField!
    @IBOutlet weak var EmailAddressLabel: UILabel!
    @IBOutlet weak var EmailDomainLabel: UILabel!
    @IBOutlet weak var EmailDomainButton: UIButton!
    @IBOutlet weak var EmailAuthenticationButton: UIButton!
    @IBOutlet weak var buttonBottomConstraint: NSLayoutConstraint!
    
    var selectedEmailDomain: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if shouldManageKeyboardObservers {
            setupKeyBoardDismissal()
        }
        
        if let emailDomains = companyEmailDomains {
            EmailDomainLabel.text = emailDomains.joined(separator: ", ")
        }
        
        configureEmailDomainUI()
    }
    
    deinit {
        if shouldManageKeyboardObservers {
            removeKeyboardNotificationObservers()
        }
    }
    
    private func configureEmailDomainUI() {
        guard let emailDomains = companyEmailDomains else {
            return
        }
        
        // 도메인 하나면 라벨, 두개 이상이면 드롭다운 버튼
        if emailDomains.count == 1 {
            EmailDomainLabel.isHidden = false
            EmailDomainButton.isHidden = true
            EmailDomainLabel.text = emailDomains.first
            selectedEmailDomain = emailDomains.first
        } else {
            EmailDomainLabel.isHidden = true
            EmailDomainButton.isHidden = false
            EmailDomainButton.setTitle(emailDomains.first, for: .normal)
            selectedEmailDomain = emailDomains.first
        }
    }
    
    @IBAction func emailDomainButtonTapped(_ sender: Any) {
        let alertController = UIAlertController(title: "Select Email Domain", message: nil, preferredStyle: .actionSheet)
        
        companyEmailDomains?.forEach { domain in
            let action = UIAlertAction(title: domain, style: .default) { [weak self] _ in
                self?.EmailDomainButton.setTitle(domain, for: .normal)
                self?.selectedEmailDomain = domain
            }
            alertController.addAction(action)
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        alertController.addAction(cancelAction)
        
        
        present(alertController, animated: true, completion: nil)
    }
    
    
    @IBAction func emailAuthenticateDidTap(_ sender: UIButton) {
        dismissKeyboard()
        
        guard let email = InputEmailIDTextField.text, let domain = selectedEmailDomain else {
            print("이메일 또는 도메인이 선택되지 않았습니다.")
            return
        }
        
        let completeEmail = "\(email)@\(domain)"
        print("이메일 인증할 주소: \(completeEmail)")
        
        let storyboard = UIStoryboard(name: "SignUp", bundle: nil)
        let emailAuthenticationViewController = storyboard.instantiateViewController(withIdentifier: "AuthenticationCodeVC") as! AuthenticationCodeViewController
        
        self.navigationController?.pushViewController(emailAuthenticationViewController, animated: true)
    }
}

