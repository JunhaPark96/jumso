
import UIKit
import SwiftUI

struct SectionView<Content: View>: View {
    let title: String
    let content: Content
    
    init(title: String, @ViewBuilder content: () -> Content) {
        self.title = title
        self.content = content()
    }
    
    var body: some View{
        VStack(alignment: .leading, spacing: 12) {
            Text(title)
                .font(.headline)
                .foregroundStyle(.gray)
                .padding(.bottom, 1)
            content
                .background(Color.white)
                .clipShape(RoundedRectangle(cornerRadius: 8))
                .shadow(radius: 1)
        }
    }
}

struct ProfileRow: View {
    let title: String
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            HStack {
                Text(title)
                    .foregroundColor(.blue)
                Spacer()
                Image(systemName: "chevron.right")
                    .foregroundColor(.gray)
            }
            .padding()
        }
    }
}

struct RangeSlider: View {
    @Binding var range: ClosedRange<Double>
    let bounds: ClosedRange<Double>
    let step: Double
    
    var body: some View {
        VStack {
            Slider(value: Binding (
                get: {range.lowerBound},
                set: {range = $0...range.upperBound}
            ), in:bounds.lowerBound...bounds.upperBound, step: step)
            
            Slider(value: Binding (
                get: {range.upperBound},
                set: {range = range.lowerBound...$0}
            ), in:bounds.lowerBound...bounds.upperBound, step: step)
        }
    }
}


struct ImprovedDoubleHandleSlider: View {
    @Binding var range: ClosedRange<Double>
    let bounds: ClosedRange<Double>
    let step: Double
    let trackHeight: CGFloat = 6
    let handleSize: CGFloat = 20

    var body: some View {
        GeometryReader { geometry in
            let sliderWidth = geometry.size.width
            let totalRange = bounds.upperBound - bounds.lowerBound
            
            // 핸들의 현재 위치 계산
            let lowerOffset = CGFloat((range.lowerBound - bounds.lowerBound) / totalRange) * sliderWidth
            let upperOffset = CGFloat((range.upperBound - bounds.lowerBound) / totalRange) * sliderWidth
            
            ZStack {
                // 전체 트랙
                Capsule()
                    .fill(Color.gray.opacity(0.3))
                    .frame(height: trackHeight)
                
                // 활성 범위 트랙
                Capsule()
                    .fill(Color.blue)
                    .frame(width: upperOffset - lowerOffset, height: trackHeight)
                    .offset(x: (upperOffset + lowerOffset) / 2 - sliderWidth / 2)
                
                // 하한 핸들
                Circle()
                    .fill(Color.blue)
                    .frame(width: handleSize, height: handleSize)
                    .position(x: lowerOffset, y: handleSize / 2)
                    .gesture(
                        DragGesture()
                            .onChanged { gesture in
                                let translation = max(0, min(gesture.location.x, upperOffset))
                                let percentage = translation / sliderWidth
                                let newValue = bounds.lowerBound + percentage * totalRange
                                range = max(bounds.lowerBound, min(newValue, range.upperBound - step))...range.upperBound
                            }
                    )
                
                // 상한 핸들
                Circle()
                    .fill(Color.blue)
                    .frame(width: handleSize, height: handleSize)
                    .position(x: upperOffset, y: handleSize / 2)
                    .gesture(
                        DragGesture()
                            .onChanged { gesture in
                                let translation = max(lowerOffset, min(gesture.location.x, sliderWidth))
                                let percentage = translation / sliderWidth
                                let newValue = bounds.lowerBound + percentage * totalRange
                                range = range.lowerBound...min(bounds.upperBound, max(newValue, range.lowerBound + step))
                            }
                    )
            }
        }
        .frame(height: handleSize)
    }
}




struct ProfileView: View {
    @State private var showLogin = false
    @State private var howFarCanYouGo: Double = 10
    @State private var howOldDoYouWant: ClosedRange<Double> = 18...50
    
    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                // 1Row: Setting 아이콘
                HStack {
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
                    //                    .background(Color.white)
                    .background(Color(UIColor.systemGroupedBackground).ignoresSafeArea())
                    .clipShape(RoundedRectangle(cornerRadius: 8))
                    .shadow(radius: 1)
                }
                
                // 6row: 로그아웃 버튼
                Button(action: {
                    showLogin = true
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
        .background(Color.white.ignoresSafeArea())
        .navigationTitle("프로필")
        .fullScreenCover(isPresented: $showLogin) {
            LoginViewControllerWrapper()
        }
    }
}

struct LoginViewControllerWrapper: UIViewControllerRepresentable {
    func makeUIViewController(context: Context) -> UINavigationController {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let loginViewController = storyboard.instantiateViewController(withIdentifier: "LoginVC") as! LoginViewController
        
        return UINavigationController(rootViewController: loginViewController)
    }
    
    func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {
        
    }
}

class ProfileViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let profileView = ProfileView()
        let hostingController = UIHostingController(rootView: profileView)
        
        //        setupLogoutButton()
        
        addChild(hostingController)
        view.addSubview(hostingController.view)
        hostingController.didMove(toParent: self)
        
        hostingController.view.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            hostingController.view.topAnchor.constraint(equalTo: view.topAnchor),
            hostingController.view.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            hostingController.view.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            hostingController.view.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
}
