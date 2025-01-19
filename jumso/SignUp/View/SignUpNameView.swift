import SwiftUI

struct SignUpNameView: View {
    @EnvironmentObject var registerViewModel: RegisterViewModel
    // 상태 변수
    @State private var name: String = ""
    @State private var isButtonEnabled: Bool = false
    @State private var navigateToNextView: Bool = false
    @State private var nameFieldMaxY: CGFloat = 0 // 입력 필드의 최대 Y 좌표
    @State private var keyboardHeight: CGFloat = 0
    @StateObject private var keyboardManager = KeyboardManager.shared
    
    let totalSignUpSteps = 8
    let currentSignUpStep = 1
    
    var body: some View {
            ZStack(alignment: .bottom) {
                VStack(spacing: 0) {
                    // Progress Bar
                    ProgressView(value: Float(currentSignUpStep) / Float(totalSignUpSteps))
                        .progressViewStyle(LinearProgressViewStyle(tint: .blue))
                        .padding(.top, 50)
                        .padding(.horizontal, 16)
                    
                    GeometryReader { geometry in
                        VStack(alignment: .leading, spacing: 20) {
                            VStack(alignment: .leading, spacing: 10) {
                                Text("이름 또는 닉네임을 입력해주세요")
                                    .font(.headline)
                                    .fontWeight(.bold)
                                
                                TextField("이름", text: $name)
                                    .padding()
                                    .background(Color(.systemGray6))
                                    .cornerRadius(10)
                                    .onChange(of: name) { _ in validateFields() }
                                    .background(
                                        GeometryReader { proxy in
                                            Color.clear.preference(
                                                key: ViewOffsetKey.self,
                                                value: proxy.frame(in: .global).maxY
                                            )
                                        }
                                    )
                                
                                Text("프로필에 보이는 이름입니다.")
                                    .font(.footnote)
                                    .foregroundColor(.gray)
                                    .padding(.top, 10)
                            }
                            .padding(.horizontal)
                            .padding(.top, 50)
                            
                            Spacer()
                        }
                        .ignoresSafeArea(.keyboard)
                        
                        
                        VStack {
                            Spacer()
//                            SignUpReusableButton(title: "다음", isEnabled: isButtonEnabled) {
//                                handleNextButtonTap()
//                            }
                            SignUpReusableButton(title: "다음", isEnabled: isButtonEnabled) {
                                registerViewModel.name = name
                                registerViewModel.navigationPath.append("BirthDayStep") // 다음 뷰 전환
                            }
                            .disabled(!isButtonEnabled)
                            .padding(.bottom, keyboardManager.keyboardHeight > 0 ? 10 : UIScreen.main.bounds.height / 4) // 키보드 위 10pt
                            .animation(.easeOut(duration: 0.3), value: keyboardManager.keyboardHeight)
                            
                        }
                    }
                    
                }
                .navigationBarTitleDisplayMode(.inline)
                .navigationBarBackButtonHidden(true)
                .navigationDestination(isPresented: $navigateToNextView) {
                    SignUpBirthDayView()
                }
                
            } // 가장 바깥쪽 Vstack
            .onTapGesture {
                keyboardManager.hideKeyboard()
            }
            
            .onAppear {
                // 키보드 관찰자 시작
                KeyboardObserver.shared.startListening { height in
                    SignUpDebugLog.debugLog("키보드 높이 업데이트: \(height)")
                    //                    print("키보드 높이 업데이트: \(height)")
                    withAnimation(.easeOut(duration: 0.3)){
                        keyboardHeight = height
                    }
                }
            }
            
            .onDisappear {
                // 키보드 관찰자 해제
                KeyboardObserver.shared.stopListening()
            }
        }
    
    // 필드 검증
    private func validateFields() {
        isButtonEnabled = !name.isEmpty
    }
    
    // 버튼 동작
    private func handleNextButtonTap() {
        navigateToNextView = true
    }
    
}

// MARK: - 미리보기
//struct SignUpNameView_Previews: PreviewProvider {
//    static var previews: some View {
//        SignUpNameView()
//    }
//}
