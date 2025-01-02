//import Foundation
//
//class RegisterViewModel {
//    
//    // MARK: JSON 파일 불러오기 ---------------------------------------------
//    var allCompanies: [CompanyItem] = [] {
//        didSet {
//            // 데이터가 업데이트되면 View에 알림 (콜백)
//            filteredCompanies = allCompanies
//        }
//    }
//    
//    var filteredCompanies: [CompanyItem] = [] {
//        didSet {
//            onCompaniesUpdated?()
//        }
//    }
//    
//    var onCompaniesUpdated: (() -> Void)? // View에 알림을 위한 클로저
//    
//    // 회사 데이터를 JSON 파일에서 로드하고 디코딩
//    func loadCompaniesData(filename: String) {
//        guard let fileUrl = Bundle.main.url(forResource: filename, withExtension: "json") else {
//            print("파일 경로를 찾을 수 없습니다.")
//            return
//        }
//        
//        do {
//            let data = try Data(contentsOf: fileUrl)
//            decodeCompanyItems(from: data)
//        } catch {
//            print("JSON 파일을 불러오는 중 에러 발생: \(error)")
//        }
//    }
//    
//    // JSON 디코딩
//    private func decodeCompanyItems(from data: Data) {
//        let decoder = JSONDecoder()
//        do {
//            let companyResponse = try decoder.decode(CompanyResponse.self, from: data)
//            self.allCompanies = companyResponse.data.companies // 데이터 업데이트
//        } catch {
//            print("JSON 파싱 에러 \(error)")
//        }
//    }
//    
//    // 검색
//    func searchCompanies(with companyName: String) {
//        if companyName.isEmpty {
//            filteredCompanies = allCompanies
//        } else {
//            filteredCompanies = allCompanies.filter {
//                $0.name.localizedCaseInsensitiveContains(companyName) // 대소문자, 언어 구애받지 않음
//            }
//            print("RegisterViewModel: 검색된 회사는 \(companyName)")
//        }
//    }
//}


import Foundation
import Combine

class RegisterViewModel: ObservableObject {
    // JSON에서 로드한 전체 회사 리스트
    @Published var allCompanies: [CompanyItem] = [] {
        didSet {
            // 데이터가 업데이트되면 필터링된 리스트를 초기화
            filteredCompanies = allCompanies
        }
    }
    
    // 검색 결과에 따라 필터링된 회사 리스트
    @Published var filteredCompanies: [CompanyItem] = []
    
    // JSON 데이터 로드
    func loadCompaniesData(filename: String) {
        guard let fileUrl = Bundle.main.url(forResource: filename, withExtension: "json") else {
            print("❌ 파일 경로를 찾을 수 없습니다.")
            return
        }
        
        do {
            let data = try Data(contentsOf: fileUrl)
            decodeCompanyItems(from: data)
            print("✅ JSON 데이터 로드 성공: \(allCompanies.count)개 회사")
        } catch {
            print("❌ JSON 파일을 불러오는 중 에러 발생: \(error)")
        }
    }

    
    // JSON 디코딩
    private func decodeCompanyItems(from data: Data) {
        let decoder = JSONDecoder()
        do {
            let companyResponse = try decoder.decode(CompanyResponse.self, from: data)
            self.allCompanies = companyResponse.data.companies
        } catch {
            print("❌ JSON 파싱 에러: \(error)")
        }
    }
    
    // 검색
    func searchCompanies(with companyName: String) {
        if companyName.isEmpty {
            filteredCompanies = allCompanies
        } else {
            filteredCompanies = allCompanies.filter {
                $0.name.localizedCaseInsensitiveContains(companyName)
            }
            print("🔍 검색된 회사 이름: \(companyName)")
            print("🔍 필터링된 회사: \(filteredCompanies.map { $0.name })")
        }
    }

}
