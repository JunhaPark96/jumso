
import Foundation

struct CompanyResponse: Codable {
    let result: Int
    let data: CompanyData
}

struct CompanyData: Codable {
    let companies: [CompanyItem]
}

// MARK: company model
struct CompanyItem: Codable {
    let id: Int
    let name: String
    let alias: String?
    let color: String
    let emails: [String]
    let enabled: Bool
    let scale: String?
    let order: String?
    let logo_url: String?
}

