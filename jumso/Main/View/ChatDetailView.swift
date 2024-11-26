import SwiftUI

struct ChatDetailView: View {
    let chatName: String
    @StateObject private var viewModel = ChatDetailViewModel()
    
    var body: some View {
        VStack {
            // 메시지 리스트
            ScrollView {
                VStack(alignment: .leading, spacing: 10) {
                    ForEach(viewModel.messages, id: \.self) { message in
                        HStack {
                            Text(message)
                                .padding()
                                .background(Color.blue.opacity(0.2))
                                .cornerRadius(10)
                                .frame(maxWidth: .infinity, alignment: .leading)
                        }
                    }
                }
                .padding()
            }
            
            // 입력창
            HStack {
                TextField("메시지를 입력하세요", text: $viewModel.message)
                    .padding()
                    .background(Color(.systemGray6))
                    .cornerRadius(10)
                Button(action: viewModel.sendMessage) {
                    Text("보내기")
                        .foregroundColor(.white)
                        .padding()
                        .background(Color.blue)
                        .cornerRadius(10)
                }
            }
            .padding()
        }
        .navigationTitle(chatName)
        .navigationBarTitleDisplayMode(.inline)
    }
}


//struct ChatView_Preview: PreviewProvider {
//    static var previews: some View {
//        ChatDetailView(chatName: "Chris")
//    }
//}
