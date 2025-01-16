import Foundation
import SwiftUI

class RegisterViewModel: ObservableObject {
//    @Published var navigationPath = NavigationPath()
    @Published var navigationPath: [String] = [] // String 배열로 경로 관리
    @Published var email: String = ""
    @Published var selectedCompany: CompanyItem?
    @Published var selectedEmailDomain: String = ""
    @Published var fullEmailAddress: String = ""
    @Published var verificationCode: String = "" // 인증코드저장
    @Published var isVerifying: Bool = false // 인증 결과
    
    
    
    // 디버깅 메시지 출력
    private func logVerificationState(inputCode: String) {
        print("🔑 [DEBUG] 입력한 코드: \(inputCode), 서버 코드: \(verificationCode)")
    }
    
    private func handleVerificationError(_ error: Error) {
        print("❌ [DEBUG] 인증 실패: \(error.localizedDescription)")
    }
    // 서버로 이메일 인증 요청
    func requestEmailVerification(completion: @escaping (Result<Void, Error>) -> Void) {
        guard !fullEmailAddress.isEmpty else {
            print("❌ 이메일 주소가 없습니다.")
//            completion(false)
            completion(.failure(NSError(domain: "", code: 400, userInfo: [NSLocalizedDescriptionKey: "이메일 주소가 없습니다."])))
            return
        }
        
        // 서버로 인증 코드 요청 (가짜 API 호출 시뮬레이션)
        print("📧 [DEBUG] 이메일 인증 요청: \(fullEmailAddress)")
        DispatchQueue.global().asyncAfter(deadline: .now() + 2) {
            // 서버 응답 시뮬레이션: 성공
            DispatchQueue.main.async {
                self.verificationCode = "123456"
//                completion(true)
                completion(.success(()))
                print("✅ [DEBUG] 인증 코드가 이메일로 전송되었습니다.")
            }
        }
    }
    
    // 서버로 인증 코드 확인 요청
    func verifyCode(inputCode: String, completion: @escaping (Result<Void, Error>) -> Void) {
        guard !verificationCode.isEmpty else {
            completion(.failure(NSError(domain: "", code: 400, userInfo: [NSLocalizedDescriptionKey: "서버로 받은 인증 코드가 없습니다."])))
            return
        }
        
        print("🔑 [DEBUG] 입력한 코드: \(inputCode), 서버 코드: \(verificationCode)")
        DispatchQueue.global().asyncAfter(deadline: .now() + 1) {
            DispatchQueue.main.async {
                if inputCode == self.verificationCode {
                    self.isVerifying = true
                    completion(.success(()))
                    print("✅ [DEBUG] 인증 성공")
                } else {
                    self.isVerifying = false
                    completion(.failure(NSError(domain: "", code: 401, userInfo: [NSLocalizedDescriptionKey: "인증 코드가 올바르지 않습니다."])))
                    print("❌ [DEBUG] 인증 실패")
                }
            }
        }
    }

    
    // 서버로 데이터를 전송하는 메서드
    func submitRegistration() {
        guard !email.isEmpty, let company = selectedCompany else {
            print("❌ 유효하지 않은 데이터")
            return
        }
        
        let registrationData = [
            "email": fullEmailAddress,
            "company": company.name
        ]
        print("🚀 회원가입 데이터 전송: \(registrationData)")
        // 서버 전송 로직 추가
    }
}
