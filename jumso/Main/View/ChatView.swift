import SwiftUI

struct ChatView: View {
    @EnvironmentObject var authViewModel: AuthViewModel
    @EnvironmentObject var chatListViewModel: ChatListViewModel
    
    var body: some View {
        let userChats = authViewModel.currentUserID != nil ? chatListViewModel.getChats(forUserID: authViewModel.currentUserID!) : []
        
        NavigationView {
            VStack(spacing: 0) {
                // 상단 고정 HStack
                HStack {
                    Spacer()
                    Text("Jumso")
                        .font(.headline)
                        .foregroundColor(.black)
                    Spacer()
                }
                .frame(height: 60)
                .padding(.horizontal)
                .background(Color.gray.opacity(0.2))
                
                // 채팅 리스트
                ChatListView()
            }
            .background(Color(.systemGroupedBackground))
            .navigationTitle("") // NavigationBar의 기본 타이틀 제거
            .navigationBarHidden(true) // 기본 NavigationBar 숨기기
        }
    }
}

struct ChatListView: View {
    @EnvironmentObject var chatListViewModel: ChatListViewModel

    var body: some View {
        ScrollView {
            VStack(spacing: 0) {
                Text("메세지")
                    .font(.title2)
                    .bold()
                    .padding()
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .background(Color.white)
                
                ForEach(chatListViewModel.chatData) { chat in
                    NavigationLink(destination: ChatDetailView(chatName: chat.name)) {
                        ChatRow(profileImage: chat.profileImage, name: chat.name, lastMessage: chat.lastMessage)
                            .padding(.horizontal)
                            .background(Color.white)
                            .padding(.bottom, 1)
                    }
                }
            }
        }
    }
}



struct ChatRow: View {
    let profileImage: String
    let name: String
    let lastMessage: String
    
    var body: some View {
        HStack(spacing: 12) {
            // 프로필 이미지
            Image(systemName: profileImage)
                .resizable()
                .scaledToFit()
                .frame(width: 50, height: 50)
                .clipShape(Circle())
                .foregroundColor(.blue)
            
            // 이름과 마지막 메시지
            VStack(alignment: .leading, spacing: 4) {
                Text(name)
                    .font(.headline)
                    .foregroundColor(.black)
                Text(lastMessage)
                    .font(.subheadline)
                    .foregroundColor(.gray)
                    .lineLimit(2)
            }
            
            Spacer()
        }
        .padding(.vertical, 8)
    }
}

//struct ChatView_Previews: PreviewProvider {
//    static var previews: some View {
//        ChatView()
//    }
//}
