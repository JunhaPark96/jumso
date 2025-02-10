import SwiftUI

struct SignUpRegisterView: View {
    @ObservedObject var viewModel = SelectCompanyViewModel()
    @EnvironmentObject var registerViewModel: RegisterViewModel // 중앙 데이터 관리
    @StateObject var coordinator = FeatureCoordinator()
    @State private var searchText: String = ""
    
    var body: some View {
        NavigationStack(path: $registerViewModel.navigationPath) { // Navigation Path와 연결
            VStack(spacing: 0) {
                // 헤더
                Text("내 회사 찾기")
                    .font(.title)
                    .bold()
                    .padding()
                
                // 검색 바
                HStack {
                    Image(systemName: "magnifyingglass")
                        .foregroundColor(.orange)
                    
                    TextField("회사 검색", text: $searchText)
                        .onChange(of: searchText) { newValue in
                            viewModel.searchCompanies(with: newValue)
                            print("🔍 검색 텍스트 변경: \(newValue)")
                        }
                        .padding(8)
                        .background(Color(.systemGray6))
                        .cornerRadius(12)
                        .autocapitalization(.none)
                    
                    Button(action: {
                        searchText = ""
                        viewModel.searchCompanies(with: "")
                        print("🔄 검색 초기화")
                    }) {
                        Image(systemName: "xmark.circle.fill")
                            .foregroundColor(.gray)
                    }
                }
                .padding()
                // 회사가 없을 경우 개인 이메일 사용 옵션
                VStack {
                    Button(action: {
                        registerViewModel.isUsingPersonalEmail.toggle()
                        if registerViewModel.isUsingPersonalEmail {
                            registerViewModel.selectedCompany = nil
                            registerViewModel.selectedEmailDomain = ""
                        }
                    }) {
                        Text(registerViewModel.isUsingPersonalEmail ? "회사 이메일로 인증하기" : "목록에 회사가 없나요?")
                            .font(.callout)
                            .foregroundColor(.blue)
                            .underline()
                    }
                    .padding(.top, 10)
                    
                    if registerViewModel.isUsingPersonalEmail {
                        VStack(alignment: .leading, spacing: 10) {
                            Text("개인 이메일 입력")
                                .font(.headline)
                                .fontWeight(.bold)
                            
                            TextField("example@gmail.com", text: $registerViewModel.personalEmailDomain)
                                .padding()
                                .background(Color(.systemGray6))
                                .cornerRadius(10)
                                .autocapitalization(.none)
                                .keyboardType(.emailAddress)
                            
                            Button(action: {
                                guard !registerViewModel.personalEmailDomain.isEmpty else { return }
                                // ✅ 개인 이메일 인증 → 바로 인증 코드 화면으로 이동
                                registerViewModel.requestPersonalEmailVerification { result in
                                        switch result {
                                        case .success:
                                            print("📧 [DEBUG] 개인 이메일 인증 요청 성공")
                                            registerViewModel.navigationPath.append(NavigationStep.authenticationCode.rawValue)
                                        case .failure(let error):
                                            print("❌ [DEBUG] 개인 이메일 인증 요청 실패: \(error.localizedDescription)")
                                        }
                                    }
                                }) {
                                Text("이메일 인증 요청")
                                    .font(.headline)
                                    .frame(maxWidth: .infinity)
                                    .padding()
                                    .background(Color.blue)
                                    .foregroundColor(.white)
                                    .cornerRadius(10)
                            }
                            .disabled(registerViewModel.personalEmailDomain.isEmpty)
                        }
                        .padding()
                    }
                }
                
                
                // 회사 리스트
                List(viewModel.filteredCompanies, id: \.id) { company in
                    Button(action: {
                        registerViewModel.selectedCompany = company
                        registerViewModel.selectedEmailDomain = company.emails.first ?? ""
                        print("✅ [DEBUG] 선택된 회사: \(company.name)")
                        print("✅ [DEBUG] 선택된 이메일 도메인: \(registerViewModel.selectedEmailDomain)")
                        
                        registerViewModel.navigationPath.append(NavigationStep.emailAuthentication.rawValue)
                    }) {
                        Text(company.name)
                    }
                }
                .listStyle(PlainListStyle())
            }
            .onAppear {
                viewModel.loadCompaniesData(filename: "companyMock")
                print("📂 [DEBUG] 회사 데이터 로드 중...")
            }
            .onChange(of: registerViewModel.navigationPath) { newValue in
                print("📍 [DEBUG] navigationPath 변경: \(newValue)")
                registerViewModel.logCurrentSignUpData()
            }
            
            .navigationDestination(for: String.self) { step in
                if let stepEnum = NavigationStep(rawValue: step) {
                    switch stepEnum {
                    case .emailAuthentication:
                        SignUpEmailAuthenticationView()
                            .environmentObject(registerViewModel)
                    case .authenticationCode:
                        SignUpAuthenticationCodeView()
                            .environmentObject(registerViewModel)
                        
                    case .password:
                        SignUpPasswordView()
                            .environmentObject(registerViewModel)
                    case .name:
                        SignUpNameView()
                            .environmentObject(registerViewModel)
                    case .birthDay:
                        SignUpBirthDayView()
                            .environmentObject(registerViewModel)
                    case .gender:
                        SignUpGenderView()
                            .environmentObject(registerViewModel)
                    case .profile:
                        SignUpProfileView()
                            .environmentObject(registerViewModel)
                    case .location:
                        SignUpLocationView()
                            .environmentObject(registerViewModel)
                    case .introduction:
                        SignUpIntroductionView()
                            .environmentObject(registerViewModel)
                    case .preference:
                        SignUpPreferenceView()
                            .environmentObject(registerViewModel)
                            .environmentObject(coordinator)
                    case .propertySelection:
                        PreferencePropertySelectionView()
                        //                        allProperties: coordinator.allProperties,
                        //                        selectedProperties: $coordinator.selectedProperties
                            .environmentObject(coordinator)
                        
                    case .companySelection:
                        PreferenceCompanySelectionView()
                        //                        viewModel: coordinator.companyViewModel,
                        //                        selectedCompanies: $coordinator.selectedCompanies
                            .environmentObject(coordinator)
                    case .complete:
                        SignUpCompleteView()
                            .environmentObject(registerViewModel)
                    }
                }
                
            }
        }
    }
}


enum NavigationStep: String {
    case emailAuthentication = "EmailAuthenticationStep"
    case authenticationCode = "AuthenticationCodeStep"
    case password = "PasswordStep"
    case name = "NameStep"
    case birthDay = "BirthDayStep"
    case gender = "GenderStep"
    case profile = "ProfileStep"
    case location = "LocationStep"
    case introduction = "IntroductionStep"
    case preference = "PreferenceStep"
    case propertySelection = "PropertySelection"
    case companySelection = "CompanySelection"
    case complete = "CompleteStep"
}

//struct SignUpRegisterView_Previews: PreviewProvider {
//    static var previews: some View {
//        SignUpRegisterView()
//            .environmentObject(RegisterViewModel()) // 미리보기에서도 환경 객체 제공
//    }
//}
