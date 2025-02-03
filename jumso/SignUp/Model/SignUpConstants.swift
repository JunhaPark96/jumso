import Foundation
import SwiftUI

struct SignUpConstants {
    static let minAge: Float = 0   // API 기준 최소 0세부터
    static let maxAge: Float = 127 // API 기준 최대 127세
    static let minDistance: Float = 0
    static let maxDistance: Float = 127
}

struct SignUpOptions {
    static let genders = ["남성", "여성"]
    static let relationshipStatus = ["싱글", "돌싱"]
    static let bodyShape = ["마름", "통통", "근육질"]
    static let religions = ["무교", "기독교", "천주교", "정교회", "유대교", "불교", "이슬람", "힌두교", "기타"]
}

struct ProfileOptions {
    static let bodyType = ["마름", "슬림", "보통", "통통한편", "완전 근육"]
    static let maritalStatus = ["싱글", "돌싱"]
    static let religion = ["무교", "기독교", "천주교", "정교회", "유대교", "불교", "이슬람", "힌두교", "기타"]
    static let smoking = ["없음", "비흡연", "가끔 흡연", "자주 흡연"]
    static let drinking = ["없음", "비음주", "가끔 음주", "자주 음주"]
    static let heightRange = (100...300).map { "\($0) cm" }
}
