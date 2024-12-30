import UIKit
import SwiftUI

class LoginViewController: UIViewController {
    var authViewModel: AuthViewModel?
    
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
        guard let authViewModel = authViewModel else {
            print("❌ authViewModel이 nil입니다. 로그인 실패.")
            return
        }
        
        // Mock 로그인 처리
        let loggedInUser = MockData.loggedInUser
        authViewModel.logIn(userID: loggedInUser.id)
        
        // MainTabBarController 생성
        let tabBarController = MainTabBarController(
            authViewModel: authViewModel,
            chatListViewModel: ChatListViewModel()
        )
        
        // 애니메이션 추가
        guard let windowScene = UIApplication.shared.connectedScenes
                    .first(where: { $0.activationState == .foregroundActive }) as? UIWindowScene,
                  let window = windowScene.windows.first else {
                print("❌ UIWindow를 찾을 수 없습니다.")
                return
            }
        
        let transition = CATransition()
        transition.type = .moveIn // 화면이 이동하는 효과
        transition.subtype = .fromBottom // 아래에서 위로
        transition.duration = 0.4
        transition.timingFunction = CAMediaTimingFunction(name: .easeInEaseOut)
        window.layer.add(transition, forKey: kCATransition)
        window.rootViewController = tabBarController
        
    }
    
    @IBAction func registerButtonDidTap(_ sender: UIButton) {
        
        // UIKIT 코드
//        if let navigationController = self.navigationController {
//            print("Navigation controller exists")
//            let storyboard = UIStoryboard(name: "SignUp", bundle: nil)
//            let registerViewController = storyboard.instantiateViewController(withIdentifier: "RegisterVC") as! RegisterViewController
//            navigationController.pushViewController(registerViewController, animated: true)
//        } else {
//            print("Navigation controller is nil")
//        }
        
        
        // SwiftUI 코드
        print("Register 버튼 클릭됨")
        
        // RegisterView를 UIHostingController로 래핑
        let registerView = SignUpIntroductionView()
        let hostingController = UIHostingController(rootView: registerView)
        
        // 네비게이션 스택에 푸시
        if let navigationController = self.navigationController {
            navigationController.pushViewController(hostingController, animated: true)
        } else {
            print("❌ Navigation controller가 없습니다.")
        }
        
        
    }
    
    
}
