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

// MARK: - API 값 ↔ 한글 변환 매핑
struct APIMapper {
    static let genderMap: [String: String] = [
        "MALE": "남성",
        "FEMALE": "여성"
    ]
    
    static let relationshipStatusMap: [String: String] = [
        "SINGLE": "싱글",
        "DOLSING": "돌싱"
    ]

    static let bodyTypeMap: [String: String] = [
        "SKINNY": "마름",
        "SLIM": "슬림",
        "NORMAL": "보통",
        "FAT": "통통한편",
        "MUSCLE": "완전 근육"
    ]
    
    static let religionMap: [String: String] = [
        "NONE": "무교",
        "CHRISTIAN": "기독교",
        "CATHOLIC": "천주교",
        "ORTHODOX": "정교회",
        "JUDAISM": "유대교",
        "BUDDHISM": "불교",
        "ISLAM": "이슬람",
        "HINDUISM": "힌두교",
        "OTHER": "기타"
    ]
    
    static let smokeMap: [String: String] = [
        "NONE": "없음",
        "NO": "비흡연",
        "SOMETIMES": "가끔 흡연",
        "OFTEN": "자주 흡연"
    ]
    
    static let drinkMap: [String: String] = [
        "NONE": "없음",
        "NO": "비음주",
        "SOMETIMES": "가끔 음주",
        "OFTEN": "자주 음주"
    ]
    
    // API 값 → 한글 변환 함수
    static func getDisplayName(for key: String, in mapping: [String: String]) -> String {
        return mapping[key] ?? key
    }
    
    // 한글 → API 값 변환 함수
    static func getAPIValue(for displayName: String, in mapping: [String: String]) -> String {
        return mapping.first(where: { $0.value == displayName })?.key ?? displayName
    }
}
