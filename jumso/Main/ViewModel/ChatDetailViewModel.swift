import SwiftUI
import Combine

struct ChatMessage: Identifiable, Hashable {
    let id = UUID()
    let content: String
    let isMine: Bool // 내가 보낸 메시지 여부
}

class ChatDetailViewModel: ObservableObject {
    @Published var messages: [ChatMessage] = []
    @Published var message: String = "" // 입력된 메시지
    
    private var cancellables = Set<AnyCancellable>()
    
    init() {
        loadInitialMessages()
    }
    
    // 초기 메시지 로드
    func loadInitialMessages() {
        // Mock 초기 메시지
        messages = [
            ChatMessage(content: "안녕하세요!", isMine: false),
            ChatMessage(content: "여자친구 있어요?", isMine: true)
        ]
    }
    
    // 메시지 전송
    func sendMessage() {
        guard !message.isEmpty else { return }
        let newMessage = ChatMessage(content: message, isMine: true)
        messages.append(newMessage)
        message = "" // 입력창 초기화
        
        // 서버로 메시지 전송 시뮬레이션
        Just("서버로 메시지가 전송되었습니다.")
            .delay(for: .seconds(0.5), scheduler: RunLoop.main)
            .sink { status in
                print(status)
            }
            .store(in: &cancellables)
    }
}
