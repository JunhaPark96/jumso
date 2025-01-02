import SwiftUI

struct SignUpHeaderView: View {
    var title: String
    
    var body: some View {
        Text(title)
            .font(.title)
            .fontWeight(.bold)
            .padding(.horizontal, 16)
//            .padding(.top, 30)
    }
        
}
