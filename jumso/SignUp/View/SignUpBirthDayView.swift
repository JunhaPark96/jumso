import SwiftUI

struct SignUpBirthDayView: View {
    @EnvironmentObject var registerViewModel: RegisterViewModel
    // MARK: - 상태 변수
    @State private var year: [String] = Array(repeating: "", count: 4) // YYYY
    @State private var month: [String] = Array(repeating: "", count: 2) // MM
    @State private var day: [String] = Array(repeating: "", count: 2) // DD
    @State private var isButtonEnabled: Bool = false
    @FocusState private var focusedField: BirthDayField?
    
    @State private var navigateToNextView: Bool = false
    @State private var keyboardHeight: CGFloat = 0
    @StateObject private var keyboardManager = KeyboardManager.shared
    
    // ProgressBar 상태
    private let totalSignUpSteps = 8
    private let currentSignUpStep = 2
    
    var body: some View {
            ZStack(alignment: .bottom) {
                VStack(spacing: 0) {
                    // Progress Bar
                    ProgressView(value: Float(currentSignUpStep) / Float(totalSignUpSteps))
                        .progressViewStyle(LinearProgressViewStyle(tint: .blue))
                        .padding(.top, 50)
                        .padding(.horizontal, 16)
                    
                    GeometryReader { geometry in
                        VStack(alignment: .leading, spacing: 20) {
                            VStack(alignment: .leading, spacing: 10) {
                                Text("생일은 언제인가요?")
                                    .font(.title)
                                    .fontWeight(.bold)
                                
                                
                                HStack(alignment: .top, spacing: 5) {
                                    
                                    ForEach(0..<4, id: \.self) { index in
                                        SingleDigitField(
                                            text: $year[index],
                                            placeholder: "Y"
                                        )
                                        .focused($focusedField, equals: .year(index))
                                        .onChange(of: year[index]) { _ in handleInput(for: .year(index)) }
                                    }
                                    SingleDigitField(text: .constant(""), isStatic: true, staticText: "/")
                                    
                                    
                                    ForEach(0..<2, id: \.self) { index in
                                        SingleDigitField(
                                            text: $month[index],
                                            placeholder: "M"
                                        )
                                            .focused($focusedField, equals: .month(index))
                                            .onChange(of: month[index]) { _ in handleInput(for: .month(index)) }
                                    }
                                    SingleDigitField(text: .constant(""), isStatic: true, staticText: "/")
                                    
                                    ForEach(0..<2, id: \.self) { index in
                                        SingleDigitField(text: $day[index],
                                        placeholder: "D")
                                            .focused($focusedField, equals: .day(index))
                                            .onChange(of: day[index]) { _ in handleInput(for: .day(index)) }
                                    }
                                }
                                .padding(.top, 20)
//                                .frame(maxWidth: .infinity)
                            }
                            
                            .padding(.horizontal)
                            .padding(.top, 50)
                            
                            Spacer()
                        }
                        .ignoresSafeArea(.keyboard)
                        
                        
                        VStack {
                            Spacer()
                            SignUpReusableButton(title: "다음", isEnabled: isButtonEnabled) {
                                registerViewModel.navigationPath.append("NextStep")                            }
                            .disabled(!isButtonEnabled)
                            .padding(.bottom, keyboardManager.keyboardHeight > 0 ? 10 : UIScreen.main.bounds.height / 4) // 키보드 위 10pt
                            .animation(.easeOut(duration: 0.3), value: keyboardManager.keyboardHeight)
                            
                        }
                    }
                    
                }
                .navigationBarTitleDisplayMode(.inline)
                .navigationBarBackButtonHidden(true)
                .navigationDestination(isPresented: $navigateToNextView) {
                    SignUpGenderView()
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
            
        
    }
    
    // MARK: - 입력 처리
    private func handleInput(for field: BirthDayField) {
        switch field {
        case .year(let index):
            if year[index].count > 1 { year[index] = String(year[index].prefix(1)) }
            moveToNextOrPreviousField(for: field, value: year[index])
        case .month(let index):
            if month[index].count > 1 { month[index] = String(month[index].prefix(1)) }
            moveToNextOrPreviousField(for: field, value: month[index])
        case .day(let index):
            if day[index].count > 1 { day[index] = String(day[index].prefix(1)) }
            moveToNextOrPreviousField(for: field, value: day[index])
        }
        validateFields()
    }
    
    private func moveToNextOrPreviousField(for field: BirthDayField, value: String) {
        if value.isEmpty {
            focusedField = field.previous
        } else if value.count == 1 {
            focusedField = field.next
        }
    }
    
    // MARK: - 유효성 검사
    private func validateFields() {
        let yearString = year.joined()
        let monthString = month.joined()
        let dayString = day.joined()
        
        guard let year = Int(yearString),
              let month = Int(monthString),
              let day = Int(dayString),
              isValidDate(year: year, month: month, day: day) else {
            isButtonEnabled = false
            return
        }
//        registerViewModel.birthday = "\(yearString)-\(monthString)-\(dayString)" // 생일 저장
        registerViewModel.birthday = "\(yearString)\(monthString)\(dayString)" // 생일 저장
        isButtonEnabled = true
    }
    
    private func isValidDate(year: Int, month: Int, day: Int) -> Bool {
        let currentYear = Calendar.current.component(.year, from: Date())
        guard year >= 1900, year <= currentYear else { return false }
        guard month >= 1, month <= 12 else { return false }
        
        let components = DateComponents(year: year, month: month)
                guard let date = Calendar.current.date(from: components),
                      let daysInMonth = Calendar.current.range(of: .day, in: .month, for: date)?.count else {
                    return false
                }
        return day >= 1 && day <= daysInMonth
    }
    
    // 버튼 동작
    private func handleNextButtonTap() {
        navigateToNextView = true
    }
    
}


// MARK: - BirthDayField Enum
enum BirthDayField: Hashable {
    case year(Int), month(Int), day(Int)
    
    var next: BirthDayField? {
        switch self {
        case .year(let index): return index < 3 ? .year(index + 1) : .month(0)
        case .month(let index): return index < 1 ? .month(index + 1) : .day(0)
        case .day(let index): return index < 1 ? .day(index + 1) : nil
        }
    }
    
    var previous: BirthDayField? {
        switch self {
        case .year(let index): return index > 0 ? .year(index - 1) : nil
        case .month(let index): return index > 0 ? .month(index - 1) : .year(3)
        case .day(let index): return index > 0 ? .day(index - 1) : .month(1)
        }
    }
}

// MARK: - Single Digit Field
struct SingleDigitField: View {
    @Binding var text: String
    var isStatic: Bool = false
    var staticText: String = ""
    var placeholder: String = ""
    
    var body: some View {
        GeometryReader { geometry in
            let width = geometry.size.width * 1
            let height = geometry.size.height * 0.05
            
            VStack(spacing: 0) {
                if isStatic {
                    Text(staticText)
                        .font(.system(size: height * 0.8))
                        .multilineTextAlignment(.center)
                        .frame(width: width, height: height * 2) // 높이 맞춤
                        .background(Color.clear)

                } else {
                    ZStack {
                        // Placeholder
                        if text.isEmpty {
                            Text(placeholder)
                                .foregroundColor(.gray)
                                .font(.system(size: height * 1))
                        }
                        
                        // TextField
                        TextField("", text: $text)
                            .font(.system(size: height * 1))
                            .multilineTextAlignment(.center)
                            .keyboardType(.numberPad)
                            .frame(width: width, height: height * 1.5)
                            .background(Color.clear)
                    }
                    // 밑줄
                    Rectangle()
                        .frame(width: width, height: 1)
                        .foregroundColor(.black)
                }
                
            }
//            .frame(width: width, height: height * 3) // 전체 높이 고정
        }
    }
}



//struct SignUpBirthDayView_Previews: PreviewProvider {
//    static var previews: some View {
//        SignUpBirthDayView()
//    }
//}
