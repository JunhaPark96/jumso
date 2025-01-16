import SwiftUI
import Combine

struct SignUpPasswordView: View {
    @EnvironmentObject var registerViewModel: RegisterViewModel
    
    @State private var password: String = ""
    @State private var confirmPassword: String = ""
    @State private var isPasswordMatched: Bool = true
    @State private var isButtonEnabled: Bool = false
    //    @State private var navigateToNextView: Bool = false
    
    @StateObject private var keyboardManager = KeyboardManager.shared
    
    var body: some View {
        GeometryReader { geometry in
            ZStack(alignment: .bottom) {
                VStack(alignment: .leading, spacing: 20) {
                    // 비밀번호 입력 필드
                    VStack(alignment: .leading, spacing: 10) {
                        Text("비밀번호")
                            .font(.headline)
                        SecureField("비밀번호를 입력하세요", text: $password)
                            .padding()
                            .background(Color(.systemGray6))
                            .cornerRadius(10)
                            .onChange(of: password) { _ in
                                validateFields()
                            }
                        
                        Text("비밀번호 확인")
                            .font(.headline)
                        SecureField("비밀번호를 다시 입력하세요", text: $confirmPassword)
                            .padding()
                            .background(Color(.systemGray6))
                            .cornerRadius(10)
                            .onChange(of: confirmPassword) { _ in
                                validateFields()
                            }
                    }
                    .padding(.top, 50)
                    .onPreferenceChange(ViewOffsetKey.self) { value in
                        passwordFieldMaxY = value
                    }
                    .padding(.horizontal)
                    // 위치 측정을 위해 ID 추가
                    .background(GeometryReader { proxy in
                        Color.clear.preference(key: ViewOffsetKey.self, value: proxy.frame(in: .global).maxY)
                    })
                    
                    if !isPasswordMatched {
                        Text("비밀번호가 일치하지 않습니다.")
                            .foregroundColor(.red)
                            .font(.footnote)
                            .padding(.horizontal)
                    }
                    
                    Spacer()
                }
                
                // 다음 버튼 영역
                SignUpReusableButton(title: "다음", isEnabled: isButtonEnabled) {
                    registerViewModel.navigationPath.append("NextStep") // 다음 뷰 전환
                }
                .disabled(!isButtonEnabled)
                //                    .padding(.bottom, calculateButtonPadding(geometry: geometry))
                .padding(.bottom, keyboardManager.keyboardHeight > 0 ? 10 : UIScreen.main.bounds.height / 4)
                .animation(.easeOut(duration: 0.3), value: keyboardManager.keyboardHeight)
            }
            .onTapGesture {
                // 화면 다른 곳 터치 시 키보드 숨김
                UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
            }
            
            
            .onPreferenceChange(ViewOffsetKey.self) { value in
                self.passwordFieldMaxY = value
            }
            
            
            .navigationTitle("비밀번호 설정")
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarBackButtonHidden(true) // Back 버튼 숨기기
        }
    }
    
    
    // MARK: - 상태 변수
    @State private var passwordFieldMaxY: CGFloat = 0
    
    // MARK: - 버튼 패딩 계산
    private func calculateButtonPadding(geometry: GeometryProxy) -> CGFloat {
        //        let screenHeight = geometry.size.height
        let keyboardHeight = keyboardManager.keyboardHeight
        let bottomSafeArea = geometry.safeAreaInsets.bottom
        
        // 화면 높이에서 키보드 높이와 Safe Area를 뺀 영역
        let availableHeight = geometry.size.height - keyboardHeight - bottomSafeArea
        
        // 비밀번호 확인 필드의 아래쪽 위치에서 버튼 높이를 뺀 값
        let maxButtonY = passwordFieldMaxY + 100 // 필드 아래 여백
        
        // 버튼이 올라갈 수 있는 최대 높이 계산
        let buttonY = availableHeight - 70 // 버튼 높이 및 여백 고려
        
        // 버튼이 필드 위로 올라가지 않도록 제한
        let padding = max(10, geometry.size.height - max(keyboardHeight + bottomSafeArea + 70, maxButtonY))
        
        return padding
    }
    
    // MARK: - 필드 검증
    private func validateFields() {
        isButtonEnabled = !password.isEmpty && !confirmPassword.isEmpty
        isPasswordMatched = password == confirmPassword || confirmPassword.isEmpty
    }
    
    // MARK: - 버튼 동작
    //    private func handleNextButtonTap() {
    //        print("입력된 비밀번호: \(password)")
    //        print("비밀번호 확인 값: \(confirmPassword)")
    //
    //        if password == confirmPassword {
    //            print("비밀번호가 일치합니다.")
    //        } else {
    //            print("비밀번호가 일치하지 않습니다.")
    //            isPasswordMatched = false
    //        }
    //    }
}

// MARK: - ViewOffsetKey 정의
struct ViewOffsetKey: PreferenceKey {
    static var defaultValue: CGFloat = 0
    static func reduce(value: inout CGFloat, nextValue: () -> CGFloat) {
        value = max(value, nextValue())
    }
}

// MARK: - Preview 추가
//struct SignUpPasswordView_Previews: PreviewProvider {
//    static var previews: some View {
//        Group {
//            SignUpPasswordView()
//                .previewDevice("iPhone 15 Pro")
//                .previewDisplayName("iPhone 15 Pro")
//
//            SignUpPasswordView()
//                .previewDevice("iPhone SE (3rd generation)")
//                .previewDisplayName("iPhone SE")
//        }
//    }
//}
