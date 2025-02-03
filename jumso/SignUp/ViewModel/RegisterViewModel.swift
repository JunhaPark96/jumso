import Foundation
import SwiftUI
import MapKit

class RegisterViewModel: ObservableObject {
    @Published var navigationPath: [String] = [] { didSet { logStateChange("Navigation Path 변경") } }
    
    @Published var email: String = "" { didSet { logStateChange("Email 변경") } }
    @Published var selectedCompany: CompanyItem? { didSet { logStateChange("Selected Company 변경") } }
    @Published var selectedEmailDomain: String = "" { didSet { logStateChange("Selected Email Domain 변경") } }
    @Published var fullEmailAddress: String = "" { didSet { logStateChange("Full Email Address 변경") } }
    
    @Published var verificationCode: String = "" { didSet { logStateChange("Verification Code 변경") } }
    @Published var isVerifying: Bool = false { didSet { logStateChange("Is Verifying 변경") } }
    @Published var isCodeMatched: Bool = true { didSet { logStateChange("Is Code Matched 변경") } }
    
    @Published var password: String = "" { didSet { logStateChange("Password 변경") } }
    @Published var passwordConfirm: String = "" { didSet { logStateChange("Password Confirm 변경") } }
    
    @Published var name: String = "" { didSet { logStateChange("Name 변경") } }
    
    @Published var birthday: String = "" { didSet { logStateChange("Birthday 변경") } }
    
    @Published var gender: Sex? = nil { didSet { logStateChange("Gender 변경") } }
    
    @Published var profileData: [String: String] = [:] { didSet { logStateChange("Profile Data 변경") } }
    
    @Published var currentAddress: String = "" { didSet { logStateChange("Current Address 변경") } }
    @Published var currentCoordinates: CLLocationCoordinate2D? { didSet { logStateChange("Current Coordinates 변경") } }
    @Published var featureCoordinator = FeatureCoordinator()
    
    // (개인 이메일 인증 관련)
    @Published var isUsingPersonalEmail: Bool = false { didSet { logStateChange("개인 이메일 인증 여부 변경") } }
    @Published var personalEmailDomain: String = "" { didSet { logStateChange("개인 이메일 도메인 변경") } }
    
    private let signUpURL = "https://api.jumso.life/api/auth/signup"
    private let EnrollURL = "https://api.jumso.life/api/auth/enroll"
    
