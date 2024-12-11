import SwiftUI

struct SignUpAuthenticationCodeView: View {
    let fullEmailAddress: String
    @State private var authenticationCodeInput: String = ""
    @State private var isButtonEnabled: Bool = false
    @State private var keyboardHeight: CGFloat = 0
    @State private var navigateToPasswordView: Bool = false
    let tempAuthenticationCode: String = "q" // 임시 인증코드

    var body: some View {
        NavigationStack {
            ZStack(alignment: .bottom) {
                // 메인 콘텐츠 영역
                VStack(alignment: .leading, spacing: 25) {
                    // 이메일 주소 라벨
                    Text(fullEmailAddress)
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
                    
                    Spacer() // 콘텐츠와 버튼 간격 확보
                }
                .background(Color.yellow)
                
                // 인증 버튼 영역
                VStack {
                    Button(action: handleButtonTap) {
                        Text("인증 확인")
                            .bold()
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(isButtonEnabled ? Color.blue : Color.gray)
                            .foregroundColor(.white)
                            .cornerRadius(10)
                            .padding(.horizontal)
                    }
                    .disabled(!isButtonEnabled)
                }
                .background(Color.white) // 버튼 영역만 별도 배경
                .offset(y: keyboardHeight > 0 ? -keyboardHeight + 10 : 0) // 키보드 위로 이동
                .animation(.easeOut(duration: 0.3), value: keyboardHeight)
                .padding(.bottom, 170) // 화면 하단과 버튼 간 기본 간격
            }
            .onTapGesture {
                // 화면 다른 곳을 터치하면 키보드 숨김
                UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
            }
            .navigationTitle("이메일 인증")
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarBackButtonHidden(true)
            .onAppear {
                // 키보드 관찰자 시작
                SwiftUIKeyboardObserver.shared.startListening { height in
                    print("키보드 높이 업데이트: \(height)")
                    keyboardHeight = height
                }
            }
            .onDisappear {
                // 키보드 관찰자 해제
                SwiftUIKeyboardObserver.shared.stopListening()
            }
            .navigationDestination(isPresented: $navigateToPasswordView) {
                // SignUpPasswordView()
            }
        }
    }

    private func handleButtonTap() {
        print("입력된 인증번호: \(authenticationCodeInput)")
        
        // TODO: 서버에서 받은 인증코드와 비교
        if authenticationCodeInput == tempAuthenticationCode {
            navigateToPasswordView = true
        } else {
            print("인증번호가 일치하지 않습니다.")
        }
    }
}


//struct SignUpAuthenticationCodeView_Previews: PreviewProvider {
//    static var previews: some View {
//        Group {
//            // 기본 상태
//            SignUpAuthenticationCodeView(
//                fullEmailAddress: "example@example.com"
//            )
//            
//            // 키보드가 올라온 상태
//            SignUpAuthenticationCodeView(
//                fullEmailAddress: "example@example.com"
//            )
//            .previewDisplayName("Keyboard Visible")
//            .environment(\.keyboardHeight, 291) // 키보드 높이를 강제로 설정
//        }
//    }
//}
//
//// 키보드 높이를 SwiftUI 환경 변수로 확장
//private struct KeyboardHeightKey: EnvironmentKey {
//    static let defaultValue: CGFloat = 0
//}
//
//extension EnvironmentValues {
//    var keyboardHeight: CGFloat {
//        get { self[KeyboardHeightKey.self] }
//        set { self[KeyboardHeightKey.self] = newValue }
//    }
//}
