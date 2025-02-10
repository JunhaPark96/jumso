import SwiftUI

struct PasswordResetView: View {
    @State private var email: String = ""
    @State private var verificationCode: String = ""
    @State private var isButtonEnabled: Bool = false
    @State private var isVerificationViewVisible: Bool = false
    @State private var keyboardHeight: CGFloat = 0
    @StateObject private var keyboardManager = KeyboardManager.shared
    
    var body: some View {
        GeometryReader { geometry in
            ZStack(alignment: .bottom) {
                VStack(spacing: 0) {
                    // ✅ 타이틀 및 설명
                    VStack(alignment: .leading, spacing: 10) {
                        Text("비밀번호 재설정")
                            .font(.largeTitle)
                            .fontWeight(.bold)
                        
                        Text("이메일로 비밀번호 재설정 코드를 전송해드립니다.")
                            .font(.body)
                            .foregroundColor(.gray)
                    }
                    .padding(.top, 50)
                    .padding(.horizontal)

                    // ✅ 이메일 입력 영역
                    VStack(alignment: .leading, spacing: 15) {
                        HStack {
                            Image(systemName: "envelope.fill")
                                .foregroundColor(.gray)
                            
                            TextField("id@example.com", text: $email)
                                .textInputAutocapitalization(.never)
                                .keyboardType(.emailAddress)
                                .padding()
                                .background(Color(.systemGray6))
                                .cornerRadius(10)
                                .onChange(of: email) { _ in validateEmail() }
                        }
                        .padding(.horizontal)

                        // ✅ 전송 버튼
                        SignUpReusableButton(title: "전송", isEnabled: isButtonEnabled) {
                            handleSendVerificationCode()
                        }
                        .disabled(!isButtonEnabled)
                        .padding(.horizontal)
                    }
                    .padding(.top, 30)

                    // ✅ 인증 코드 입력 필드 (전송 버튼 클릭 후 표시됨)
                    if isVerificationViewVisible {
                        VStack(alignment: .leading, spacing: 15) {
                            TextField("인증 코드를 입력하세요", text: $verificationCode)
                                .textInputAutocapitalization(.never)
                                .padding()
                                .background(Color(.systemGray6))
                                .cornerRadius(10)
                                .padding(.horizontal)

                            Divider()
                                .background(Color.black)
                                .padding(.horizontal)

                            Text("3분 내 입력을 완료해 주세요.")
                                .font(.footnote)
                                .foregroundColor(.gray)
                                .padding(.horizontal)

                            // ✅ 인증 완료 버튼
                            SignUpReusableButton(title: "인증 완료", isEnabled: !verificationCode.isEmpty) {
                                handleVerifyCode()
                            }
                            .padding(.horizontal)
                        }
                        .transition(.opacity)
                        .padding(.top, 20)
                    }

                    Spacer()
                }
                .onTapGesture {
                    keyboardManager.hideKeyboard()
                }
                
                // ✅ 키보드 대응
                .onAppear {
                    KeyboardObserver.shared.startListening { height in
                        withAnimation(.easeOut(duration: 0.3)) {
                            keyboardHeight = height
                        }
                    }
                }
                
                .onDisappear {
                    KeyboardObserver.shared.stopListening()
                }
            }
        }
        .navigationTitle("비밀번호 재설정")
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarBackButtonHidden(true)
    }
    
    // MARK: - 이메일 입력 유효성 검사
    private func validateEmail() {
        isButtonEnabled = email.contains("@") && email.contains(".")
    }
    
    // MARK: - 이메일 인증 코드 요청
    private func handleSendVerificationCode() {
        print("📧 [DEBUG] 인증 코드 전송 요청: \(email)")
        isVerificationViewVisible = true
    }
    
    // MARK: - 인증 코드 확인
    private func handleVerifyCode() {
        print("🔑 [DEBUG] 인증 코드 확인: \(verificationCode)")
    }
}
