import SwiftUI
import Combine

struct ChatDetailView: View {
    let chatName: String
    @StateObject private var viewModel = ChatDetailViewModel()
    @State private var keyboardHeight: CGFloat = 0 // 키보드 높이 추적

    var body: some View {
        VStack(spacing: 0) {
            // 메시지 리스트
            ScrollViewReader { scrollViewProxy in
                ScrollView {
                    VStack(alignment: .leading, spacing: 10) {
                        ForEach(viewModel.messages, id: \.id) { message in
                            HStack {
                                if message.isMine {
                                    Spacer()
                                    Text(message.content)
                                        .padding()
                                        .background(Color.blue.opacity(0.8))
                                        .cornerRadius(10)
                                        .foregroundColor(.white)
                                        .frame(maxWidth: UIScreen.main.bounds.width * 0.7, alignment: .trailing)
                                } else {
                                    Text(message.content)
                                        .padding()
                                        .background(Color.gray.opacity(0.2))
                                        .cornerRadius(10)
                                        .foregroundColor(.black)
                                        .frame(maxWidth: UIScreen.main.bounds.width * 0.7, alignment: .leading)
                                    Spacer()
                                }
                            }
                            .id(message.id) // 각 메시지에 고유 ID 추가
                        }
                    }
                    .padding(.horizontal)
                    .padding(.top)
                }
                .onChange(of: viewModel.messages) { _ in
                    scrollViewProxy.scrollTo(viewModel.messages.last?.id, anchor: .bottom)
                }
                .onChange(of: keyboardHeight) { _ in
                    scrollViewProxy.scrollTo(viewModel.messages.last?.id, anchor: .bottom)
                }
            }

            // 입력창
            VStack(spacing: 7) {
//                Divider() // 입력창 위 구분선
                HStack {
                    TextField("메시지를 입력하세요", text: $viewModel.message)
                        .padding()
                        .background(Color(.systemGray6))
                        .cornerRadius(10)
                    Button(action: {
                        viewModel.sendMessage()
                    }) {
                        Text("보내기")
                            .foregroundColor(.white)
                            .padding()
                            .background(Color.blue)
                            .cornerRadius(10)
                    }
                }
                .padding()
                .background(Color.white)
            }
            .animation(.easeOut(duration: 0.3), value: keyboardHeight) // 부드러운 애니메이션
        }
        .background(Color.white.ignoresSafeArea())
        .onTapGesture {
            hideKeyboard()
        }
        .onAppear {
            KeyboardObserver.shared.startListening { height in
                keyboardHeight = height
            }
        }
        .onDisappear {
            KeyboardObserver.shared.stopListening()
        }
        .navigationTitle(chatName)
        .navigationBarTitleDisplayMode(.inline)
    }
}


final class KeyboardObserver: ObservableObject {
    static let shared = KeyboardObserver()
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

// 키보드 숨김 확장 함수
extension View {
    func hideKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}



//struct ChatView_Preview: PreviewProvider {
//    static var previews: some View {
//        ChatDetailView(chatName: "Chris")
//    }
//}
