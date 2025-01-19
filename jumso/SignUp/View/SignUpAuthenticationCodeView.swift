import SwiftUI
import Combine

struct SignUpAuthenticationCodeView: View {
    @EnvironmentObject var registerViewModel: RegisterViewModel // 중앙 데이터 관리
    @State private var authenticationCodeInput: String = ""
    
    @State private var isButtonEnabled: Bool = false
    @State private var keyboardHeight: CGFloat = 0
    @State private var navigateToPasswordView: Bool = false
    @StateObject private var keyboardManager = KeyboardManager.shared
    let tempAuthenticationCode: String = "123456" // 임시 인증코드

    // 버튼의 기본 위치
    private let defaultBottomPadding: CGFloat = 170

    var body: some View {
            ZStack(alignment: .bottom) {
                // 메인 콘텐츠 영역
                VStack(alignment: .leading, spacing: 25) {
                    // 이메일 주소 라벨
                    Text(registerViewModel.fullEmailAddress)
                        .font(.headline)
                        .frame(maxWidth: .infinity, alignment: .leading) // 좌측 정렬
                        .padding(.horizontal)
                        .padding(.top, 30)
                    
                    // 인증 코드 입력 필드
                    VStack(alignment: .leading, spacing: 10) {
                        TextField("인증코드를 입력하세요", text: $authenticationCodeInput)
                            .textInputAutocapitalization(.never) // 자동 대문자화 비활성화
                            .padding(.vertical, 10)
                            .padding(.horizontal)
                            .background(Color(.systemGray6))
                            .cornerRadius(10)
                            .onChange(of: authenticationCodeInput) { value in
                                isButtonEnabled = !value.isEmpty
                            }
                        
                        // 줄선
                        Divider()
                            .background(Color.black)
                            .padding(.top, 5)
                        
                        // 안내 텍스트
                        Text("이메일은 인증에만 사용되며, 그 외의 용도로는 사용되지 않습니다.")
                            .font(.footnote)
                            .foregroundColor(.gray)
                            .padding(.top, 10)
                    }
                    .padding(.horizontal)
                    
                    if !registerViewModel.isCodeMatched {
                        Text("인증 번호가 일치하지 않습니다.")
                            .foregroundColor(.red)
                            .font(.footnote)
                            .padding(.horizontal)
                    }
                    
                    Spacer() // 콘텐츠와 버튼 간격 확보
                }
                .onAppear {
                    print("📍 [DEBUG] SignUpAuthenticationCodeView appeared")
                }
                
                
                // 인증 버튼 영역
                //                SignUpReusableButton(title: "인증 확인", isEnabled: isButtonEnabled) {
                //                    handleButtonTap()
                //                }
                SignUpReusableButton(title: registerViewModel.isVerifying ? "인증 중..." : "인증 확인", isEnabled: isButtonEnabled && !registerViewModel.isVerifying) {
                    handleVerifyCode()
                }
                //                .relativeButtonPosition(relativeHeight: 0.7, keyboardHeight: keyboardManager.keyboardHeight)
                //                .background(Color.white)
                //                .padding(.top, max(50, min(120, keyboardHeight > 0 ? keyboardHeight - 50 : UIScreen.main.bounds.height / 6)))
                
                .padding(.top, max(100, min(120, keyboardHeight > 0 ? keyboardHeight - 50 : 100)))
                .padding(.bottom, keyboardHeight > 0 ? 10 : UIScreen.main.bounds.height / 6)
                
                .animation(.easeOut(duration: 0.3), value: keyboardHeight)
            }
            .onTapGesture {
                // 화면 다른 곳을 터치하면 키보드 숨김
                UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
            }
            .navigationTitle("이메일 인증")
            .navigationBarTitleDisplayMode(.inline)
        
        //            .background(Color.gray)
            .onAppear {
                // 키보드 관찰자 시작
                observeKeyboard()
            }
            .onDisappear {
                // 키보드 관찰자 해제
                removeKeyboardObserver()
            }
            .navigationDestination(isPresented: $navigateToPasswordView) {
                SignUpPasswordView()
            }
        
            .navigationBarBackButtonHidden(true)
    }
    
    //    private func handleButtonTap() {
    //        print("입력된 인증번호: \(authenticationCodeInput)")
    //
    //        // TODO: 서버에서 받은 인증코드와 비교
    //        if authenticationCodeInput == tempAuthenticationCode {
    //            navigateToPasswordView = true
    //        } else {
    //            print("인증번호가 일치하지 않습니다.")
    //        }
    //    }
    
    
    private func handleVerifyCode() {
        registerViewModel.verifyCode(inputCode: authenticationCodeInput) { result in
            
            switch result {
            case .success:
                print("✅ 인증 성공")
                registerViewModel.isCodeMatched = true // 인증 성공 시 상태 업데이트
                registerViewModel.navigationPath.append("PasswordStep")
            case .failure(let error):
                print("❌ 인증 실패: \(error.localizedDescription)")
                registerViewModel.isCodeMatched = false // 인증 실패 시 상태 업데이트
            }
        }
        
    }

    
    // MARK: - 키보드 관찰자
    private func observeKeyboard() {
        NotificationCenter.default.addObserver(forName: UIResponder.keyboardWillShowNotification, object: nil, queue: .main) { notification in
            if let keyboardFrame = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect {
                keyboardHeight = keyboardFrame.height
            }
        }
        
        NotificationCenter.default.addObserver(forName: UIResponder.keyboardWillHideNotification, object: nil, queue: .main) { _ in
            keyboardHeight = 0
        }
    }

    private func removeKeyboardObserver() {
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }
}


//struct SignUpAuthenticationCodeView_Previews: PreviewProvider {
//    static var previews: some View {
//        SignUpAuthenticationCodeView(fullEmailAddress: "example@example.com")
//            .previewDevice("iPhone 14 Pro")
//    }
//}
