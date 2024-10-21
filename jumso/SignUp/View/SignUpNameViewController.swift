import UIKit

class SignUpNameViewController: SignUpBaseViewController {
    var originalBottomConstraint: CGFloat = 0
    var nameChecked: Bool = false;
    var isButtonTapped: Bool = false
    
    @IBOutlet weak var buttonBottomConstraint: NSLayoutConstraint!
    @IBOutlet weak var NameInputTextField: UITextField!
    @IBOutlet weak var SignUpNameButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        originalBottomConstraint = buttonBottomConstraint.constant
        updateProgress(currentSignUpStep: 1)
        
        SignUpNameButton.isEnabled = false
        
        NameInputTextField.addTarget(self, action: #selector(textFieldsDidChange), for: .editingChanged)
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleButtonTap))
        SignUpNameButton.addGestureRecognizer(tapGesture)
    }
    
    override func adjustForKeyboardAppearance(keyboardShowing: Bool, keyboardHeight: CGFloat) {
        guard !isButtonTapped else { return }
        
        SignUpKeyboardManager.adjustKeyboardForView(
            viewController: self,
            isShowing: keyboardShowing,
            keyboardHeight: keyboardHeight,
            bottomConstraint: buttonBottomConstraint,
            originalBottomConstraint: originalBottomConstraint
        )
    }
    
    @objc func textFieldsDidChange() {
        // 두 패스워드 필드가 모두 채워져 있으면 버튼 활성화
        let isNameFilled = NameInputTextField.text?.isEmpty == false
        
        // 필드가 모두 채워지면 회원가입 버튼 활성화
        SignUpNameButton.isEnabled = isNameFilled
        
    }
    
    //    @IBAction func SignUpNameDidTap(_ sender: UIButton) {
    //        // TODO: 닉네임 중복 시 알림 창
    //        isButtonTapped = true
    //        NameInputTextField.resignFirstResponder()
    //        
    //        let storyboard = UIStoryboard(name: "SignUp", bundle: nil)
    //        
    //        let signUpBirthDayViewController = storyboard.instantiateViewController(withIdentifier: "SignUpBirthDayVC") as! SignUpBirthDayViewController
    //        
    //        self.navigationController?.pushViewController(signUpBirthDayViewController, animated: true)
    //        
    //        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
    //                    self.dismissKeyboard()
    //                }
    //    }
    
    @objc func handleButtonTap() {
        isButtonTapped = true
        
        let storyboard = UIStoryboard(name: "SignUp", bundle: nil)
        let signUpBirthDayViewController = storyboard.instantiateViewController(withIdentifier: "SignUpBirthDayVC") as! SignUpBirthDayViewController
        
        // 버튼 동작 처리 (키보드를 내리지 않도록 함)
        self.navigationController?.pushViewController(signUpBirthDayViewController, animated: true)
    }
    
    @objc override func dismissKeyboard() {
        isButtonTapped = false // 다른 곳을 터치하면 다시 플래그 해제
        view.endEditing(true)
    }
    
}
