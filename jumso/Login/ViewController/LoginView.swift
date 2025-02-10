import SwiftUI
import Alamofire

// ✅ 전역적으로 세션을 유지하는 Singleton 클래스
class APIManager {
    static let shared = APIManager()
    
    let session: Session
    
    private init() {
        session = Session(eventMonitors: [AFEventLogger()])
    }
}

private let USE_LOCAL_LOGIN = true

struct LoginView: View {
    @EnvironmentObject var authViewModel: AuthViewModel
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var isLoading: Bool = false
    @State private var errorMessage: String? = nil
    @FocusState private var focusedField: Field?
    @State private var showAlert: Bool = false // 🚨 SwiftUI Alert 상태 추가
    @ObservedObject var deviceSizeManager = DeviceSizeManager.shared
    
    enum Field {
        case email, password
    }
    
    var body: some View {
        NavigationView {
            ZStack {
                Color(.loginBG)
                    .ignoresSafeArea()
                
                VStack(spacing: deviceSizeManager.scaledPadding(20)) {
                    
                    // MARK: - 상단 배경 이미지 (jumso2)
                    Image("jumso2")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 261.33 * deviceSizeManager.widthScale(),
                               height: 139.33 * deviceSizeManager.heightScale())
                        .padding(.bottom, deviceSizeManager.scaledPadding(81))
                    
                    // MARK: - 이메일 입력 필드
                    TextField("이메일을 입력하세요", text: $email)
                        .textInputAutocapitalization(.none)
                        .keyboardType(.emailAddress)
                        .padding() // 내부 패딩
                        .background(Color(.systemGray6))
                        .cornerRadius(10)
                        .focused($focusedField, equals: .email)
                        .submitLabel(.next)
                        .onSubmit { focusedField = .password }
                    // 좌우 간격: 기준 iPhone14에서 10pt, 기기별 스케일 적용
                        .padding(.horizontal, deviceSizeManager.scaledPadding(10))
                    
                    // MARK: - 비밀번호 입력 필드
                    SecureField("비밀번호를 입력하세요", text: $password)
                        .padding()
                        .background(Color(.systemGray6))
                        .cornerRadius(10)
                        .focused($focusedField, equals: .password)
                        .submitLabel(.go)
                        .onSubmit { login() }
                        .padding(.horizontal, deviceSizeManager.scaledPadding(10))
                    
                    // MARK: - 비밀번호 찾기 버튼 (우측 정렬)
                    HStack {
                        Spacer()
                        NavigationLink(destination: PasswordResetView()) {
                            Text("비밀번호 찾기")
                                .font(.system(size: deviceSizeManager.scaledFont(size: 12), weight: .bold))
                                .foregroundColor(Color("disabledButtonColor"))
                        }
                    }
                    .padding(.horizontal, deviceSizeManager.scaledPadding(10))
                    .padding(.bottom, deviceSizeManager.scaledPadding(40))
                    
                    // MARK: - 로그인 버튼 (높이 기준 iPhone14 45pt)
                    Button(action: login) {
                        if isLoading {
                            ProgressView()
                                .progressViewStyle(CircularProgressViewStyle(tint: .white))
                                .frame(height: deviceSizeManager.scaledHeight(45))
                                .frame(maxWidth: .infinity)
                        } else {
                            Text("로그인")
                                .font(.headline)
                                .frame(maxWidth: .infinity)
                                .frame(height: deviceSizeManager.scaledHeight(45))
                                .background(.disabledButton)
                                .foregroundColor(.white)
                                .cornerRadius(10)
                        }
                    }
                    .padding(.horizontal, deviceSizeManager.scaledPadding(10))
                    .disabled(isLoading || email.isEmpty || password.isEmpty)
                    
                    Spacer()
                    
                    // MARK: - 회원가입 구간
                    VStack(spacing: deviceSizeManager.scaledPadding(30)) {
                        // 좌우에 선이 있는 안내 라벨
                        HStack {
                            Rectangle()
                                .frame(height: 1)
                                .foregroundColor(.gray)
                                
                            Text("계정이 아직 없으시다면?")
                                .font(.system(size: deviceSizeManager.scaledFont(size: 12), weight: .semibold))
                                .foregroundColor(.gray)
                                .lineLimit(1)               // 한 줄로 제한
                                .fixedSize(horizontal: true, vertical: false) // 텍스트가 축소되지 않도록 고정
                            Rectangle()
                                .frame(height: 1)
                                .foregroundColor(.gray)
                            
                        }
                        .padding(.horizontal, deviceSizeManager.scaledPadding(25))
                        
                        // 회원가입 버튼 (Filled 스타일)
                        NavigationLink(destination: SignUpRegisterView().environmentObject(RegisterViewModel())) {
                            Text("회사메일로 계정만들기")
                                .font(.headline)
                                .frame(width: 200 * deviceSizeManager.widthScale(),
                                       height: 10 * deviceSizeManager.heightScale())
                                .padding()
                            
                                .background(.jumso)
                                .foregroundColor(.white)
                                .cornerRadius(10)
                        }
                        .padding(.horizontal, deviceSizeManager.scaledPadding(10))
                    }
                    .padding(.bottom, deviceSizeManager.scaledPadding(35))
                }
            }
            .alert(isPresented: $showAlert) {
                Alert(title: Text("알림"),
                      message: Text(errorMessage ?? ""),
                      dismissButton: .default(Text("확인")))
            }
            .navigationBarHidden(true)
        }
    }
    
    // ✅ 로그인 처리 (로컬/실제 API 선택)
    private func login() {
        guard !email.isEmpty, !password.isEmpty else { return }
        isLoading = true
        errorMessage = nil
        
        if USE_LOCAL_LOGIN {
            mockLoginRequest() // 🚨 로컬 로그인 처리
        } else {
            requestLoginAPI() // 🚨 실제 API 요청
        }
    }
    
    // ✅ 로컬 로그인 Mock 요청 (임시 로그인 가능)
    private func mockLoginRequest() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) { // 🚀 1초 후 응답 시뮬레이션
            if email == "test" && password == "test" {
                print("✅ [Mock] 로그인 성공")
                authViewModel.isLoggedIn = true
                handleLocalLoginSuccess()
            } else {
                errorMessage = "이메일 또는 비밀번호가 잘못되었습니다."
                showAlert = true
            }
            isLoading = false
        }
    }
    
    // ✅ 로그인 성공 시 MainTabBarController로 전환 (로컬 로그인)
    private func handleLocalLoginSuccess() {
        if let sceneDelegate = UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate,
           let window = sceneDelegate.window {
            
            let tabBarController = MainTabBarController(
                authViewModel: authViewModel,
                chatListViewModel: ChatListViewModel()
            )
            
            let transition = CATransition()
            transition.type = .moveIn
            transition.subtype = .fromBottom
            transition.duration = 0.4
            transition.timingFunction = CAMediaTimingFunction(name: .easeInEaseOut)
            
            window.layer.add(transition, forKey: kCATransition)
            window.rootViewController = tabBarController
        }
    }
    
    // ✅ 로그인 처리
    private func requestLoginAPI() {
        guard !email.isEmpty, !password.isEmpty else { return }
        isLoading = true
        errorMessage = nil
        
        let url = "https://api.jumso.life/api/auth/signin"
        let loginRequest = LoginRequest(email: email, password: password)
        let headers: HTTPHeaders = ["Content-Type": "application/json"]
        
        APIManager.shared.session.request(url, method: .post, parameters: loginRequest, encoder: JSONParameterEncoder.default, headers: headers)
            .validate(statusCode: 200..<300)
            .responseDecodable(of: LoginResponse.self) { response in
                DispatchQueue.main.async {
                    isLoading = false
                    switch response.result {
                    case .success(let loginResponse):
                        print("✅ 로그인 성공")
                        authViewModel.isLoggedIn = true
                        handleLoginSuccess(response: response)
                        
                    case .failure:
                        errorMessage = "이메일 또는 비밀번호가 잘못되었습니다."
                        showAlert = true // 🚨 Alert 표시
                    }
                }
            }
    }
    
    // ✅ 로그인 성공 시 MainTabBarController로 전환
    private func handleLoginSuccess(response: AFDataResponse<LoginResponse>) {
        if let httpResponse = response.response,
           let accessToken = httpResponse.headers.value(for: "Authorization"),
           let refreshToken = httpResponse.headers.value(for: "AuthorizationRefresh") {
            
            // ✅ Access Token 및 Refresh Token 저장
            UserDefaults.standard.set(accessToken, forKey: "AccessToken")
            UserDefaults.standard.set(refreshToken, forKey: "RefreshToken")
        }
        
        // ✅ MainTabBarController로 이동 (애니메이션 포함)
        if let sceneDelegate = UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate,
           let window = sceneDelegate.window {
            
            let tabBarController = MainTabBarController(
                authViewModel: authViewModel,
                chatListViewModel: ChatListViewModel()
            )
            
            let transition = CATransition()
            transition.type = .moveIn
            transition.subtype = .fromBottom
            transition.duration = 0.4
            transition.timingFunction = CAMediaTimingFunction(name: .easeInEaseOut)
            
            window.layer.add(transition, forKey: kCATransition)
            window.rootViewController = tabBarController
        }
    }
}

// ✅ Preview
struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView().environmentObject(AuthViewModel())
    }
}
