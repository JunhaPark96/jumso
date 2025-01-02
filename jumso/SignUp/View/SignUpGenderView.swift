import SwiftUI

struct SignUpGenderView: View {
    // MARK: - 상태 변수
    @State private var selectedGender: Gender? = nil
    @State private var isButtonEnabled: Bool = false
    
    @State private var navigateToNextView: Bool = false
    @State private var keyboardHeight: CGFloat = 0
    @StateObject private var keyboardManager = KeyboardManager.shared
    
    // ProgressBar 상태
    private let totalSignUpSteps = 8
    private let currentSignUpStep = 3
    
    var body: some View {
        NavigationStack {
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
                                Text("성별은 무엇인가요?")
                                    .font(.title)
                                    .fontWeight(.bold)
                                
                                // 성별 선택 버튼
                                HStack(spacing: 20) {
                                    GenderButton(
                                        title: "남성",
                                        isSelected: selectedGender == .male
                                    ) {
                                        selectedGender = .male
                                        validateGender()
                                    }
                                    
                                    GenderButton(
                                        title: "여성",
                                        isSelected: selectedGender == .female
                                    ) {
                                        selectedGender = .female
                                        validateGender()
                                    }
                                }
                                .padding(.top, 20)
                                
                            }
                            
                            .padding(.horizontal)
                            .padding(.top, 50)
                            
                            Spacer()
                        }
                        .ignoresSafeArea(.keyboard)
                        
                        
                        VStack {
                            Spacer()
                            SignUpReusableButton(title: "다음", isEnabled: isButtonEnabled) {
                                handleNextButtonTap()
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
                    SignUpGenderView()
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
    }
    
    // MARK: - 유효성 검사
    private func validateGender() {
        isButtonEnabled = selectedGender != nil
    }
    // MARK: - 버튼 동작
    private func handleNextButtonTap() {
        navigateToNextView = true
    }
}

// MARK: - Gender Enum
enum Gender {
    case male, female
}

// MARK: - GenderButton Component
struct GenderButton: View {
    var title: String
    var isSelected: Bool
    var action: () -> Void
    
    var body: some View {
        Button(action: action) {
            Text(title)
                .font(.headline)
                .foregroundColor(isSelected ? .white : .black)
                .frame(maxWidth: .infinity, minHeight: 50)
                .background(isSelected ? Color.blue : Color.clear)
                .cornerRadius(8)
                .overlay(
                    RoundedRectangle(cornerRadius: 8)
                        .stroke(Color.black, lineWidth: isSelected ? 0 : 1)
                )
                .shadow(color: isSelected ? .gray.opacity(0.3) : .clear, radius: 3, x: 0, y: 3)
        }
    }
}


struct SignUpGenderView_Previews: PreviewProvider {
    static var previews: some View {
        SignUpGenderView()
    }
}
