import SwiftUI

class FeatureCoordinator: ObservableObject {
    @Published var navigationPath: NavigationPath = NavigationPath()
    
    // 선택된 속성 및 회사 리스트
    @Published var selectedProperties: Set<String> = []
    @Published var selectedCompanies: Set<CompanyItem> = []
    
    // 선택 가능한 속성 리스트
    let allProperties: [String] = FeatureCoordinator.defaultProperties
    
    // 회사 리스트를 관리하는 뷰 모델 (❗️수정)
    @Published var companyViewModel: SelectCompanyViewModel

    // MARK: - 기본 속성 리스트 (정적 프로퍼티로 선언)
    static let defaultProperties: [String] = [
        "유머러스함", "지적임", "모험적임", "외향적임", "내향적임", "다정함", "책임감 있음", "열정적임", "차분함", "대담함",
        "사교적임", "예술적임", "운동을 좋아함", "음악 애호가", "책 읽기 좋아함", "여행 좋아함", "요리 잘함", "개방적임",
        "감성적임", "분석적임", "리더십 있음", "유순함", "친절함", "낙관적임", "현실적임", "야심적임", "창의적임",
        "공감 능력 있음", "독립적임", "질서를 좋아함", "결단력 있음", "치밀함", "성실함", "장난꾸러기", "활동적임",
        "도전적임", "사려 깊음", "배려심 있음", "논리적임", "명랑함", "쾌활함", "성취 지향적임", "집요함", "유연함",
        "적응력 있음", "낭만적임", "호기심 많음", "정직함", "모성애 있음", "부성애 있음"
    ]

    // MARK: - 초기화 (❗️companyViewModel을 반드시 초기화)
    init(companyViewModel: SelectCompanyViewModel = SelectCompanyViewModel()) {
        self.companyViewModel = companyViewModel
        self.companyViewModel.loadCompaniesData(filename: "companyMock")
    }
}

/*
 정적 프로퍼티 (static let defaultProperties) 로 불필요한 메모리 낭비 방지
 companyViewModel을 선택적으로 주입 가능하도록 개선
 allProperties를 defaultProperties에서 직접 가져오도록 최적화
 
 */
