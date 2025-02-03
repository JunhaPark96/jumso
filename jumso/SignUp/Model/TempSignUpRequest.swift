import Foundation

struct SignUpRequest: Codable {
    let username: String  // 이메일
    let password: String
    let passwordConfirm: String
    let nickname: String  // 이름 (닉네임)
    let companyEmailId: Int  // 회사 ID
}

struct SignUpResponse: Codable {
    let email: String
    let nickname: String
}
