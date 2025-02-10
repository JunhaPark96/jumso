//import UIKit
//import SwiftUI
//import Alamofire
//
////// ✅ 전역적으로 세션을 유지하는 Singleton 클래스
////class APIManager {
////    static let shared = APIManager()
////    
////    let session: Session
////    
////    private init() {
////        session = Session(eventMonitors: [AFEventLogger()])
////    }
////}
//
//class LoginViewController: UIViewController {
//    var authViewModel: AuthViewModel?
//    
//    var email = String()
//    var password = String()
//    
//    @IBOutlet weak var ForgetPasswordLabel: UILabel!
//    
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        
//        if #available(iOS 11.0, *) {
//            view.insetsLayoutMarginsFromSafeArea = true
//        }
//        
//        setupForgotPasswordLabel() // 🔹 비밀번호 찾기 라벨 터치 이벤트 설정
//    }
//    
//    override func viewWillAppear(_ animated: Bool) {
//        super.viewWillAppear(animated)
//        navigationController?.setNavigationBarHidden(true, animated: animated)
//    }
//    
//    override func viewDidLayoutSubviews() {
//        super.viewDidLayoutSubviews()
//        
//    }
//    
//    @IBAction func emailTextFieldEditingChanged(_ sender: UITextField) {
//        let text = sender.text ?? ""
//        self.email = text
//        print("✉️ Email 입력: \(text)")
//    }
//    @IBAction func passwordTextFieldEditingChanged(_ sender: UITextField) {
//        let text = sender.text ?? ""
//        self.password = text
//        print("🔑 Password 입력: \(text)")
//    }
//    
//    @IBAction func loginButtonDidTap(_ sender: UIButton) {
//        guard !email.isEmpty, !password.isEmpty else {
//            showAlert(message: "이메일과 비밀번호를 모두 입력해주세요.")
//            return
//        }
//        
//        loginAPI(email: email, password: password)
//    }
//    
//    private func loginAPI(email: String, password: String) {
//        let url = "https://api.jumso.life/api/auth/signin"
//        let loginRequest = LoginRequest(email: email, password: password)
//        let headers: HTTPHeaders = [
//            "Content-Type": "application/json"
//        ]
//        
//        // ✅ 기존 session 생성 코드 대신 APIManager에서 전역 세션 사용
//        APIManager.shared.session.request(url,
//                                          method: .post,
//                                          parameters: loginRequest,
//                                          encoder: JSONParameterEncoder.default,
//                                          headers: headers)
//        .validate(statusCode: 200..<300)
//        .responseDecodable(of: LoginResponse.self) { response in
//            switch response.result {
//            case .success(let loginResponse):
//                print("✅ 로그인 성공")
//                print("📧 Email: \(loginResponse.email)")
//                print("👤 Name: \(loginResponse.name)")
//                print("🏷️ Nickname: \(loginResponse.nickname)")
//                
//                if let httpResponse = response.response,
//                   let accessToken = httpResponse.headers.value(for: "Authorization"),
//                   let refreshToken = httpResponse.headers.value(for: "AuthorizationRefresh") {
//                    
//                    // ✅ Access Token 및 Refresh Token 저장
//                    UserDefaults.standard.set(accessToken, forKey: "AccessToken")
//                    UserDefaults.standard.set(refreshToken, forKey: "RefreshToken")
//                    print("🔑 Access Token: \(accessToken)")
//                    print("🔄 Refresh Token: \(refreshToken)")
//                    
//                    DispatchQueue.main.async {
//                        self.authViewModel?.isLoggedIn = true
//                    }
//                }
//                
//                // ✅ 성공 후 메인 화면 이동
//                self.navigateToMainTabBar()
//                
//            case .failure(let error):
//                if let httpResponse = response.response, httpResponse.statusCode == 401 {
//                    print("❌ 로그인 실패: 이메일 또는 비밀번호가 잘못되었습니다.")
//                    self.showAlert(message: "이메일 또는 비밀번호가 잘못되었습니다.")
//                }
//                //                    else {
//                //                        print("❌ 로그인 실패: \(error.localizedDescription)")
//                //                        self.showAlert(message: "로그인 실패: \(error.localizedDescription)")
//                //                    }
//            }
//        }
//    }
//    
//    
//    // MARK: 로그인 처리
//    private func navigateToMainTabBar() {
//        guard let authViewModel = authViewModel else {
//            print("❌ authViewModel이 nil입니다. 로그인 실패.")
//            return
//        }
//        //        let loggedInUser = MockData.loggedInUser
//        //        authViewModel.logIn(userID: loggedInUser.id)
//        
//        // MainTabBarController 생성
//        let tabBarController = MainTabBarController(
//            authViewModel: authViewModel,
//            chatListViewModel: ChatListViewModel()
//        )
//        
//        // 애니메이션 추가
//        guard let windowScene = UIApplication.shared.connectedScenes
//            .first(where: { $0.activationState == .foregroundActive }) as? UIWindowScene,
//              let window = windowScene.windows.first else {
//            print("❌ UIWindow를 찾을 수 없습니다.")
//            return
//        }
//        
//        let transition = CATransition()
//        transition.type = .moveIn // 화면이 이동하는 효과
//        transition.subtype = .fromBottom // 아래에서 위로
//        transition.duration = 0.4
//        transition.timingFunction = CAMediaTimingFunction(name: .easeInEaseOut)
//        window.layer.add(transition, forKey: kCATransition)
//        window.rootViewController = tabBarController
//        
//    }
//    // ✅ 비밀번호 찾기 라벨을 터치 가능하도록 설정
//    private func setupForgotPasswordLabel() {
//        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(forgotPasswordLabelTapped))
//        ForgetPasswordLabel.isUserInteractionEnabled = true // ✅ 반드시 필요함
//        ForgetPasswordLabel.addGestureRecognizer(tapGesture)
//    }
//    
//    // ✅ 비밀번호 찾기 라벨 탭 이벤트
//    @objc private func forgotPasswordLabelTapped() {
//        print("🔑 비밀번호 찾기 라벨 클릭됨")
//        
//        let passwordResetView = PasswordResetView()
//        let hostingController = UIHostingController(rootView: passwordResetView)
//        
//        if let navigationController = self.navigationController {
//            navigationController.pushViewController(hostingController, animated: true)
//        } else {
//            print("❌ Navigation controller가 없습니다.")
//        }
//    }
//    
//    @IBAction func registerButtonDidTap(_ sender: UIButton) {
//
//        // SwiftUI 코드
//        print("Register 버튼 클릭됨")
//        
//        // RegisterView를 UIHostingController로 래핑
//        let registerView = SignUpRegisterView()
//            .environmentObject(RegisterViewModel()) // RegisterViewModel 전달
//        let hostingController = UIHostingController(rootView: registerView)
//        
//        // 네비게이션 스택에 푸시
//        if let navigationController = self.navigationController {
//            navigationController.pushViewController(hostingController, animated: true)
//        } else {
//            print("❌ Navigation controller가 없습니다.")
//        }
//        
//        
//    }
//    
//    // MARK: 알림 메시지
//    private func showAlert(message: String) {
//        let alert = UIAlertController(title: "알림", message: message, preferredStyle: .alert)
//        alert.addAction(UIAlertAction(title: "확인", style: .default))
//        present(alert, animated: true)
//    }
//    
//}