    // MARK: - 디버깅 로그 출력
    private func logStateChange(_ message: String) {
        print("🔄 [DEBUG] \(message): 현재 상태:")
        logCurrentSignUpData()
    }
    
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
    
    
    func logCurrentSignUpData() {
        print("""
                🔍 [DEBUG] RegisterViewModel 상태:
                    - Email: \(email)
                    - Selected Company: \(selectedCompany?.name ?? "None")
                    - Email Domain: \(selectedEmailDomain)
                    - Full Email Address: \(fullEmailAddress)
                    - Verification Code: \(verificationCode)
                    - Password: \(password)
                    - Name: \(name)
                    - BirthDay: \(birthday)
                    - Gender: \(gender == .MALE ? "Male" : gender == .FEMALE ? "Female" : "None")
                    - Profile Data: \(profileData)
                    - Current Address: \(currentAddress)
                    - Current Coordinates: \(currentCoordinates.map { "(\($0.latitude), \($0.longitude))" } ?? "None")
                """)
    }
    
    
    // MARK: 임시 회원 토큰 발급
    // ✅ 회원가입 API 요청 함수
    func signUpUser(completion: @escaping (Result<Void, Error>) -> Void) {
        guard !email.isEmpty, !password.isEmpty, !passwordConfirm.isEmpty, !name.isEmpty, let company = selectedCompany else {
            completion(.failure(NSError(domain: "Invalid Data", code: 400, userInfo: nil)))
            return
        }
        
        let requestData = SignUpRequest(
            username: fullEmailAddress, // ✅ 이메일 필드 변경
            password: password,
            passwordConfirm: passwordConfirm,
            nickname: name,
            companyEmailId: company.id
        )
        
        guard let jsonData = try? JSONEncoder().encode(requestData) else {
            completion(.failure(NSError(domain: "Encoding Error", code: 500, userInfo: nil)))
            return
        }
        
        var request = URLRequest(url: URL(string: signUpURL)!)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = jsonData
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            guard let data = data, let httpResponse = response as? HTTPURLResponse else {
                completion(.failure(NSError(domain: "No Response", code: 500, userInfo: nil)))
                return
            }
            
            if httpResponse.statusCode == 200 {
                if let accessToken = httpResponse.value(forHTTPHeaderField: "Authorization") {
                    // ✅ 임시 Access Token 저장 (이후 API 요청에 사용)
                    UserDefaults.standard.set(accessToken, forKey: "AccessToken")
                    print("✅ Access Token 저장 완료: \(accessToken)")
                }
                completion(.success(()))
            } else {
                completion(.failure(NSError(domain: "Signup Failed", code: httpResponse.statusCode, userInfo: nil)))
            }
        }.resume()
    }
    
    
    // MARK: Enroll API 로직
    func submitRegistration(completion: @escaping (Result<MemberResponse, Error>) -> Void) {
        guard let gender = gender,
              let coordinates = currentCoordinates,
              let minAge = profileData["최소 나이"].flatMap({ Int($0) }),
              let maxAge = profileData["최대 나이"].flatMap({ Int($0) }),
              let maxDistance = profileData["최대 거리"].flatMap({ Int($0.replacingOccurrences(of: " km", with: "")) })
        else {
            completion(.failure(NSError(domain: "Invalid Data", code: 400, userInfo: nil)))
            return
        }
        
        let requestData = EnrollRequest(
            bornAt: DateFormatterUtil.formatDateString(birthday),
            sex: Sex(rawValue: SignUpAPIMapper.getAPIValue(for: gender.rawValue, in: SignUpAPIMapper.genderMap)) ?? .MALE,
            height: Int(profileData["키를 알려주세요"]?.replacingOccurrences(of: " cm", with: "") ?? "0") ?? 0,
            bodyType: BodyType(rawValue: SignUpAPIMapper.getAPIValue(for: profileData["체형은 어떤가요?"] ?? "", in: SignUpAPIMapper.bodyTypeMap)) ?? .NONE,
            job: profileData["하는 일을 알려주세요"] ?? "",
            relationshipStatus: RelationshipStatus(rawValue: SignUpAPIMapper.getAPIValue(for: profileData["결혼 상태"] ?? "", in: SignUpAPIMapper.relationshipStatusMap)) ?? .SINGLE,
            religion: Religion(rawValue: SignUpAPIMapper.getAPIValue(for: profileData["종교"] ?? "", in: SignUpAPIMapper.religionMap)) ?? .NONE,
            smoke: Smoke(rawValue: SignUpAPIMapper.getAPIValue(for: profileData["흡연 여부"] ?? "", in: SignUpAPIMapper.smokeMap)) ?? .NONE,
            drink: Drink(rawValue: SignUpAPIMapper.getAPIValue(for: profileData["음주 여부"] ?? "", in: SignUpAPIMapper.drinkMap)) ?? .NONE,
            latitude: coordinates.latitude,
            longitude: coordinates.longitude,
            introduction: profileData["Introduction"] ?? "",
            whatSexDoYouWant: Sex(rawValue: SignUpAPIMapper.getAPIValue(for: profileData["원하는 성별"] ?? "", in: SignUpAPIMapper.genderMap)) ?? .MALE,
            howOldDoYouWantMin: minAge,
            howOldDoYouWantMax: maxAge,
            howFarCanYouGo: maxDistance,
            whatKindOfBodyTypeDoYouWant: BodyType(rawValue: SignUpAPIMapper.getAPIValue(for: profileData["원하는 체형"] ?? "", in: SignUpAPIMapper.bodyTypeMap)) ?? .NONE,
            whatKindOfRelationshipStatusDoYouWant: RelationshipStatus(rawValue: SignUpAPIMapper.getAPIValue(for: profileData["원하는 교제 상태"] ?? "", in: SignUpAPIMapper.relationshipStatusMap)) ?? .SINGLE,
            whatKindOfReligionDoYouWant: Religion(rawValue: SignUpAPIMapper.getAPIValue(for: profileData["원하는 종교"] ?? "", in: SignUpAPIMapper.religionMap)) ?? .NONE,
            whatKindOfSmokeDoYouWant: Smoke(rawValue: SignUpAPIMapper.getAPIValue(for: profileData["흡연 여부"] ?? "", in: SignUpAPIMapper.smokeMap)) ?? .NONE,
            whatKindOfDrinkDoYouWant: Drink(rawValue: SignUpAPIMapper.getAPIValue(for: profileData["음주 여부"] ?? "", in: SignUpAPIMapper.drinkMap)) ?? .NONE,
            propertyIds: featureCoordinator.selectedProperties.compactMap { Int($0) },
            notTheseCompanyIds: featureCoordinator.selectedCompanies.map { $0.id }
        )
        
        guard let jsonData = try? JSONEncoder().encode(requestData) else {
            completion(.failure(NSError(domain: "Encoding Error", code: 500, userInfo: nil)))
            return
        }
        
        var request = URLRequest(url: URL(string: EnrollURL)!)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = jsonData
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            guard let data = data else {
                completion(.failure(NSError(domain: "No Data", code: 500, userInfo: nil)))
                return
            }
            do {
                let responseData = try JSONDecoder().decode(MemberResponse.self, from: data)
                DispatchQueue.main.async {
                    completion(.success(responseData))
                }
            } catch {
                completion(.failure(error))
            }
        }.resume()
    }
    
}


