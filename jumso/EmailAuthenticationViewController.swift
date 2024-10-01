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
        dismissKeyboard()
        
        let storyboard = UIStoryboard(name: "SignUp", bundle: nil)
        let emailAuthenticationViewController = storyboard.instantiateViewController(withIdentifier: "AuthenticationCodeVC") as! AuthenticationCodeViewController
        
        self.navigationController?.pushViewController(emailAuthenticationViewController, animated: true)
    }
}

