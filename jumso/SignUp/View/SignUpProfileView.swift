import SwiftUI

struct SignUpProfileView: View {
    // MARK: - 상태 변수
    @State private var selectedOptions: [String: String] = [:]
    @State private var jobTitle: String = ""
    
    @State private var isButtonEnabled: Bool = false
    @State private var navigateToNextView: Bool = false
    @State private var keyboardHeight: CGFloat = 0
    @StateObject private var keyboardManager = KeyboardManager.shared
    
    // ProgressBar 상태
    private let totalSignUpSteps = 8
    private let currentSignUpStep = 4
    
    var body: some View {
        NavigationStack {
            ZStack(alignment: .bottom) {
                VStack(spacing: 0) {
                    // Progress Bar
                    ProgressView(value: Float(currentSignUpStep) / Float(totalSignUpSteps))
                        .progressViewStyle(LinearProgressViewStyle(tint: .blue))
                        .padding(.top, 30)
                        .padding(.horizontal, 16)
                    
                    GeometryReader { geometry in
                        VStack(alignment: .leading, spacing: 20) {
                            SignUpHeaderView(title: "프로필 작성")
                            
                            ScrollView {
                                LazyVStack(alignment: .leading, spacing: 16) {
                                    ForEach(ProfileSection.allCases, id: \.self) { section in
                                        VStack(alignment: .leading, spacing: 10) {
                                            ProfileHeaderView(title: section.rawValue)
                                                .frame(maxWidth: .infinity, alignment: .leading)
                                            
                                            ProfileContentView(section: section, selectedOptions: $selectedOptions, jobTitle: $jobTitle)
                                                .frame(maxWidth: .infinity)
                                        }
                                        .padding()
                                        .background(Color.white)
                                        .cornerRadius(12)
                                        .shadow(color: Color.gray.opacity(0.2), radius: 4, x: 0, y: 2)
                                    }
                                }
                                .padding(.bottom, 100)
                            }
                        }
                        .frame(width: geometry.size.width, height: geometry.size.height)
                    }
                    .padding(.top, 30)
//                    .padding(.bottom, 100)
                    

                }
                // MARK: 다음 버튼 섹션
                VStack {
                    Spacer()
                    SignUpReusableButton(title: "다음", isEnabled: isButtonEnabled) {
                        handleNextButtonTap()
                    }
                    .disabled(!isButtonEnabled)
                    .padding(.bottom, keyboardManager.keyboardHeight > 0 ? 10 : UIScreen.main.bounds.height / 30)
                    .animation(.easeOut(duration: 0.3), value: keyboardManager.keyboardHeight)
                    
                }
                .navigationBarTitleDisplayMode(.inline)
                .navigationBarBackButtonHidden(true)
                .navigationDestination(isPresented: $navigateToNextView) {
                    SignUpLocationView()
                }
                
            } // 가장 바깥쪽 Vstack
            .onTapGesture {
                keyboardManager.hideKeyboard()
            }
            
            .onAppear {
                // 키보드 관찰자 시작
                KeyboardObserver.shared.startListening { height in
                    SignUpDebugLog.debugLog("키보드 높이 업데이트: \(height)")
                    //                    print("키보드 높이 업데이트: \(height)")
                    withAnimation(.easeOut(duration: 0.3)){
                        keyboardHeight = height
                    }
                }
            }
            
            .onDisappear {
                // 키보드 관찰자 해제
                KeyboardObserver.shared.stopListening()
            }
            
            .onChange(of: selectedOptions) { _ in
                isButtonEnabled = isFormValid()
            }
            .onChange(of: jobTitle) { _ in
                isButtonEnabled = isFormValid()
            }
        }
    }
    
//    private func isFormValid() -> Bool {
//        let requiredFields = ProfileSection.BasicInfoRow.allCases.map { $0.rawValue } +
//        ProfileSection.AdditionalInfoRow.allCases.map { $0.rawValue }
//        
//        return requiredFields.allSatisfy { selectedOptions[$0] != nil } && !jobTitle.isEmpty
//    }
    
    private func isFormValid() -> Bool {
        let requiredFields = ProfileSection.BasicInfoRow.allCases.map { $0.rawValue } +
        ProfileSection.AdditionalInfoRow.allCases.map { $0.rawValue }
        
        return requiredFields.allSatisfy { selectedOptions[$0] != nil } && !jobTitle.isEmpty
    }

    
    // MARK: - 버튼 동작
    private func handleNextButtonTap() {
        navigateToNextView = true
    }
    
}

struct ProfileHeaderView: View {
    var title: String
    
    var body: some View {
        Text(title)
            .font(.headline)
//            .foregroundColor(.black)
            .foregroundColor(.white)
            .padding(.vertical, 3)
            .padding(.horizontal, 16)
            .background(Color.jumso)
            .clipShape(RoundedRectangle(cornerRadius: 3), style: /*@START_MENU_TOKEN@*/FillStyle()/*@END_MENU_TOKEN@*/)
        
    }
}



struct ProfileContentView: View {
    var section: ProfileSection
    @Binding var selectedOptions: [String: String]
    @Binding var jobTitle: String
    
    var body: some View {
        switch section {
        case .basicInfo:
            ForEach(ProfileSection.BasicInfoRow.allCases, id: \.self) { row in
                ProfileDropdownCell(
                    title: row.rawValue,
                    options: getOptions(for: row),
                    selectedOption: $selectedOptions[row.rawValue]
                )
            }
        case .jobInfo:
            TextField(ProfileSection.JobInfoRow.jobTitle.rawValue, text: $jobTitle)
                .textFieldStyle(RoundedBorderTextFieldStyle())
        case .additionalInfo:
            ForEach(ProfileSection.AdditionalInfoRow.allCases, id: \.self) { row in
                ProfileDropdownCell(
                    title: row.rawValue,
                    options: getOptions(for: row),
                    selectedOption: $selectedOptions[row.rawValue]
                )
            }
        }
    }
    
    private func getOptions(for row: Any) -> [String] {
        switch row {
        case ProfileSection.BasicInfoRow.height:
            return (100...300).map { "\($0) cm" }
        case ProfileSection.BasicInfoRow.bodyType:
            return ["살짝 근육", "마름", "통통한편", "완전 근육"]
        case ProfileSection.AdditionalInfoRow.maritalStatus:
            return ["미혼", "기혼", "돌싱"]
        case ProfileSection.AdditionalInfoRow.religion:
            return ["무교", "기독교", "불교", "천주교", "기타"]
        case ProfileSection.AdditionalInfoRow.smoking:
            return ["흡연", "비흡연"]
        case ProfileSection.AdditionalInfoRow.drinking:
            return ["음주", "금주"]
        default:
            return []
        }
    }
}


// MARK: - ProfileDropdownCell
struct ProfileDropdownCell: View {
    var title: String
    var options: [String]
    @Binding var selectedOption: String?
    
    var body: some View {
        HStack {
            Text(title)
                .font(.body)
            
            Spacer()
            
            Menu {
                ForEach(options, id: \.self) { option in
                    Button(action: {
                        selectedOption = option
                    }) {
                        Text(option)
                    }
                }
            } label: {
                Text(selectedOption ?? "선택")
                    .foregroundColor(.gray)
                    .padding(.horizontal, 8)
                    .frame(height: 30)
                    .background(Color(.systemGray6))
                    .cornerRadius(5)
            }
        }
    }
}



//struct SignUpProfileView_Previews: PreviewProvider {
//    static var previews: some View {
//        SignUpProfileView()
//    }
//}


