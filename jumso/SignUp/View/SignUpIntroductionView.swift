import SwiftUI

struct SignUpIntroductionView: View {
    @EnvironmentObject var registerViewModel: RegisterViewModel
    // MARK: - 상태 변수
    @State private var isButtonEnabled: Bool = false
    @State private var navigateToNextView: Bool = false
    @State private var keyboardHeight: CGFloat = 0
    @StateObject private var keyboardManager = KeyboardManager.shared
    
    @State private var title: String = "" // 제목 입력
    @State private var introduction: String = "" // 자기소개 내용 입력
    
    // ProgressBar 상태
    private let totalSignUpSteps = 8
    private let currentSignUpStep = 6
    
    var body: some View {
        ZStack(alignment: .bottom) {
            VStack(spacing: 0) {
                // ✅ Progress Bar
                ProgressView(value: Float(currentSignUpStep) / Float(totalSignUpSteps))
                    .progressViewStyle(LinearProgressViewStyle(tint: .blue))
                    .padding(.top, 30)
                    .padding(.horizontal, 16)
                    .padding(.bottom, 30)
                
                GeometryReader { geometry in
                    VStack(alignment: .leading, spacing: 20){
                        // ✅ Header
                        SignUpHeaderView(title: "자기소개를 해주세요.")
                        
                        // TODO: 키보드 올라오면 progressBar와 겹치는 문제 해결 필요
                        
                        // ✅ 테이블뷰 유사 구조
                        VStack(alignment: .leading, spacing: 16) {
                            if introduction.isEmpty{
                                Text("당신의 매력을 자유롭게 표현해보세요! 다른 사람에게 보여질 프로필에 포함됩니다.")
                                    .font(.subheadline)
                                    .foregroundColor(.gray)
                                    .padding(.horizontal, 16)
                            }
                            Divider()
                            // 제목 입력란
                            Text("나를 한마디로 표현한다면?")
                                .font(.headline)
                                .foregroundColor(.black)
                                .padding(.horizontal, 16)
                            
                            TextField("", text: $title)
                                .textFieldStyle(RoundedBorderTextFieldStyle())
                                .padding(.horizontal, 16)
                                .animation(.easeInOut, value: title)
                            
                            // ✅ 사용자 피드백 (제목 입력란 아래)
                            if title.isEmpty {
                                Text("제목을 입력해주세요.")
                                    .font(.caption)
                                    .foregroundColor(.red)
                                    .padding(.horizontal, 16)
                            }
                            
                            // 자기소개 텍스트 에디터
                            Text("자기소개")
                                .font(.headline)
                                .foregroundColor(.black)
                                .padding(.horizontal, 16)
                            
                            TextEditor(text: $introduction)
                                .frame(height: geometry.size.height * 0.3)
                                .cornerRadius(8)
                                .overlay(RoundedRectangle(cornerRadius: 8)
                                    .stroke(Color.gray.opacity(0.3), lineWidth: 1))
                                .padding(.horizontal, 16)
                            
                            Text("\(introduction.count)/200")
                                .font(.caption)
                                .foregroundColor(introduction.count > 200 ? .red : .gray)
                                .frame(maxWidth: .infinity, alignment: .trailing)
                                .padding(.horizontal, 16)
                            
                            if introduction.count > 200 {
                                Text("최대 200자까지만 입력 가능합니다.")
                                    .font(.caption)
                                    .foregroundColor(.red)
                                    .padding(.horizontal, 16)
                            } else if introduction.count < 30 && !introduction.isEmpty {
                                Text("자기소개는 최소 30자 이상 작성해주세요.")
                                    .font(.caption)
                                    .foregroundColor(.orange)
                                    .padding(.horizontal, 16)
                            } else if !introduction.isEmpty {
                                Text("멋진 자기소개예요!")
                                    .font(.caption)
                                    .foregroundColor(.green)
                                    .padding(.horizontal, 16)
                            }
                        }
                        .padding(.top, 20)
                        .padding(.bottom, 20)
                        .background(
                            LinearGradient(gradient: Gradient(colors: [Color.jumso.opacity(0.1), Color.white]), startPoint: .top, endPoint: .bottom)
                        )
                        .cornerRadius(12)
                        
                        
                        Spacer()
                        
                    } // VStack end
                    
                    .frame(width: geometry.size.width, height: geometry.size.height)
                    
                } // GeometryReader end
                .padding(.bottom, 100)
                .background(Color.white)
                
            }
            VStack {
                Spacer()
                SignUpReusableButton(title: "다음", isEnabled: isButtonEnabled) {
                    registerViewModel.profileData["Title"] = title
                    registerViewModel.profileData["Introduction"] = introduction
                    registerViewModel.navigationPath.append("PreferenceStep")
                }
                .disabled(!isButtonEnabled)
                .padding(.bottom, keyboardManager.keyboardHeight > 0 ? 10 : UIScreen.main.bounds.height / 30)
                .animation(.easeOut(duration: 0.3), value: keyboardManager.keyboardHeight)
                
            }
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarBackButtonHidden(true)
            
            
        } // 가장 바깥쪽 Vstack
        .onTapGesture {
            keyboardManager.hideKeyboard()
        }
        .onChange(of: title) { _ in
            isButtonEnabled = isFormValid()
        }
        .onChange(of: introduction) { _ in
            isButtonEnabled = isFormValid()
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
    
    // MARK: - 유효성 검사
    private func isFormValid() -> Bool {
        return !title.isEmpty && !introduction.isEmpty
    }
    
}



//struct SignUpIntroductionView_Previews: PreviewProvider {
//    static var previews: some View {
//        SignUpIntroductionView()
//    }
//}

