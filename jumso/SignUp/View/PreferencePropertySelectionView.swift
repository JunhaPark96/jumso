
import Foundation
import SwiftUI

struct PreferencePropertySelectionView: View {
//    let allProperties: [String]
//    @Binding var selectedProperties: Set<String>
    @EnvironmentObject var coordinator: FeatureCoordinator
    
    var body: some View {
        List(coordinator.allProperties, id: \.self) { property in
            MultipleSelectionRow(
                title: property,
                isSelected: coordinator.selectedProperties.contains(property)
            ) {
                if coordinator.selectedProperties.contains(property) {
                    coordinator.selectedProperties.remove(property)
                } else {
                    coordinator.selectedProperties.insert(property)
                }
            }
        }
    }
}
