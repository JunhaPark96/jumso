import UIKit

class AuthenticationCodeViewController: ViewController {
 
    var fullEmailAddress: String?
    var authenticationCodeInput: String?
    let tempAuthenticationCode = "qwer"

    @IBOutlet weak var FullEmailAddressLabel: UILabel!
    @IBOutlet weak var AuthenticationCodeInputTextField: UITextField!
    @IBOutlet weak var buttonBottomConstraint: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 이전 화면에서 전달 받은 completeEmail
        if let fullEmailAddress {
            FullEmailAddressLabel.text = fullEmailAddress
        }
        
        if shouldManageKeyboardObservers {
            setupKeyBoardDismissal()
        }
    }
    override func adjustForKeyboardAppearance(keyboardShowing: Bool, keyboardHeight: CGFloat) {
        if keyboardShowing {
            let keyboardHeight = keyboardHeight + 10
            UIView.animate(withDuration: 0.3) {
                self.buttonBottomConstraint.constant = keyboardHeight
                self.view.layoutIfNeeded()
            }
        }
    }
    
    deinit {
        removeKeyboardNotificationObservers()
    }
    
    private func emailAuthentication(authorizaitonCode: String) {
        
    }
    
    @IBAction func codeAuthenticatedDidTap(_ sender: UIButton) {
        dismissKeyboard()
        
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
    
}
