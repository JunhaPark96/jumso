//import UIKit
//import SwiftUI
//
//class HomeViewController: UIViewController {
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//
//        view.backgroundColor = .white
////        self.title = "홈"
//        
//        /*
//         1. 앱 실행시 HomeViewController 로드
//         2. MainView는 UIHostingController로 감싸져 UIkit 뷰 계층에 추가
//         3. MainView가 HomeViewController 화면에 표시
//         */
//        
//        let mainView = MainView() // SwiftUI MainView 인스턴스 생성
//        let hostingController = UIHostingController(rootView: mainView)
//        
//        addChild(hostingController)
//        hostingController.view.translatesAutoresizingMaskIntoConstraints = false
//        view.addSubview(hostingController.view)
//        hostingController.didMove(toParent: self)
//        
//        NSLayoutConstraint.activate([
//                   hostingController.view.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
//                   hostingController.view.leadingAnchor.constraint(equalTo: view.leadingAnchor),
//                   hostingController.view.trailingAnchor.constraint(equalTo: view.trailingAnchor),
//                   hostingController.view.bottomAnchor.constraint(equalTo: view.bottomAnchor)
//               ])
//    }
//    
//}
