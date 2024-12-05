import SwiftUI
import Combine

class ChatListViewModel: ObservableObject {
//    @EnvironmentObject var viewModel: ChatListViewModel
    @Published var chatData: [Chat] = [] // 채팅 데이터
    
    private var cancellables = Set<AnyCancellable>()
    
    
    func addChat(_ chat: Chat) {
        chatData.append(chat)
        print("새로운 채팅 추가됨: \(chat.name)")
    }
    
    func getChats(forUserID userID: UUID) -> [Chat] {
        return chatData.filter { $0.participants.contains(userID) }
    }
}

struct Chat: Identifiable {
    let id: UUID
    let profileImage: String
    let name: String
    let lastMessage: String
    let participants: [UUID]
}

