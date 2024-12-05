import SwiftUI
import UIKit

class MainTabBarController: UITabBarController {
    var authViewModel: AuthViewModel!
    var chatListViewModel: ChatListViewModel!
    
    // 프로그램 초기화용
    init(authViewModel: AuthViewModel, chatListViewModel: ChatListViewModel) {
        self.authViewModel = authViewModel
        self.chatListViewModel = chatListViewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    // Storyboard 초기화용
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        debugLog("⚠️ init(coder:)가 호출되었습니다. ViewModel이 주입되지 않을 수 있습니다.")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        debugLog("MainTabBarController viewDidLoad 호출됨")
        setupTabBar()
    }
    
    private func setupTabBar() {
        debugLog("✅ MainTabBarController authViewModel: \(authViewModel != nil)")
        debugLog("✅ MainTabBarController chatListViewModel: \(chatListViewModel != nil)")
        
        // Home Tab (MainView)
        let mainView = MainView()
            .environmentObject(authViewModel)
            .environmentObject(chatListViewModel)
        let homeVC = UIHostingController(rootView: mainView)
        homeVC.tabBarItem = UITabBarItem(
            title: "홈",
            image: UIImage(systemName: "house"),
            selectedImage: UIImage(systemName: "house.fill")
        )
        
        // Lounge Tab
        let loungeView = LoungeView()
            .environmentObject(authViewModel)
        let loungeVC = UIHostingController(rootView: loungeView)
        loungeVC.tabBarItem = UITabBarItem(
            title: "라운지",
            image: UIImage(systemName: "bubble.left.and.bubble.right"),
            selectedImage: UIImage(systemName: "bubble.left.and.bubble.right.fill")
        )
        
        // Chat Tab
        let chatView = ChatView()
            .environmentObject(authViewModel)
            .environmentObject(chatListViewModel)
        let chatVC = UIHostingController(rootView: chatView)
        chatVC.tabBarItem = UITabBarItem(
            title: "채팅",
            image: UIImage(systemName: "message"),
            selectedImage: UIImage(systemName: "message.fill")
        )
        
        // Profile Tab
        let profileView = ProfileView()
            .environmentObject(authViewModel)
        let profileVC = UIHostingController(rootView: profileView)
        profileVC.tabBarItem = UITabBarItem(
            title: "프로필",
            image: UIImage(systemName: "person"),
            selectedImage: UIImage(systemName: "person.fill")
        )
        
        self.viewControllers = [homeVC, loungeVC, chatVC, profileVC]
        self.selectedIndex = 0
        debugLog("✅ TabBarController setup 완료")
    }
    
    private func debugLog(_ message: String) {
        print("[DEBUG] \(message)")
    }
}
