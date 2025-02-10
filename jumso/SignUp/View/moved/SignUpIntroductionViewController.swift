//import UIKit
//
//class SignUpIntroductionViewController: SignUpBaseViewController {
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        updateProgress(currentSignUpStep: 6)
//        
//    }
//    
//    @IBAction func SignUpIntroductionDidTap(_ sender: Any) {
//        let storyboard = UIStoryboard(name: "SignUp", bundle: nil)
//        
//        let signUpPreferenceViewController = storyboard.instantiateViewController(withIdentifier: "SignUpPreferenceVC") as! SignUpPreferenceViewController
//        
//        self.navigationController?.pushViewController(signUpPreferenceViewController, animated: true)
//    }
//    
//}
