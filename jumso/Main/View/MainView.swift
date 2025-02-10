import SwiftUI

struct MainView: View {
    @StateObject var viewModel = MainViewModel()
    @EnvironmentObject var authViewModel: AuthViewModel
    @EnvironmentObject var chatListViewModel: ChatListViewModel
    
    var body: some View {
        NavigationView {
            VStack(spacing: 0) {
                // 헤더
                HStack {
                    Text("소개")
                        .font(.title)
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                    Spacer()
                }
                .padding()
                .background(Color.green)
                .frame(maxWidth: .infinity)
                
                // 사용자 목록
                ScrollView {
                    Spacer(minLength: 50)
                    
                    VStack(spacing: 10) {
                        ForEach(viewModel.users) { user in
//                            NavigationLink(
//                                destination: DetailedProfileView(viewModel: DetailedProfileViewModel(user: user))
//                            ) {
//                                MainIntroductionView(introduction: user)
//                            }
//                            .buttonStyle(PlainButtonStyle()) // 기본 스타일 제거
                            NavigationLink(
                                destination: DetailedProfileView(viewModel: DetailedProfileViewModel(user: user))
                                    .environmentObject(authViewModel)
                                    .environmentObject(chatListViewModel)
                            ) {
                                MainIntroductionView(introduction: user)
                            }
                            .buttonStyle(PlainButtonStyle()) 

                        }
                    }
                    .padding(.horizontal)
                }
                .background(Color.gray.opacity(0.1))
            }
            .navigationTitle("점소")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}


struct MainIntroductionView: View {
    let introduction: Introduction
    
    @State private var isLiked = false
    @State private var isBookmarked = false
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            // 프로필 헤더
            HStack(spacing: 20) {
                Image(systemName: introduction.profileImage)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 50, height: 50)
                    .clipShape(Circle())
                    .background(Color.white)
                
                VStack(alignment: .leading, spacing: 5) {
                    Text(introduction.company)
                        .font(.headline)
                        .foregroundColor(.black)
                    Text(introduction.jobInfo)
                        .font(.subheadline)
                        .foregroundColor(.gray)
                }
                Spacer()
                
                HStack(spacing: 10) {
                    Button(action: {
                        isLiked.toggle()
                    }) {
                        Image(systemName: isLiked ? "heart.fill" : "heart")
                            .foregroundColor(isLiked ? .red : .gray)
                    }
                    
                    Button(action: {
                        isBookmarked.toggle()
                    }) {
                        Image(systemName: isBookmarked ? "bookmark.fill" : "bookmark")
                            .foregroundColor(isBookmarked ? .blue : .gray)
                    }
                }
            }
            
            // 소개 내용
            Text(introduction.introductionContent)
                .font(.callout)
                .lineLimit(30)
                .foregroundColor(.black)
            
            Spacer(minLength: 5)
            
            // "더보기" 버튼
            HStack {
                Spacer()
                NavigationLink(destination: DetailedProfileView(viewModel: DetailedProfileViewModel(user: introduction))) {
                    Text("더보기")
                        .font(.callout)
                        .foregroundColor(.black)
                    Image(systemName: "arrow.forward.circle")
                        .foregroundColor(.black)
                        .font(.system(size: 16, weight: .regular))
                }
                .padding(.top, 5)
            }
        }
        .padding()
        .background(Color.white)
        .clipShape(RoundedRectangle(cornerRadius: 10))
        .shadow(radius: 2)
        .frame(minHeight: 300, maxHeight: 500) // 크기 지정
    }
}



//struct MainView_Previews: PreviewProvider {
//    static var previews: some View{
//        MainView()
//    }
//}
