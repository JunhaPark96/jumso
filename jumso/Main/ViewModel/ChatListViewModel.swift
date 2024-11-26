import SwiftUI
import Combine

class ChatListViewModel: ObservableObject {
    @Published var chatData: [Chat] = [] // 채팅 데이터
    
    private var cancellables = Set<AnyCancellable>()
    
    init() {
        fetchChatList()
    }
    
    // 서버에서 채팅 목록 데이터를 가져오는 메서드
    func fetchChatList() {
        // Mock 네트워크 요청
        Just([
            Chat(id: UUID(), profileImage: "person.circle.fill", name: "John Doe", lastMessage: "Hey! How are you?"),
            Chat(id: UUID(), profileImage: "person.circle.fill", name: "Jane Smith", lastMessage: "See you tomorrow!"),
            Chat(id: UUID(), profileImage: "person.circle.fill", name: "Chris", lastMessage: "Can you send me the file?"),
            Chat(id: UUID(), profileImage: "person.circle.fill", name: "Emma", lastMessage: "Okay, got it!"),
            Chat(id: UUID(), profileImage: "person.circle.fill", name: "John Doe", lastMessage: "Hey! How are you?"),
            Chat(id: UUID(), profileImage: "person.circle.fill", name: "Jane Smith", lastMessage: "See you tomorrow!"),
            Chat(id: UUID(), profileImage: "person.circle.fill", name: "Chris", lastMessage: "Can you send me the file?"),
            Chat(id: UUID(), profileImage: "person.circle.fill", name: "Emma", lastMessage: "Okay, got it!"),
            Chat(id: UUID(), profileImage: "person.circle.fill", name: "John Doe", lastMessage: "Hey! How are you?"),
            Chat(id: UUID(), profileImage: "person.circle.fill", name: "Jane Smith", lastMessage: "See you tomorrow!"),
            Chat(id: UUID(), profileImage: "person.circle.fill", name: "Chris", lastMessage: "Can you send me the file?"),
            Chat(id: UUID(), profileImage: "person.circle.fill", name: "Emma", lastMessage: "Okay, got it!")
        ])
        .delay(for: .seconds(1), scheduler: RunLoop.main) // 딜레이 추가로 네트워크 요청 시뮬레이션
        .sink { [weak self] data in
            self?.chatData = data
        }
        .store(in: &cancellables)
    }
}

struct Chat: Identifiable {
    let id: UUID
    let profileImage: String
    let name: String
    let lastMessage: String
}

