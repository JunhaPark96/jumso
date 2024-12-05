////
////  JumsoApp.swift
////  jumso
////
////  Created by junha on 12/5/24.
////
//
//import Foundation
//import SwiftUI
//
//@main
//struct JumsoApp: App {
//    @StateObject private var authViewModel = AuthViewModel()
//    @StateObject private var chatListViewModel = ChatListViewModel()
//    
//    var body: some Scene {
//        WindowGroup {
//            if authViewModel.isLoggedIn {
//                MainView()
//                    .environmentObject(authViewModel)
//                    .environmentObject(chatListViewModel)
//            } else {
//                LoginViewController()
//            }
//        }
//    }
//}
