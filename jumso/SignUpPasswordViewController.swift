

import UIKit

class SignUpPasswordViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        
    }
    
    @IBAction func SignUpPasswordDidTap(_ sender: UIButton) {
        // 1. 스토리보드 생성
        let storyboard = UIStoryboard(name: "SignUp", bundle: nil)
        
        // 2. 뷰 컨트롤러 생성
        let signUpNameViewController = storyboard.instantiateViewController(withIdentifier: "SignUpNameVC") as! SignUpNameViewController
        
        // 3. 화면전환 메소드로 화면 전환
//        self.present(registerViewController, animated: true, completion: nil)
        // container view controller
        self.navigationController?.pushViewController(signUpNameViewController, animated: true)
    }
    
    

}
