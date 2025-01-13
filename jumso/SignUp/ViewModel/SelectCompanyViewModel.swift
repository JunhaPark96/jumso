import Foundation
import Combine

class SelectCompanyViewModel: ObservableObject {
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
