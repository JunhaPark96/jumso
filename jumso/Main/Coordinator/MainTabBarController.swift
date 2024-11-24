
import UIKit

class MainTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setupTabBar()
    }
    
    private func setupTabBar() {
        let homeVC = HomeViewController()
        let loungeVC = LoungeViewController()
        let chatVC = ChatViewController()
        let profileVC = ProfileViewController()
        
        homeVC.tabBarItem = UITabBarItem(title: "홈", image: UIImage(systemName: "house"), selectedImage: UIImage(systemName: "house.fill"))
        loungeVC.tabBarItem = UITabBarItem(title: "라운지", image: UIImage(systemName: "bubble.left.and.bubble.right"), selectedImage: UIImage(systemName: "bubble.left.and.bubble.right.fill"))
        chatVC.tabBarItem = UITabBarItem(title: "채팅", image: UIImage(systemName: "message"), selectedImage: UIImage(systemName: "message.fill"))
        profileVC.tabBarItem = UITabBarItem(title: "프로필", image: UIImage(systemName: "person"), selectedImage: UIImage(systemName: "person.fill"))
        
        
        
        let homeNav = UINavigationController(rootViewController: homeVC)
        let loungeNav = UINavigationController(rootViewController: loungeVC)
        let chatNav = UINavigationController(rootViewController: chatVC)
        let personNav = UINavigationController(rootViewController: profileVC)
        
        self.viewControllers = [homeNav, loungeNav, chatNav, personNav]
        
        self.selectedIndex = 0
    }
    

}
