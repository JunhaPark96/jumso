import UIKit

class SignUpGenderViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    


    @IBAction func SignUpGenderDidTap(_ sender: Any) {
        let storyboard = UIStoryboard(name: "SignUp", bundle: nil)
        
        let signUpDistanceViewController = storyboard.instantiateViewController(withIdentifier: "SignUpDistanceVC") as! SignUpDistanceViewController
        
        self.navigationController?.pushViewController(signUpDistanceViewController, animated: true)
    }
    
}
