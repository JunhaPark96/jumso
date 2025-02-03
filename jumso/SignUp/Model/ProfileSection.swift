import SwiftUI

// MARK: - Profile Section Enum
enum ProfileSection: String, CaseIterable {
    case basicInfo = "키와 체형"
    case jobInfo = "하는 일"
    case additionalInfo = "추가 정보"

    // MARK: - Profile Section Rows
    enum ProfileSectionRow: String, CaseIterable {
        case height = "키를 알려주세요"
        case bodyType = "체형은 어떤가요?"
        case jobTitle = "하는 일을 알려주세요"
        case maritalStatus = "결혼 상태"
        case religion = "종교"
        case smoking = "흡연 여부"
        case drinking = "음주 여부"

        // 어떤 섹션에 속하는지 반환
        var section: ProfileSection {
            switch self {
            case .height, .bodyType:
                return .basicInfo
            case .jobTitle:
                return .jobInfo
            case .maritalStatus, .religion, .smoking, .drinking:
                return .additionalInfo
            }
        }
    }
}
