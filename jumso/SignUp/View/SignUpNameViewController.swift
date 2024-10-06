import UIKit

class SignUpNameViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    @IBAction func SignUpNameDidTap(_ sender: UIButton) {
        
        let storyboard = UIStoryboard(name: "SignUp", bundle: nil)
        
        let signUpBirthDayViewController = storyboard.instantiateViewController(withIdentifier: "SignUpBirthDayVC") as! SignUpBirthDayViewController
        
        self.navigationController?.pushViewController(signUpBirthDayViewController, animated: true)
    }
    
}
