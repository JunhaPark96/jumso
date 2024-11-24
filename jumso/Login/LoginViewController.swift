import UIKit

class LoginViewController: UIViewController {
    
    var email = String()
    var password = String()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if #available(iOS 11.0, *) {
            view.insetsLayoutMarginsFromSafeArea = true
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
    }
    
    @IBAction func emailTextFieldEditingChanged(_ sender: UITextField) {
        let text = sender.text ?? ""
        self.email = text
        print(text)
    }
    @IBAction func passwordTextFieldEditingChanged(_ sender: UITextField) {
        let text = sender.text ?? ""
        self.password = text
        print(text)
    }
    // Touch Up Inside: tap
    @IBAction func loginButtonDidTap(_ sender: UIButton) {
        // 1. 스토리보드 생성
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        //
        //        // 2. 뷰 컨트롤러 생성
        let tabBarViewController = storyboard.instantiateViewController(withIdentifier: "TabBarVC") as! MainTabBarController
        
        tabBarViewController.modalPresentationStyle = .fullScreen
        self.present(tabBarViewController, animated: true, completion: nil)
        //        // container view controller
        //        self.navigationController?.pushViewController(tabBarViewController, animated: true)
    }
    
    @IBAction func registerButtonDidTap(_ sender: UIButton) {
        // 네비게이션 컨트롤러가 있는지 확인
        if let navigationController = self.navigationController {
            print("Navigation controller exists")
            let storyboard = UIStoryboard(name: "SignUp", bundle: nil)
            let registerViewController = storyboard.instantiateViewController(withIdentifier: "RegisterVC") as! RegisterViewController
            navigationController.pushViewController(registerViewController, animated: true)
        } else {
            print("Navigation controller is nil")
        }
        // 화면 전환
        
    }
    
    
}
