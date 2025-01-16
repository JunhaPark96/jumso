//
//  SceneDelegate.swift
//  jumso
//

import SwiftUI
import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    
    var window: UIWindow?
    var authViewModel = AuthViewModel()
    var chatListViewModel = ChatListViewModel()
    var registerViewModel = RegisterViewModel()
    
    func scene(
        _ scene: UIScene,
        willConnectTo session: UISceneSession,
        options connectionOptions: UIScene.ConnectionOptions
    ) {
        debugLog("SceneDelegate willConnectTo 호출됨")
        
        guard let windowScene = (scene as? UIWindowScene) else {
            debugLog("⚠️ windowScene이 nil입니다.")
            return
        }
        
        let window = UIWindow(windowScene: windowScene)
        
        // ViewModel 초기화 상태 확인
//        debugLog("✅ authViewModel 초기화 상태: \(authViewModel != nil)")
//        debugLog("✅ chatListViewModel 초기화 상태: \(chatListViewModel != nil)")
//        debugLog("✅ registerViewModel 초기화 상태: \(registerViewModel != nil)")
        
        // 로그인 여부에 따른 화면 분기
        if authViewModel.isLoggedIn {
            debugLog("✅ 사용자가 로그인 상태입니다. MainTabBarController로 이동합니다.")
            let tabBarController = MainTabBarController(
                authViewModel: authViewModel,
                chatListViewModel: chatListViewModel
            )
            window.rootViewController = tabBarController
        } else {
            debugLog("🔑 사용자가 로그인되지 않았습니다. LoginViewController로 이동합니다.")
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            guard let loginViewController = storyboard.instantiateViewController(withIdentifier: "LoginVC") as? LoginViewController else {
                debugLog("❌ LoginViewController를 생성할 수 없습니다.")
                return
            }
            debugLog("✅ LoginViewController가 생성되었습니다.")
            loginViewController.authViewModel = authViewModel
            debugLog("✅ LoginViewController에 authViewModel이 주입되었습니다.")
            
            // UINavigationController로 래핑
            let navigationController = UINavigationController(rootViewController: loginViewController)
            window.rootViewController = navigationController
            debugLog("✅ UINavigationController가 생성되고 LoginViewController를 포함했습니다.")
        }
        
        self.window = window
        window.makeKeyAndVisible()
        debugLog("✅ 윈도우가 화면에 표시되었습니다.")
    }

    
    func switchToLogin() {
        debugLog("🔄 LoginViewController로 전환 중...")
        guard let window = window else {
            debugLog("❌ window가 nil입니다.")
            return
        }
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        guard let loginVC = storyboard.instantiateViewController(withIdentifier: "LoginVC") as? LoginViewController else {
            debugLog("❌ LoginViewController를 생성할 수 없습니다.")
            return
        }
        
        window.rootViewController = loginVC
        window.makeKeyAndVisible()
        debugLog("✅ LoginViewController로 전환 완료.")
    }
    
    func sceneDidDisconnect(_ scene: UIScene) {
        debugLog("SceneDelegate sceneDidDisconnect 호출됨")
    }
    
    func sceneDidBecomeActive(_ scene: UIScene) {
        debugLog("SceneDelegate sceneDidBecomeActive 호출됨")
    }
    
    func sceneWillResignActive(_ scene: UIScene) {
        debugLog("SceneDelegate sceneWillResignActive 호출됨")
    }
    
    func sceneWillEnterForeground(_ scene: UIScene) {
        debugLog("SceneDelegate sceneWillEnterForeground 호출됨")
    }
    
    func sceneDidEnterBackground(_ scene: UIScene) {
        debugLog("SceneDelegate sceneDidEnterBackground 호출됨")
    }
    
    func debugLog(_ message: String) {
        print("[DEBUG] \(message)")
    }
}
