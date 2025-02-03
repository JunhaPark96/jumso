import SwiftUI

struct SignUpCompleteView: View {
    // ProgressBar 상태
    private let currentSignUpStep = SignUpStep.allCases.firstIndex(of: .preference) ?? 0
    
    var body: some View {
        // ✅ Progress Bar
        ProgressView(value: Float(currentSignUpStep) / Float(SignUpStep.allCases.count))
            .progressViewStyle(LinearProgressViewStyle(tint: .blue))
            .padding(.top, 30)
            .padding(.horizontal, 16)
        VStack {
            Text("🎉 회원가입이 완료되었습니다!")
                .font(.title)
                .padding()
            Text("이제 로그인을 진행해주세요.")
                            .padding()
            Button(action: {
                navigateToLogin()
            }) {
                Text("로그인 화면으로 이동")
                    .font(.title2)
                    .foregroundColor(.white)
                    .padding()
                    .background(Color.blue)
                    .cornerRadius(10)
            }
            .buttonStyle(.borderedProminent)
        }
    }

    private func navigateToLogin() {
        guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
              let window = windowScene.windows.first else { return }

        let loginVC = LoginViewController()
        let navController = UINavigationController(rootViewController: loginVC)
        window.rootViewController = navController
        window.makeKeyAndVisible()
    }
}
