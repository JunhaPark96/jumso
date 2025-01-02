import SwiftUI
import Combine

struct EmailAuthenticationView: View {
    let company: CompanyItem
    @State private var selectedEmailDomain: String
    @State private var emailID: String = ""
    @State private var showDomainPicker: Bool = false
    @State private var navigateToNextView: Bool = false
    @State private var keyboardHeight: CGFloat = 0
    @StateObject private var keyboardManager = KeyboardManager.shared
    
    init(company: CompanyItem) {
        self.company = company
        _selectedEmailDomain = State(initialValue: company.emails.first ?? "")
    }
    
    var body: some View {
        NavigationStack {
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
                        //                        .background(Color.yellow.opacity(0.3)) // 디버깅용 배경색
                        
                        if company.emails.count > 1 {
                            Button(action: {
                                showDomainPicker = true
                            }) {
                                HStack {
                                    Text("@\(selectedEmailDomain)")
                                    Spacer()
                                    Image(systemName: "chevron.down")
                                }
                                .padding()
                                .background(Color(.systemGray6))
                                .cornerRadius(10)
                                .padding(.horizontal)
                            }
                            .sheet(isPresented: $showDomainPicker) {
                                DomainPickerView(domains: company.emails, selectedDomain: $selectedEmailDomain)
                            }
                            //                        .background(Color.orange.opacity(0.3)) // 디버깅용 배경색
                        } else {
                            HStack {
                                Text("@\(selectedEmailDomain)")
                                Spacer()
                            }
                            .padding()
                            .background(Color(.systemGray6))
                            .cornerRadius(10)
                            .padding(.horizontal)
                            //                        .background(Color.orange.opacity(0.3)) // 디버깅용 배경색
                        }
                    }
                    .frame(maxWidth: .infinity, alignment: .top)
                    .padding(.top, UIScreen.main.bounds.height / 6)
                    
                    Spacer()
                }
                // 인증 버튼 영역
                VStack {
                    Spacer()
                    SignUpReusableButton(title: "인증 메일 보내기", isEnabled: isButtonEnabled) {
                        handleButtonTap()
                    }
                    .background(GeometryReader { proxy in
                        Color.clear
                            .preference(key: ViewPositionKey.self, value: proxy.frame(in: .global).minY)
                    })
                    .onPreferenceChange(ViewPositionKey.self) { value in
                        print("인증 버튼 Y 좌표: \(value)")
                    }
                    .padding(.bottom, keyboardHeight > 0 ? 10 : UIScreen.main.bounds.height / 4)
                    .disabled(!isButtonEnabled)
                }
            }
            .background(
                Color.white
                    .onTapGesture {
                        // 화면 다른 곳을 터치하면 키보드 숨김
                        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
                    }
            )
            .navigationTitle("회사 이메일 인증")
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarBackButtonHidden()

            .onAppear {
                // 키보드 관찰자 시작
                KeyboardObserver.shared.startListening { height in
                    print("키보드 높이 업데이트: \(height)")
                    withAnimation(.easeOut(duration: 0.3)){
                        keyboardHeight = height
                    }
                }
            }
            
            .onDisappear {
                // 키보드 관찰자 해제
                KeyboardObserver.shared.stopListening()
            }
            .navigationDestination(isPresented: $navigateToNextView) {
                SignUpAuthenticationCodeView(fullEmailAddress: "\(emailID)@\(selectedEmailDomain)")
            }
        }
    }
    
    // 인증 버튼 활성화 여부
    var isButtonEnabled: Bool {
        !emailID.isEmpty
    }
    
    // 버튼 클릭 처리
    private func handleButtonTap() {
        let completeEmail = "\(emailID)@\(selectedEmailDomain)"
        print("EmailAuthentication - 이메일 인증할 주소: \(completeEmail)")
        // 다음 화면으로 이동
        navigateToNextView = true
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
