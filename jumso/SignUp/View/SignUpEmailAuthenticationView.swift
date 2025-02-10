import SwiftUI
import Combine

struct SignUpEmailAuthenticationView: View {
//    @Binding var navigationPath: NavigationPath // 외부 NavigationPath와 바인딩
    @EnvironmentObject var registerViewModel: RegisterViewModel // 중앙 데이터 관리

//    @State private var selectedEmailDomain: String
    @State private var emailID: String = ""
    @State private var showDomainPicker: Bool = false
    @State private var keyboardHeight: CGFloat = 0
    @StateObject private var keyboardManager = KeyboardManager.shared
    
    
    var body: some View {
        ZStack {
            // 메인 컨텐츠
            VStack {
                // 상단 고정 입력 영역
                VStack(spacing: 10) {
                    TextField("이메일 아이디를 입력하세요", text: $emailID)
                        .padding()
                        .background(Color(.systemGray6))
                        .cornerRadius(10)
                        .padding(.horizontal)
                        .onChange(of: emailID) { newValue in
                            print("✏️ 이메일 아이디 입력: \(newValue)")
                        }
                    // 회사 이메일 인증 OR 개인 이메일 인증
                    if let company = registerViewModel.selectedCompany, company.emails.count > 1 {
                        Button(action: {
                            showDomainPicker = true
                        }) {
                            HStack {
                                Text("@\(registerViewModel.selectedEmailDomain)")
                                Spacer()
                                Image(systemName: "chevron.down")
                            }
                            .padding()
                            .background(Color(.systemGray6))
                            .cornerRadius(10)
                            .padding(.horizontal)
                        }
                        .sheet(isPresented: $showDomainPicker) {
                            DomainPickerView(domains: company.emails, selectedDomain: $registerViewModel.selectedEmailDomain)
                        }
                    } else {
                        HStack {
                            Text("@\(registerViewModel.selectedEmailDomain)")
                            Spacer()
                        }
                        .padding()
                        .background(Color(.systemGray6))
                        .cornerRadius(10)
                        .padding(.horizontal)
                    }
                } 
                .frame(maxWidth: .infinity, alignment: .top)
                .padding(.top, UIScreen.main.bounds.height / 6)
                
                Spacer()
            }
            .onAppear {
                print("📱 [DEBUG] SignUpEmailAuthenticationView appeared")
                debugRegisterViewModel()
            }
            // 인증 버튼 영역
            VStack {
                Spacer()
                SignUpReusableButton(title: "인증 메일 보내기", isEnabled: isButtonEnabled) {
                    handleButtonTap()
                }
                .padding(.bottom, keyboardHeight > 0 ? 10 : UIScreen.main.bounds.height / 4)
                .disabled(!isButtonEnabled)
            }
        }
        .background(
            Color.white
                .onTapGesture {
                    UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
                }
        )
        .navigationTitle("회사 이메일 인증")
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarBackButtonHidden()
        

        .onAppear {
            // 키보드 관찰자 시작
            KeyboardObserver.shared.startListening { height in
                withAnimation(.easeOut(duration: 0.3)) {
                    keyboardHeight = height
                }
            }
        }
        .onDisappear {
            // 키보드 관찰자 해제
            KeyboardObserver.shared.stopListening()
        }
    }
    
    // 인증 버튼 활성화 여부
    var isButtonEnabled: Bool {
        !emailID.isEmpty
    }
    
    // 버튼 클릭 처리
    private func handleButtonTap() {
        // 이메일 주소 구성
        registerViewModel.fullEmailAddress = "\(emailID)@\(registerViewModel.selectedEmailDomain)"
        print("📧 [DEBUG] 이메일 인증할 주소: \(registerViewModel.fullEmailAddress)")
        
        registerViewModel.requestCompanyEmailVerification { result in
            switch result {
            case .success:
                print("✅ 인증 메일 전송 성공")
                registerViewModel.navigationPath.append(NavigationStep.authenticationCode.rawValue)
            case .failure(let error):
                print("❌ 인증 메일 전송 실패: \(error.localizedDescription)")
            }
        }

    }
//    private func handleButtonTap() {
//            registerViewModel.fullEmailAddress = "\(emailID)@\(registerViewModel.selectedEmailDomain)"
//            print("EmailAuthentication - 이메일 인증할 주소: \(registerViewModel.fullEmailAddress)")
//
//            // 인증 성공 가정
//            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
//                print("✅ [DEBUG] 인증 메일 전송 성공")
//                registerViewModel.navigationPath.append("VerificationStep") // 인증 코드 입력 화면으로 이동
//            }
//        }
    
    private func debugRegisterViewModel() {
            if let company = registerViewModel.selectedCompany {
                print("🔍 [DEBUG] RegisterViewModel 상태:")
                print("    - 선택된 회사: \(company.name)")
                print("    - 도메인 개수: \(company.emails.count)")
                print("    - 도메인 목록: \(company.emails)")
                print("    - 선택된 도메인: \(registerViewModel.selectedEmailDomain)")
            } else {
                print("⚠️ [DEBUG] 선택된 회사가 없습니다.")
            }
        }
}


// 도메인 선택을 위한 Picker View
struct DomainPickerView: View {
    let domains: [String]
    @Binding var selectedDomain: String
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        NavigationView {
            List(domains, id: \.self) { domain in
                Button(action: {
                    selectedDomain = domain
                    presentationMode.wrappedValue.dismiss()
                }) {
                    HStack {
                        Text(domain)
                        Spacer()
                        if selectedDomain == domain {
                            Image(systemName: "checkmark")
                                .foregroundColor(.blue)
                        }
                    }
                }
            }
            .navigationTitle("도메인 선택")
            .navigationBarItems(trailing: Button("선택") {
                presentationMode.wrappedValue.dismiss()
                print("📧 [DEBUG] 도메인 선택 완료: \(selectedDomain)")
            })
        }
    }
}

struct ViewPositionKey: PreferenceKey {
    static var defaultValue: CGFloat = 0
    static func reduce(value: inout CGFloat, nextValue: () -> CGFloat) {
        value = nextValue()
    }
}
