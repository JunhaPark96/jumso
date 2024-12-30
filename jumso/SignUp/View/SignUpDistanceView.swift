import SwiftUI

struct SignUpDistanceView: View {
    // MARK: - 상태 변수
    @State private var isButtonEnabled: Bool = true
    @State private var navigateToNextView: Bool = false
    @State private var keyboardHeight: CGFloat = 0
    @StateObject private var keyboardManager = KeyboardManager.shared
    
    @State private var distance: Float = 0 // 거리 값
    
    // ProgressBar 상태
    private let totalSignUpSteps = 8
    private let currentSignUpStep = 6
    
    var body: some View {
        NavigationStack {
            ZStack(alignment: .bottom) {
                VStack(spacing: 0) {
                    // ✅ Progress Bar
                    ProgressView(value: Float(currentSignUpStep) / Float(totalSignUpSteps))
                        .progressViewStyle(LinearProgressViewStyle(tint: .blue))
                        .padding(.top, 30)
                        .padding(.horizontal, 16)
                    
                    GeometryReader { geometry in
                        VStack(alignment: .leading, spacing: 20){
                            // ✅ Header
                            SignUpHeaderView(title: "내가 원하는 상대와의 거리")
                            
                            
                            // ✅ 설명 텍스트
                            Text("슬라이더를 움직여 상대와의 최대 거리를 원하는 대로 설정해보세요.")
                                .font(.subheadline)
                                .foregroundColor(.gray)
                                .padding(.horizontal, 16)
                            
                            HStack {
                                // ✅ 설명 텍스트
                                Text("상대와의 거리")
                                    .font(.subheadline)
                                    .foregroundColor(.black)
                                Spacer()
                                // ✅ 슬라이더 값 라벨
                                Text("\(Int(distance)) km")
                                    .font(.subheadline)
                                    .foregroundColor(.black)
                            }
                            .padding(.top, 70)
                            .padding(.bottom, 10)
                            .padding(.horizontal, 16)
                            // ✅ 거리 슬라이더
                            Slider(
                                value: $distance,
                                in: 0...127,
                                step: 1
                            )
                            .accentColor(.blue)
                            .padding(.horizontal, 16)
                            
                            Spacer()
                        } // VStack end
                        
                    } // GeometryReader end
                    
                    
                }
                VStack {
                    Spacer()
                    SignUpReusableButton(title: "다음", isEnabled: isButtonEnabled) {
                        handleNextButtonTap()
                    }
                    .disabled(!isButtonEnabled)
                    .padding(.bottom, keyboardManager.keyboardHeight > 0 ? 10 : UIScreen.main.bounds.height / 30)
                    .animation(.easeOut(duration: 0.3), value: keyboardManager.keyboardHeight)
                    
                }
                .navigationBarTitleDisplayMode(.inline)
                .navigationBarBackButtonHidden(true)
                .navigationDestination(isPresented: $navigateToNextView) {
                    SignUpLocationView()
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
    
    
    // MARK: - 버튼 동작
    private func handleNextButtonTap() {
        navigateToNextView = true
    }
    
}



struct SignUpDistanceView_Previews: PreviewProvider {
    static var previews: some View {
        SignUpDistanceView()
    }
}
