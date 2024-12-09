import SwiftUI

struct SignUpCompanySelectionView: View {
    @ObservedObject var viewModel: RegisterViewModel
    @State private var selectedCompanyIds: Set<Int> = [] // 선택된 회사 IDs
    @State private var searchText: String = "" // 검색 텍스트
    var onSelectionDone: ((Set<Int>) -> Void)? // 선택 완료 클로저
    
    var body: some View {
        VStack(spacing: 0) {
            // 헤더
            Text("회사 선택")
                .font(.title)
                .bold()
                .padding()
            
            // 검색창
            HStack {
                TextField("회사 이름을 입력하세요", text: $searchText)
                                    .onChange(of: searchText) { newValue in
                                        viewModel.searchCompanies(with: newValue)
                                    }
                .padding()
                .background(Color(.systemGray6))
                .cornerRadius(10)
                .padding(.horizontal)
            }
            
            // 회사 리스트
            List(viewModel.filteredCompanies, id: \.id) { company in
                HStack {
                    Text(company.name)
                    Spacer()
                    if selectedCompanyIds.contains(company.id) {
                        Image(systemName: "checkmark")
                            .foregroundColor(.blue)
                    }
                }
                .contentShape(Rectangle()) // 전체 영역 클릭 가능
                .onTapGesture {
                    toggleSelection(for: company.id)
                }
            }
            .listStyle(PlainListStyle())
            
            // 완료 버튼
            Button(action: {
                onSelectionDone?(selectedCompanyIds)
            }) {
                Text("완료")
                    .bold()
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }
            .padding()
        }
        .onAppear {
            viewModel.loadCompaniesData(filename: "companyMock")
        }
    }
    
    private func toggleSelection(for companyId: Int) {
        if selectedCompanyIds.contains(companyId) {
            selectedCompanyIds.remove(companyId)
        } else {
            selectedCompanyIds.insert(companyId)
        }
    }
}
