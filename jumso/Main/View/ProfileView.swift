import SwiftUI

struct ProfileView: View {
    @State private var howFarCanYouGo: Double = 10
    @State private var howOldDoYouWant: ClosedRange<Double> = 18...50
    
    var body: some View {
        VStack(spacing: 0) {
            // 상단 고정 영역
            HStack {
                Text("jumso")
                    .font(.headline)
                    .foregroundStyle(.black)
                Spacer()
                Button(action: {
                    print("Setting 선택")
                }) {
                    Image(systemName: "gearshape")
                        .resizable()
                        .frame(width: 24, height: 24)
                        .padding()
                }
            }
            .padding(.horizontal)
            .frame(height: 10)
            //            .background(Color.gray)
            
            // 스크롤 가능한 콘텐츠
            ScrollView {
                VStack(spacing: 20) {
                    // 2Row: 프로필 사진
                    VStack {
                        Image(systemName: "person.crop.circle.fill")
                            .resizable()
                            .frame(width: 100, height: 100)
                            .foregroundStyle(.gray)
                            .padding(.bottom, 8)
                        Text("사용자 이름")
                            .font(.title2)
                            .bold()
                    }
                    
                    // 3Row: 계정설정
                    SectionView(title: "계정 관리") {
                        ProfileRow(title: "계정 설정하기", action: { print("계정 설정하기 tapped") })
                        ProfileRow(title: "알림 설정", action: { print("알림 설정 tapped") })
                        ProfileRow(title: "보조 이메일 설정", action: { print("보조 이메일 설정 tapped") })
                    }
                    
                    // 4Row: 프로필 설정
                    SectionView(title: "프로필 관리") {
                        ProfileRow(title: "프로필 설정하기", action: { print("프로필 설정하기 tapped") })
                    }
                    
                    // 5Row: 디스커버리 범위 설정
                    SectionView(title: "디스커버리 범위 설정") {
                        VStack(alignment: .leading, spacing: 20) {
                            HStack {
                                Text("위치 설정")
                                Spacer()
                                Toggle("", isOn: .constant(true))
                                    .labelsHidden()
                            }
                            Divider()
                            VStack(alignment: .leading) {
                                Text("상대와의 거리 설정: \(Int(howFarCanYouGo)) km")
                                Slider(value: $howFarCanYouGo, in: 1...127, step: 1)
                            }
                            
                            Divider()
                            VStack(alignment: .leading) {
                                Text("상대 연령대 설정: \(Int(howOldDoYouWant.lowerBound)) - \(Int(howOldDoYouWant.upperBound))세")
                                ImprovedDoubleHandleSlider(range: $howOldDoYouWant, bounds: 18...100, step: 1)
                                    .frame(height: 44)
                                    .padding(.horizontal, 16)
                                
                                
                                Spacer()
                            }
                        }
                        .padding()
                        .background(Color(UIColor.systemGroupedBackground).ignoresSafeArea())
                        .clipShape(RoundedRectangle(cornerRadius: 8))
                        .shadow(radius: 1)
                    }
                    
                    // 6row: 로그아웃 버튼
                    Button(action: {
                        //                        showLogin = true
                        UIApplication.shared.switchToLogin()
                    }) {
                        Text("로그아웃")
                            .frame(width: 200, height: 50)
                            .background(Color.red)
                            .foregroundColor(.white)
                            .cornerRadius(10)
                    }
                    .padding(.bottom, 20)
                    
                    // 7row: 앱 버전 및 아이콘 표시
                    VStack(spacing: 5) {
                        Text("앱 버전 1.0.0")
                            .foregroundColor(.gray)
                            .font(.footnote)
                        Image(systemName: "app.fill")
                            .resizable()
                            .frame(width: 40, height: 40)
                            .foregroundColor(.gray)
                    }
                    
                    // 8row: 계정 삭제 버튼
                    Button(action: {
                        print("계정 삭제 tapped")
                    }) {
                        Text("계정 삭제")
                            .foregroundColor(.red)
                            .padding()
                    }
                }
                .padding()
            }
        }
        .background(Color.white.ignoresSafeArea())
        .navigationTitle("프로필")
        //        .fullScreenCover(isPresented: $showLogin) {
        //            LoginViewControllerWrapper()
    }
}

