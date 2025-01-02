import Foundation

struct MockData {
    static let loggedInUser = Introduction(
        id: UUID(), // 로그인한 사용자 UUID
        profileImage: "person.circle.fill",
        company: "Samsung",
        jobInfo: "Backend Developer",
        introductionContent: "안녕하세요, 서버 개발자입니다.",
        selfDescription: "여행을 좋아하고 맛집 탐방을 즐깁니다.",
        preferredPartner: "같이 여행 다닐 친구",
        basicInfo: [
            "키": "178cm",
            "체형": "슬림"
        ],
        additionalInfo: [
            "결혼 상태": "미혼",
            "종교": "무교",
            "흡연 여부": "비흡연",
            "음주 여부": "가끔"
        ],
        preferences: [
            "원하는 성별": "여성",
            "원하는 나이 (최소)": "25",
            "원하는 나이 (최대)": "32",
            "원하는 체형": "슬림"
        ]
    )

    static let users: [Introduction] = [
        Introduction(
            id: UUID(),
            profileImage: "person.circle.fill",
            company: "Google",
            jobInfo: "AI Engineer",
            introductionContent: "안녕하세요, AI 엔지니어입니다.",
            selfDescription: "기술과 사람을 연결하는 일을 좋아합니다.",
            preferredPartner: "같이 배울 친구",
            basicInfo: [
                "키": "175cm",
                "체형": "보통"
            ],
            additionalInfo: [
                "결혼 상태": "미혼",
                "종교": "기독교",
                "흡연 여부": "비흡연",
                "음주 여부": "금주"
            ],
            preferences: [
                "원하는 성별": "남성",
                "원하는 나이 (최소)": "30",
                "원하는 나이 (최대)": "40",
                "원하는 체형": "근육질"
            ]
        ),
        Introduction(
            id: UUID(),
            profileImage: "person.circle.fill",
            company: "Meta",
            jobInfo: "Designer",
            introductionContent: "안녕하세요, UX 디자이너입니다.",
            selfDescription: "사용자 중심 디자인을 중요시합니다.",
            preferredPartner: "창의적인 친구",
            basicInfo: [
                "키": "165cm",
                "체형": "슬림"
            ],
            additionalInfo: [
                "결혼 상태": "미혼",
                "종교": "불교",
                "흡연 여부": "비흡연",
                "음주 여부": "음주"
            ],
            preferences: [
                "원하는 성별": "여성",
                "원하는 나이 (최소)": "22",
                "원하는 나이 (최대)": "28",
                "원하는 체형": "슬림"
            ]
        ),
        Introduction(
            id: UUID(),
            profileImage: "person.circle.fill",
            company: "Apple",
            jobInfo: "iOS Developer",
            introductionContent: "안녕하세요, iOS 개발자입니다.",
            selfDescription: "새로운 기술을 탐구하는 것을 좋아합니다.",
            preferredPartner: "같이 앱을 만들 친구",
            basicInfo: [
                "키": "182cm",
                "체형": "근육질"
            ],
            additionalInfo: [
                "결혼 상태": "미혼",
                "종교": "천주교",
                "흡연 여부": "흡연",
                "음주 여부": "음주"
            ],
            preferences: [
                "원하는 성별": "남성",
                "원하는 나이 (최소)": "27",
                "원하는 나이 (최대)": "35",
                "원하는 체형": "보통"
            ]
        )
    ]
}
