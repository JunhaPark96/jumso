import SwiftUI
import UIKit

class MainTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setupTabBar()
    }
    
    private func setupTabBar() {
//        let homeVC = HomeViewController()
        let mainView = MainView()
        let homeVC = UIHostingController(rootView: mainView)
        homeVC.tabBarItem = UITabBarItem(title: "홈", image: UIImage(systemName: "house"), selectedImage: UIImage(systemName: "house.fill"))
        
        let loungeVC = LoungeViewController()
        
        let chatView = ChatView()
        let chatVC = UIHostingController(rootView: chatView)
        chatVC.tabBarItem = UITabBarItem(title: "채팅", image: UIImage(systemName: "message"), selectedImage: UIImage(systemName: "message.fill"))
        
        
        let profileVC = ProfileViewController()
        
        loungeVC.tabBarItem = UITabBarItem(title: "라운지", image: UIImage(systemName: "bubble.left.and.bubble.right"), selectedImage: UIImage(systemName: "bubble.left.and.bubble.right.fill"))
        profileVC.tabBarItem = UITabBarItem(title: "프로필", image: UIImage(systemName: "person"), selectedImage: UIImage(systemName: "person.fill"))
        
        
        let loungeNav = UINavigationController(rootViewController: loungeVC)
        let personNav = UINavigationController(rootViewController: profileVC)
        
        self.viewControllers = [homeVC, loungeNav, chatVC, personNav]
        
        self.selectedIndex = 0
    }
    

}
