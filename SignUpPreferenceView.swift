import SwiftUI

struct SignUpPreferenceView: View {
    @EnvironmentObject var registerViewModel: RegisterViewModel
    @EnvironmentObject var coordinator: FeatureCoordinator
    // MARK: - 상태 변수
    @State private var isButtonEnabled: Bool = false
    @State private var navigateToNextView: Bool = false
    @State private var keyboardHeight: CGFloat = 0
    @StateObject private var keyboardManager = KeyboardManager.shared
    
    @State private var selectedOptions: [String: String] = [:]
    @State private var ageMin: Float = 18
    @State private var ageMax: Float = 35
    @State private var maxDistance: Float = 50
    @State private var selectedProperties: Set<String> = []
    @State private var selectedCompanies: Set<CompanyItem> = []
    
    // ProgressBar 상태
    private let currentSignUpStep = SignUpStep.allCases.firstIndex(of: .preference) ?? 0
    
    var body: some View {
        ZStack(alignment: .bottom) {
            VStack(spacing: 0) {
                // ✅ Progress Bar
                ProgressView(value: Float(currentSignUpStep) / Float(SignUpStep.allCases.count))
                    .progressViewStyle(LinearProgressViewStyle(tint: .blue))
                    .padding(.top, 30)
                    .padding(.horizontal, 16)
                
                GeometryReader { geometry in
                    VStack(alignment: .leading, spacing: 20){
                        // ✅ Header
                        SignUpHeaderView(title: "어떤 사람을 만나고 싶으세요?")
                        
                        // ✅ 섹션 리스트
                        List {
                            // 🔹 기본 정보 섹션
                            Section(header: Text("기본 정보").font(.headline)) {
                                SignUpProfileDropdownCell(
                                    title: "원하는 성별",
                                    options: SignUpOptions.genders,
                                    selectedOption: $selectedOptions["원하는 성별"]
                                )
                                
                                SignUpSliderCell(title: "최소 나이", value: $ageMin, range: SignUpConstants.minAge...SignUpConstants.maxAge, unit: "살")
                                SignUpSliderCell(title: "최대 나이", value: $ageMax, range: SignUpConstants.minAge...SignUpConstants.maxAge, unit: "살")
                                SignUpSliderCell(title: "최대 거리", value: $maxDistance, range: SignUpConstants.minDistance...SignUpConstants.maxDistance, unit: "km")
                            }
                            
                            // 🔹 추가 정보 섹션
                            Section(header: Text("추가 정보").font(.headline)) {
                                SignUpProfileDropdownCell(title: "원하는 체형", options: ProfileOptions.bodyType, selectedOption: $selectedOptions["원하는 체형"])
                                SignUpProfileDropdownCell(title: "원하는 교제 상태", options: ProfileOptions.maritalStatus, selectedOption: $selectedOptions["원하는 교제 상태"])
                                SignUpProfileDropdownCell(title: "원하는 종교", options: ProfileOptions.religion, selectedOption: $selectedOptions["원하는 종교"])
                            }
                            
                            // 🔹 특성 선택 섹션
                            Section(header: Text("특성 선택").font(.headline)) {
                                Button(action: {
                                    registerViewModel.navigationPath.append(NavigationStep.propertySelection.rawValue) // ✅ 네비게이션 경로 추가
                                }) {
                                    Text("특성 선택하기 (\(coordinator.selectedProperties.count))")
                                }
                                .buttonStyle(PlainButtonStyle()) // ✅ 스타일 적용
                            }
                            
                            // 🔹 회사 선택 섹션
                            
                            Section(header: Text("만나기 싫은 회사 선택").font(.headline)) {
                                Button(action: {
                                    registerViewModel.navigationPath.append(NavigationStep.companySelection.rawValue) // ✅ 네비게이션 경로 추가
                                }) {
                                    Text("회사 선택하기 (\(coordinator.selectedCompanies.count))")
                                }
                                .buttonStyle(PlainButtonStyle()) // ✅ 스타일 적용
                            }
                        }
                        //                        .listStyle(.grouped)
                        .listStyle(InsetGroupedListStyle())
                        
                        
                    } // VStack end
                    
                } // GeometryReader end
                .padding(.bottom, 100)
                .padding(.top, 30)
                .background(Color.white)
                
            }
            VStack {
                Spacer()
                SignUpReusableButton(title: "다음", isEnabled: isButtonEnabled) {
                    // 데이터를 RegisterViewModel에 저장
                    registerViewModel.profileData.merge(selectedOptions) { _, new in new }
                    registerViewModel.profileData["최소 나이"] = "\(Int(ageMin))"
                    registerViewModel.profileData["최대 나이"] = "\(Int(ageMax))"
                    registerViewModel.profileData["최대 거리"] = "\(Int(maxDistance)) km"
                    registerViewModel.profileData["특성"] = coordinator.selectedProperties.joined(separator: ", ")
                    registerViewModel.profileData["만나기 싫은 회사"] = coordinator.selectedCompanies.map { $0.name }.joined(separator: ", ")
                    
                    
                    // ✅ API 요청 실행
                    registerViewModel.submitRegistration { result in
                        switch result {
                        case .success:
                            print("✅ 회원가입 성공! 로그인 진행...")
                            DispatchQueue.main.async {
                                registerViewModel.navigationPath.append(NavigationStep.complete.rawValue)
                            }
                        case .failure(let error):
                            print("❌ 회원가입 실패: \(error.localizedDescription)")
                        }
                    }
                }
                .disabled(!isButtonEnabled)
                .padding(.bottom, keyboardManager.keyboardHeight > 0 ? 10 : UIScreen.main.bounds.height / 30)
                .animation(.easeOut(duration: 0.3), value: keyboardManager.keyboardHeight)
                
            }
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarBackButtonHidden(true)
            
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
        .onChange(of: selectedOptions) { _ in
            isButtonEnabled = isFormValid()
        }
        .onChange(of: ageMin) { _ in
            isButtonEnabled = isFormValid()
        }
        .onChange(of: ageMax) { _ in
            isButtonEnabled = isFormValid()
        }
        
        .onDisappear {
            // 키보드 관찰자 해제
            KeyboardObserver.shared.stopListening()
        }
    }
    
    // MARK: - 검증 함수
    private func isFormValid() -> Bool {
        return !selectedOptions.isEmpty
    }
}

//struct SignUpPreferenceView_Previews: PreviewProvider {
//    static var previews: some View {
//        SignUpPreferenceView()
//    }
//}

struct SignUpProfileDropdownCell: View {
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
                    Button(option) {
                        selectedOption = option
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

struct SignUpSliderCell: View {
    var title: String
    @Binding var value: Float
    var range: ClosedRange<Float>
    var unit: String
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("\(title): \(Int(value)) \(unit)")
                .font(.subheadline)
            Slider(value: $value, in: range, step: 1)
                .accentColor(.blue)
        }
        .padding(.vertical, 8)
    }
}

struct MultipleSelectionRow: View {
    let title: String
    let isSelected: Bool
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            HStack {
                Text(title)
                Spacer()
                if isSelected {
                    Image(systemName: "checkmark")
                }
            }
        }
    }
}


