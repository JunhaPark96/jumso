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
            
            let firstDomain = emailDomains.first ?? "Select Domain"
            setButtonWithTextAndImage(title: firstDomain, image: UIImage(systemName: "chevron.down"))
            selectedEmailDomain = emailDomains.first
            
            var actions: [UIAction] = []
            for domain in emailDomains {
                let action = UIAction(title: domain, handler: { [weak self] _ in
                    self?.EmailDomainButton.setTitle(domain, for: .normal)
                    self?.setButtonWithTextAndImage(title: domain, image: UIImage(systemName: "chevron.down"))
                    self?.selectedEmailDomain = domain
                })
                actions.append(action)
            }
            EmailDomainButton.menu = UIMenu(title: "Select Email Domain", options: .displayInline, children: actions)
            EmailDomainButton.showsMenuAsPrimaryAction = true // 버튼 클릭 시 바로 메뉴가 보이게 설정
        }
    }
    
    private func setButtonWithTextAndImage(title: String, image: UIImage?) {
        var config = UIButton.Configuration.plain()
        config.title = title
        if let image = image {
            let resizedImage = image.withConfiguration(UIImage.SymbolConfiguration(pointSize: 10, weight: .regular))
            config.image = resizedImage.withRenderingMode(.alwaysTemplate)
        }
        
        config.imagePadding = 20
        config.baseBackgroundColor = .black
        config.imagePlacement = .trailing
        
        EmailDomainButton.configuration = config
        EmailDomainButton.tintColor = .black
    }

    
    
    @IBAction func emailAuthenticateDidTap(_ sender: UIButton) {
        dismissKeyboard()
        
        guard let email = InputEmailIDTextField.text, let domain = selectedEmailDomain else {
            print("EmailAuthentication - 이메일 또는 도메인이 선택되지 않았습니다.")
            return
        }
        
        let completeEmail = "\(email)@\(domain)"
        print("EmailAuthentication - 이메일 인증할 주소: \(completeEmail)")
        
        
        let storyboard = UIStoryboard(name: "SignUp", bundle: nil)
        let authenticationCodeViewController = storyboard.instantiateViewController(withIdentifier: "AuthenticationCodeVC") as! AuthenticationCodeViewController
        
        authenticationCodeViewController.fullEmailAddress = completeEmail
        self.navigationController?.pushViewController(authenticationCodeViewController, animated: true)
    }
}

