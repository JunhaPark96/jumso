import SwiftUI

struct SignUpRegisterView: View {
    @ObservedObject var viewModel = RegisterViewModel()
    @State private var searchText: String = ""
    @State private var selectedCompany: CompanyItem? = nil

    var body: some View {
        NavigationView {
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
                        }
                        .padding(8)
                        .background(Color(.systemGray6))
                        .cornerRadius(12)
                    
                    Button(action: {
                        searchText = ""
                        viewModel.searchCompanies(with: "")
                    }) {
                        Image(systemName: "xmark.circle.fill")
                            .foregroundColor(.gray)
                    }
                }
                .padding()
                
                // 회사 리스트
                List(viewModel.filteredCompanies, id: \.id) { company in
                    Button(action: {
                        selectedCompany = company
                    }) {
                        Text(company.name)
                    }
                }
                .listStyle(PlainListStyle())
                
                // NavigationLink를 통해 EmailAuthenticationView로 이동
                //                NavigationLink(
                //                    destination: Group {
                //                        if let selectedCompany = selectedCompany {
                //                            EmailAuthenticationView(company: selectedCompany)
                //                        } else {
                //                            EmptyView() // 선택된 회사가 없는 경우 빈 뷰
                //                        }
                //                    },
                //                    isActive: Binding(
                //                        get: { selectedCompany != nil },
                //                        set: { if !$0 { selectedCompany = nil } }
                //                    )
                //                ) {
                //                    EmptyView()
                //                }
            }
            .onAppear {
                viewModel.loadCompaniesData(filename: "companyMock")
            }
            .navigationDestination(for: CompanyItem.self) { company in
                EmailAuthenticationView(company: company)
            }
            .onChange(of: selectedCompany) { company in
                if let company = company {
                    // Push navigation using selected company
                    navigateTo(company: company)
                }
            }
        }
    }
    private func navigateTo(company: CompanyItem) {
            selectedCompany = company
        }
}
