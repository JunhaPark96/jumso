import SwiftUI

struct MainView : View {
    @StateObject var viewModel = MainViewModel()
    
    var body: some View {
        VStack {
            HStack {
                Text("소개")
                    .font(.title)
                    .foregroundStyle(.black)
                Spacer()
            } // end HStack
            .frame(maxWidth: .infinity)
            .padding(.horizontal)
            .fontWeight(.bold)
            .background(Color.green)
            .font(.largeTitle)
            
            
            // TODO: 회원 정보 들어가야함 ID, 자기소개
            MainIntroductionView(introduction: viewModel.introduction)
            Spacer()
        } // end Vstack
    }
}

struct MainIntroductionView: View {
    let introduction: Introduction
    
    var body: some View {
        VStack (alignment: .leading){
            IntroductionRow (
                profileImage: introduction.profileImage,
                company: introduction.company,
                jobInfo: introduction.jobInfo,
                introductionContent: introduction.introductionContent
            )
        }
        .background(Color.gray)
        .clipShape(RoundedRectangle(cornerRadius: 8))
        .padding()
    }
}

struct IntroductionRow: View {
    let profileImage: String
    let company: String
    let jobInfo: String
    let introductionContent: String
    
    var body: some View {
        VStack (alignment: .leading){
            // 프로필 부분
            HStack (alignment: .top, spacing: 20){
                Image(systemName: profileImage)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 50, height: 50)
                    .clipShape(Circle())
                    .background(Color.white)
                
                VStack(alignment: .leading, spacing: 5) {
                    Text(company)
                        .font(.headline)
                        .foregroundStyle(.black)
                    Text(jobInfo)
                        .font(.subheadline)
                        .foregroundStyle(.black)
                } // end Vstack

            } // end Hstack
            .padding(.top)
            
            // 소개 부분
            VStack (alignment: .leading, spacing: 0) {
                Text(introductionContent)
                    .font(.callout)
                    .frame(maxWidth: .infinity, alignment: .leading)
//                    .padding(.bottom)
                Spacer()
            }
            .frame(minHeight: 200)
            .frame(maxHeight: 400)
            .clipShape(RoundedRectangle(cornerRadius: 8))
            .padding(.bottom)
            
        } // end Vstack
        .padding()
    }
}

//struct MainView_Previews: PreviewProvider {
//    static var previews: some View{
//        MainView()
//    }
//}
