import SwiftUI

struct SignUpRegisterView: View {
    @ObservedObject var viewModel = SelectCompanyViewModel()
    @EnvironmentObject var registerViewModel: RegisterViewModel // 중앙 데이터 관리
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
                        
                        registerViewModel.navigationPath.append("EmailAuthenticationStep")
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
            }

//            .navigationDestination(for: String.self) { step in
//                if step == "EmailAuthenticationStep" {
//                    if registerViewModel.selectedCompany != nil {
//                        SignUpEmailAuthenticationView(navigationPath: $navigationPath)
//                            .environmentObject(registerViewModel)
//                    } else {
//                        Text("회사 선택이 필요합니다.")
//                            .font(.title2)
//                            .foregroundColor(.red)
//                    }
//                }
//            }
            .navigationDestination(for: String.self) { step in
                switch step {
                case "EmailAuthenticationStep":
                    if registerViewModel.selectedCompany != nil {
//                        SignUpEmailAuthenticationView(navigationPath: registerViewModel.navigationPath)
                        SignUpEmailAuthenticationView()
                            .environmentObject(registerViewModel)
                    } else {
                        Text("회사 선택이 필요합니다.")
                            .font(.title2)
                            .foregroundColor(.red)
                    }
                case "VerificationStep":
//                    SignUpAuthenticationCodeView(navigationPath: $registerViewModel.navigationPath)
                    SignUpAuthenticationCodeView()
                        .environmentObject(registerViewModel)
                default:
                    EmptyView()
                }
            }

            
        }
    }
}


//struct SignUpRegisterView_Previews: PreviewProvider {
//    static var previews: some View {
//        SignUpRegisterView()
//            .environmentObject(RegisterViewModel()) // 미리보기에서도 환경 객체 제공
//    }
//}
