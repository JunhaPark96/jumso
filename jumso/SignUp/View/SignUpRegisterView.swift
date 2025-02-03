import SwiftUI

struct SignUpRegisterView: View {
    @ObservedObject var viewModel = SelectCompanyViewModel()
    @EnvironmentObject var registerViewModel: RegisterViewModel // 중앙 데이터 관리
    @StateObject var coordinator = FeatureCoordinator()
    @State private var searchText: String = ""
    //    @State private var navigationPath = NavigationPath() // Navigation Path 관리
    
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
                        if registerViewModel.selectedCompany != nil {
                            SignUpEmailAuthenticationView()
                                .environmentObject(registerViewModel)
                        } else {
                            Text(NSLocalizedString("company_selection_required", comment: "회사 선택이 필요합니다."))
                                .font(.title2)
                                .foregroundColor(.red)
                        }
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
