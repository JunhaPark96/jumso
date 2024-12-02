import SwiftUI


struct DetailedProfileView: View {
    @ObservedObject var viewModel: DetailedProfileViewModel
    
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
        .navigationTitle("상세 정보")
        .navigationBarTitleDisplayMode(.inline)
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
