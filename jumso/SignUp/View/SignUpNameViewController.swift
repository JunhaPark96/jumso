import UIKit

class SignUpNameViewController: SignUpBaseViewController {
    
    var nameChecked: Bool = false;
    
//    @IBOutlet weak var buttonBottomConstraint: NSLayoutConstraint!
    @IBOutlet weak var NameInputTextField: UITextField!
    @IBOutlet weak var SignUpNameButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateProgress(currentSignUpStep: 1)
        
        SignUpNameButton.isEnabled = false
        
        NameInputTextField.addTarget(self, action: #selector(textFieldsDidChange), for: .editingChanged)
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
        let isNameFilled = NameInputTextField.text?.isEmpty == false
        
        // 필드가 모두 채워지면 회원가입 버튼 활성화
        SignUpNameButton.isEnabled = isNameFilled
        
    }
    
    @IBAction func SignUpNameDidTap(_ sender: UIButton) {
        // TODO: 닉네임 중복 시 알림 창
        
        let storyboard = UIStoryboard(name: "SignUp", bundle: nil)
        
        let signUpBirthDayViewController = storyboard.instantiateViewController(withIdentifier: "SignUpBirthDayVC") as! SignUpBirthDayViewController
        
        self.navigationController?.pushViewController(signUpBirthDayViewController, animated: true)
    }
    
}
