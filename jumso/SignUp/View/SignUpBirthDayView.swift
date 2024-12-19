import SwiftUI

struct SignUpBirthDayView: View {
    // MARK: - 상태 변수
    @State private var name: String = ""
    @State private var isButtonEnabled: Bool = false
    @State private var navigateToNextView: Bool = false
    
    @StateObject private var keyboardManager = KeyboardManager.shared
    
    // ProgressBar 상태
    private let totalSignUpSteps = 8
    private let currentSignUpStep = 1
    
    var body: some View {
        NavigationView {
            ZStack(alignment: .top) {
                VStack(spacing: 0) {
                    // Progress Bar 추가
                    ProgressView(value: Float(currentSignUpStep) / Float(totalSignUpSteps))
                        .progressViewStyle(LinearProgressViewStyle(tint: .blue))
                        .padding(.top, 8)
                        .padding(.horizontal, 16)
                    
                    GeometryReader { geometry in
                        ZStack(alignment: .bottom) {
                            VStack(alignment: .leading, spacing: 20) {
                                // 이름 입력 필드
                                VStack(alignment: .leading, spacing: 10) {
                                    Text("이름을 입력해주세요")
                                        .font(.headline)
                                    
                                    TextField("이름", text: $name)
                                        .padding()
                                        .background(Color(.systemGray6))
                                        .cornerRadius(10)
                                        .onChange(of: name) { _ in
                                            validateFields()
                                        }
                                }
                                .padding(.horizontal)
                                .padding(.top, 50)
                                
                                Spacer()
                            }
                            
                            // 다음 버튼
                            SignUpReusableButton(title: "다음", isEnabled: isButtonEnabled) {
                                handleNextButtonTap()
                            }
                            .disabled(!isButtonEnabled)
                            .padding(.bottom, calculateButtonPadding(geometry: geometry))
                            .animation(.easeOut(duration: 0.3), value: keyboardManager.keyboardHeight)
                        }
                        .onTapGesture {
                            hideKeyboard()
                        }
                    }
                }
            }
            .navigationTitle("이름 입력")
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarBackButtonHidden(true)
            
        }
    }
    
    // MARK: - 필드 검증
    private func validateFields() {
        isButtonEnabled = !name.isEmpty
    }
    
    // MARK: - 버튼 동작
    private func handleNextButtonTap() {
        navigateToNextView = true
    }
    
    // MARK: - 키보드 숨기기
    private func hideKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
    
    // MARK: - 버튼 패딩 계산
    private func calculateButtonPadding(geometry: GeometryProxy) -> CGFloat {
        let screenHeight = geometry.size.height
        let keyboardHeight = keyboardManager.keyboardHeight
        let bottomSafeArea = geometry.safeAreaInsets.bottom
        
        // 버튼이 화면 하단에 고정되도록 계산
        let totalPadding = keyboardHeight + bottomSafeArea + 20
        return totalPadding
    }
}

