import SwiftUI
import Combine

class MainViewModel: ObservableObject {
    @Published var introduction: Introduction
    
    private var cancellables = Set<AnyCancellable>()
    
    init() {
        self.introduction = Introduction(id: UUID(), profileImage: "", company: "", jobInfo: "", introductionContent: "") // 초기화
        fetchIntroduction() // 데이터 불러오기
    }
    
    func fetchIntroduction() {
        Just(
            Introduction(id: UUID(), profileImage: "person.fill", company: "Apple", jobInfo: "IOS Developer", introductionContent: "안녕하세요 ios 개발자 입니다.안녕하세요 ios 개발자 입니다.안녕하세요 ios 개발자 입니다.안녕하세요 ios 개발자 입니다.안녕하세요 ios 개발자 입니다.안녕하세요 ios 개발자 입니다.안녕하세요 ios 개발자 입니다.안녕하세요 ios 개발자 입니다.안녕하세요 ios 개발자 입니다.안녕하세요 ios 개발자 입니다.안녕하세요 ios 개발자 입니다.안녕하세요 ios 개발자 입니다.안녕하세요 ios 개발자 입니다.안녕하세요 ios 개발자 입니다.안녕하세요 ios 개발자 입니다.안녕하세요 ios 개발자 입니다.안녕하세요 ios 개발자 입니다.안녕하세요 ios 개발자 입니다.안녕하세요 ios 개발자 입니다.안녕하세요 ios 개발자 입니다.안녕하세요 ios 개발자 입니다.안녕하세요 ios 개발자 입니다.안녕하세요 ios 개발자 입니다.안녕하세요 ios 개발자 입니다.안녕하세요 ios 개발자 입니다.안녕하세요 ios 개발자 입니다.안녕하세요 ios 개발자 입니다.안녕하세요 ios 개발자 입니다.안녕하세요 ios 개발자 입니다.안녕하세요 ios 개발자 입니다.안녕하세요 ios 개발자 입니다.안녕하세요 ios 개발자 입니다.안녕하세요 ios 개발자 입니다.안녕하세요 ios 개발자 입니다.안녕하세요 ios 개발자 입니다.안녕하세요 ios 개발자 입니다.안녕하세요 ios 개발자 입니다.안녕하세요 ios 개발자 입니다.안녕하세요 ios 개발자 입니다.안녕하세요 ios 개발자 입니다.안녕하세요 ios 개발자 입니다.안녕하세요 ios 개발자 입니다.안녕하세요 ios 개발자 입니다.안녕하세요 ios 개발자 입니다.안녕하세요 ios 개발자 입니다.안녕하세요 ios 개발자 입니다.안녕하세요 ios 개발자 입니다.안녕하세요 ios 개발자 입니다.")
        )
        .delay(for: .seconds(1), scheduler: RunLoop.main)
        .sink { [weak self] data in
            self?.introduction = data
        }
        .store(in: &cancellables)
    }
}


struct Introduction: Identifiable {
    let id: UUID
    let profileImage: String
    let company: String
    let jobInfo: String
    let introductionContent: String
}
