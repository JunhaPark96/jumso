import UIKit

class EmailAuthenticationViewController: UIViewController {
    
    var shouldManageKeyboardObservers: Bool = true
    
    @IBOutlet weak var InputEmailIDTextField: UITextField!
    @IBOutlet weak var EmailAddressLabel: UILabel!
    @IBOutlet weak var emailAuthenticationButton: UIButton!
    @IBOutlet weak var buttonBottomConstraint: NSLayoutConstraint!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if shouldManageKeyboardObservers {
            setupKeyBoardDismissal()
        }
    }
    deinit {
        if shouldManageKeyboardObservers {
            removeKeyboardNotificationObservers()
        }
    }
    
    @IBAction func emailAuthenticateDidTap(_ sender: UIButton) {
        // 키보드 내리기 -> 키보드가 안내려가면 화면전환이 안됨
        dismissKeyboard()
        
        // 1. 스토리보드 생성
        let storyboard = UIStoryboard(name: "SignUp", bundle: nil)
        
        // 2. 뷰 컨트롤러 생성
        let emailAuthenticationViewController = storyboard.instantiateViewController(withIdentifier: "AuthenticationCodeVC") as! AuthenticationCodeViewController
        
        // 3. 화면전환 메소드로 화면 전환
        self.navigationController?.pushViewController(emailAuthenticationViewController, animated: true)
        
    }
    

}
