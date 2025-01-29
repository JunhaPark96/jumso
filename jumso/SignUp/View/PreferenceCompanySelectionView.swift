import SwiftUI
import Foundation

struct PreferenceCompanySelectionView: View {
//    @ObservedObject var viewModel: SelectCompanyViewModel
//    @Binding var selectedCompanies: Set<CompanyItem>
    @EnvironmentObject var coordinator: FeatureCoordinator
    
    var body: some View {
        List(coordinator.companyViewModel.filteredCompanies) { company in
            MultipleSelectionRow(
                title: company.name,
                isSelected: coordinator.selectedCompanies.contains(company)
            ) {
                if coordinator.selectedCompanies.contains(company) {
                    coordinator.selectedCompanies.remove(company)
                } else {
                    coordinator.selectedCompanies.insert(company)
                }
            }
        }
        .onAppear {
            coordinator.companyViewModel.searchCompanies(with: "")
        }
    }
}
