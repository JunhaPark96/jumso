import SwiftUI
import Foundation

struct PreferenceCompanySelectionView: View {
    @ObservedObject var viewModel: SelectCompanyViewModel
    @Binding var selectedCompanies: Set<CompanyItem>
    
    var body: some View {
        List(viewModel.filteredCompanies) { company in
            MultipleSelectionRow(
                title: company.name,
                isSelected: selectedCompanies.contains(company)
            ) {
                if selectedCompanies.contains(company) {
                    selectedCompanies.remove(company)
                } else {
                    selectedCompanies.insert(company)
                }
            }
        }
        .onAppear {
            viewModel.searchCompanies(with: "")
        }
    }
}
