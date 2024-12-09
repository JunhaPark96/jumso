import SwiftUI
import Combine

struct EmailAuthenticationView: View {
    let company: CompanyItem
    @State private var selectedEmailDomain: String
    @State private var emailID: String = ""
    @State private var showDomainPicker: Bool = false
    @State private var navigateToNextView: Bool = false
    @State private var keyboardHeight: CGFloat = 0
    
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
                    Button(action: handleButtonTap) {
                        Text("인증 메일 보내기")
                            .bold()
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(isButtonEnabled ? Color.blue : Color.gray)
                            .foregroundColor(.white)
                            .cornerRadius(10)
                            .padding(.horizontal)
                        //                                .background(Color.green.opacity(0.3)) // 디버깅용 배경색
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
            .navigationBarBackButtonHidden(true)

            .onAppear {
                // 키보드 관찰자 시작
                SwiftUIKeyboardObserver.shared.startListening { height in
                    print("키보드 높이 업데이트: \(height)")
                    withAnimation(.easeOut(duration: 0.3)){
                        keyboardHeight = height
                    }
                }
            }
            
            .onDisappear {
                // 키보드 관찰자 해제
                SwiftUIKeyboardObserver.shared.stopListening()
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

// 키보드 관찰자
final class SwiftUIKeyboardObserver: ObservableObject {
    static let shared = SwiftUIKeyboardObserver()
    private var cancellables: [AnyCancellable] = []
    
    @Published var keyboardHeight: CGFloat = 0
    
    private init() {}
    
    func startListening(onChange: @escaping (CGFloat) -> Void) {
        let willShowPublisher = NotificationCenter.default.publisher(for: UIResponder.keyboardWillShowNotification)
            .compactMap { ($0.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect)?.height }
        
        let willHidePublisher = NotificationCenter.default.publisher(for: UIResponder.keyboardWillHideNotification)
            .map { _ in CGFloat(0) }
        
        Publishers.Merge(willShowPublisher, willHidePublisher)
            .sink { height in
                DispatchQueue.main.async {
                    self.keyboardHeight = height
                    onChange(height)
                }
            }
            .store(in: &cancellables)
    }
    
    func stopListening() {
        cancellables.forEach { $0.cancel() }
        cancellables.removeAll()
    }
}
