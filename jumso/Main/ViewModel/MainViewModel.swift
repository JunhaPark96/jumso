import SwiftUI
import Combine

class MainViewModel: ObservableObject {
    @Published var users: [Introduction] = []
    @Published var selectedUser: Introduction?
    
    private var cancellables = Set<AnyCancellable>()
    
    init() {
        fetchUsers() // 데이터 불러오기
    }
    
    func fetchUsers() {
        // TODO: API호출로 변경해야함.
        self.users = [
            Introduction(
                id: UUID(),
                profileImage: "person.fill",
                company: "Apple",
                jobInfo: "ios Developer",
                introductionContent: "안녕하세요 ios 개발자 입니다.",
                selfDescription: "Hi everyone. I'm Francesca (half Italian half German). I moved recently to South Korea and living at the moment in Songdo, so I'm searching for new friends.",
                preferredPartner: "새로운 동네 친구",
                basicInfo: [
                    "키" : "180cm",
                    "체형" : "근육질"
                ],
                additionalInfo: [
                    "결혼 상태": "미혼",
                    "종교": "기독교",
                    "흡연 여부": "비흡연",
                    "음주 여부": "음주"
                ],
                preferences: [
                    "원하는 성별": "여성",
                    "원하는 나이 (최소)": "25",
                    "원하는 나이 (최대)": "35",
                    "원하는 체형": "마름"
                ]
                
            ) // 초기화
            
        ]
    }
}


struct Introduction: Identifiable {
    let id: UUID
    let profileImage: String
    let company: String
    let jobInfo: String
    let introductionContent: String
    let selfDescription: String
    let preferredPartner: String
    let basicInfo: [String: String] // 키, 체형 등
    let additionalInfo: [String: String] // 결혼 상태, 종교 등
    let preferences: [String: String] // 원하는 조건
}
