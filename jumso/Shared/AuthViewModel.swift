//
//  AuthViewModel.swift
//  jumso
//
//  Created by junha on 12/5/24.
//

import Foundation
import SwiftUI

class AuthViewModel: ObservableObject {
    @Published var isLoggedIn: Bool = false // 로그인 여부
    @Published var currentUserID: UUID? = nil // 로그인된 사용자 ID
    
    func logIn(userID: UUID) {
        self.isLoggedIn = true
        self.currentUserID = userID
    }
    
    func logOut() {
        self.isLoggedIn = false
        self.currentUserID = nil
    }
}
