import Foundation


struct SignUpAPIMapper {
    
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
        
        static func getDisplayName(for key: String, in mapping: [String: String]) -> String {
            return mapping[key] ?? key
        }
        
        static func getAPIValue(for displayName: String, in mapping: [String: String]) -> String {
            return mapping.first(where: { $0.value == displayName })?.key ?? displayName
        }
    
}
