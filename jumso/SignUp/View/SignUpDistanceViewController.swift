import UIKit

class SignUpDistanceViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    @IBAction func SignUpDistanceDidTap(_ sender: Any) {
        
        let storyboard = UIStoryboard(name: "SignUp", bundle: nil)
        
        let signUpProfileViewController = storyboard.instantiateViewController(withIdentifier: "SignUpProfileVC") as! SignUpProfileViewController
        
        self.navigationController?.pushViewController(signUpProfileViewController, animated: true)
    }
    

}
