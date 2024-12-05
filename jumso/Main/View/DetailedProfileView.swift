import SwiftUI


struct DetailedProfileView: View {
    @ObservedObject var viewModel: DetailedProfileViewModel
    @EnvironmentObject var chatListViewModel: ChatListViewModel
    @EnvironmentObject var authViewModel: AuthViewModel
    @Environment(\.presentationMode) var presentationMode // 화면 닫기용
    
    @State private var isDuplicate = false
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 15) {
                // 프로필 이미지와 회사 정보
                HStack(spacing: 20) {
                    Image(systemName: viewModel.user.profileImage)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 100, height: 100)
                        .clipShape(Circle())
                        .background(Color.white)
                    
                    VStack(alignment: .leading, spacing: 10) {
                        Text(viewModel.user.company)
                            .font(.title2)
                            .fontWeight(.bold)
                        Text(viewModel.user.jobInfo)
                            .font(.headline)
                            .foregroundColor(.gray)
                    }
                }
                .padding(.bottom, 20)
                
                // 자기 소개 섹션
                Group {
                    Text("자기 소개")
                        .font(.title3)
                        .fontWeight(.bold)
                    Text(viewModel.user.selfDescription)
                        .font(.body)
                        .padding(.bottom, 10)
                }
                
                Divider()
                
                // 선호 조건 섹션
                Group {
                    Text("선호 조건")
                        .font(.title3)
                        .fontWeight(.bold)
                    ForEach(Array(viewModel.user.preferences.keys), id: \.self) { key in
                        if let value = viewModel.user.preferences[key] {
                            DetailedProfileRow(title: key, value: value)
                        }
                    }
                }
                
                Divider()
                
                // 회원 정보 섹션
                Group {
                    Text("회원 정보")
                        .font(.title3)
                        .fontWeight(.bold)
                    ForEach(Array(viewModel.user.basicInfo.keys), id: \.self) { key in
                        if let value = viewModel.user.basicInfo[key] {
                            DetailedProfileRow(title: key, value: value)
                        }
                    }
                }
                
                Divider()
                
                // 추가 정보 섹션
                Group {
                    Text("추가 정보")
                        .font(.title3)
                        .fontWeight(.bold)
                    ForEach(Array(viewModel.user.additionalInfo.keys), id: \.self) { key in
                        if let value = viewModel.user.additionalInfo[key] {
                            DetailedProfileRow(title: key, value: value)
                        }
                    }
                }
            }
            .padding()
        }
        
        Button(action: {
            print("메시지 보내기 버튼 클릭됨")
            addUserToChatList(user: viewModel.user)
        }) {
            HStack {
                Text(isDuplicate ? "이미 메시지를 보냈습니다" : "점심한끼 해요")
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                Image(systemName: "paperplane")
                    .foregroundColor(.white)
            }
            .frame(maxWidth: .infinity, minHeight: 50)
            .background(isDuplicate ? Color.gray : Color.blue) // 중복이면 회색
            .cornerRadius(10)
            .padding()
        }
        .disabled(isDuplicate) // 버튼 비활성화 상태
        .onAppear {
            checkDuplicateStatus()
        }
        
        .navigationTitle("상세 정보")
        .navigationBarTitleDisplayMode(.inline)
    }
    
    private func addUserToChatList(user: Introduction) {
        guard let currentUserID = authViewModel.currentUserID else {
            print("현재 사용자 ID를 찾을 수 없음.")
            return
        }
        
        // 중복 여부 확인
        let isDuplicate = chatListViewModel.chatData.contains {
            $0.participants.contains(user.id) && $0.participants.contains(currentUserID)
        }
        
        if isDuplicate {
            print("⚠️ 이미 메시지를 보낸 사용자입니다.")
            return
        }
        
        let newChat = Chat(
            id: UUID(),
            profileImage: user.profileImage,
            name: user.company,
            lastMessage: "안녕하세요!",
            participants: [currentUserID, user.id] // 현재 사용자와 상대방의 UUID
        )
        chatListViewModel.addChat(newChat)
        print("✅ 채팅 추가됨: \(newChat)")
        print("📋 현재 채팅 리스트: \(chatListViewModel.chatData)")
        
        presentationMode.wrappedValue.dismiss()
    }
    
    private func checkDuplicateStatus() {
        guard let currentUserID = authViewModel.currentUserID else {
            print("현재 사용자 ID를 찾을 수 없음.")
            return
        }
        
        // 중복 여부 확인
        isDuplicate = chatListViewModel.chatData.contains {
            $0.participants.contains(viewModel.user.id) && $0.participants.contains(currentUserID)
        }
        print("✅ 중복 여부 확인: \(isDuplicate ? "중복됨" : "중복되지 않음")")
    }
}

struct DetailedProfileRow: View {
    let title: String
    let value: String
    
    var body: some View {
        HStack {
            Text(title)
                .fontWeight(.semibold)
            Spacer()
            Text(value)
                .foregroundColor(.gray)
        }
        .font(.callout)
        .padding(.vertical, 5)
    }
}

//struct DetailedProfileView_Previews: PreviewProvider {
//    static var previews: some View {
//        // MainViewModel에서 사용자 데이터 가져오기
//        let mainViewModel = MainViewModel()
//        let firstUser = mainViewModel.users.first! // 첫 번째 사용자 선택
//
//        let viewModel = DetailedProfileViewModel(user: firstUser)
//
//        return NavigationView {
//            DetailedProfileView(viewModel: viewModel)
//        }
//    }
//}
