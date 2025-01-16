//import SwiftUI
//
//struct SignUpCompanySelectionView: View {
//    @EnvironmentObject var registerViewModel: RegisterViewModel // 중앙 데이터 관리
//    @ObservedObject var SelectedCompanyViewModel: SelectCompanyViewModel // 회사 검색 및 필터링 관리
//    @Binding var navigationPath: NavigationPath // 외부 NavigationPath와 연결
//    
//    @State private var selectedCompanyIds: Set<Int> = [] // 선택된 회사 IDs
//    @State private var searchText: String = "" // 검색 텍스트
//    var onSelectionDone: ((Set<Int>) -> Void)? // 선택 완료 클로저
//    
//    var body: some View {
//        VStack(spacing: 0) {
//            // 헤더
//            Text("회사 선택")
//                .font(.title)
//                .bold()
//                .padding()
//            
//            // 검색창
//            HStack {
//                TextField("회사 이름을 입력하세요", text: $searchText)
//                    .onChange(of: searchText) { newValue in
//                        SelectedCompanyViewModel.searchCompanies(with: newValue)
//                        print("🔍 [DEBUG] 검색 텍스트 변경: \(newValue)")
//                    }
//                    .padding()
//                    .background(Color(.systemGray6))
//                    .cornerRadius(10)
//                    .padding(.horizontal)
//            }
//            
//            // 회사 리스트
//            List(SelectedCompanyViewModel.filteredCompanies, id: \.id) { company in
//                HStack {
//                    Text(company.name)
//                    Spacer()
//                    if selectedCompanyIds.contains(company.id) {
//                        Image(systemName: "checkmark")
//                            .foregroundColor(.blue)
//                    }
//                }
//                .contentShape(Rectangle()) // 전체 영역 클릭 가능
//                .onTapGesture {
//                    toggleSelection(for: company.id)
//                }
//            }
//            .listStyle(PlainListStyle())
//            
//            // 완료 버튼
//            Button(action: {
//                if let selectedCompany = SelectedCompanyViewModel.filteredCompanies.first(where: { selectedCompanyIds.contains($0.id) }) {
//                        registerViewModel.selectedCompany = selectedCompany
//                        registerViewModel.selectedEmailDomain = selectedCompany.emails.first ?? ""
//                    
//                        print("✅ [DEBUG] 선택된 회사: \(selectedCompany.name)")
//                        print("✅ [DEBUG] 선택된 이메일 도메인: \(registerViewModel.selectedEmailDomain)")
//                    
//                        navigationPath.append("EmailAuthenticationStep")
//                    } else {
//                        print("❌ 선택된 회사가 없습니다.")
//                    }
//            }) {
//                Text("완료")
//                    .bold()
//                    .frame(maxWidth: .infinity)
//                    .padding()
//                    .background(Color.blue)
//                    .foregroundColor(.white)
//                    .cornerRadius(10)
//            }
//            .padding()
//        }
//        .onAppear {
//            SelectedCompanyViewModel.loadCompaniesData(filename: "companyMock")
//            print("📂 [DEBUG] 회사 데이터 로드 중...")
//        }
//    }
//    
//    private func toggleSelection(for companyId: Int) {
//        if selectedCompanyIds.contains(companyId) {
//            selectedCompanyIds.remove(companyId)
//            print("🗑 [DEBUG] 회사 선택 해제: \(companyId)")
//        } else {
//            selectedCompanyIds.insert(companyId)
//            print("✔️ [DEBUG] 회사 선택: \(companyId)")
//        }
//    }
//}
