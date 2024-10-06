import UIKit

class SignUpBirthDayViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    

    @IBAction func SignUpBirthDayDidTap(_ sender: Any) {
        let storyboard = UIStoryboard(name: "SignUp", bundle: nil)
        
        let signUpGenderViewController = storyboard.instantiateViewController(withIdentifier: "SignUpGenderVC") as! SignUpGenderViewController
        
        self.navigationController?.pushViewController(signUpGenderViewController, animated: true)
    }
    
}
