import SwiftUI

struct SignUpBirthDayView: View {
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
        NavigationStack {
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
                                    .font(.headline)
                                    .fontWeight(.bold)
                                
                                
                                HStack(spacing: 8) {
                                    ForEach(0..<4, id: \.self) { index in
                                        SingleDigitField(text: $year[index])
                                            .focused($focusedField, equals: .year(index))
                                            .onChange(of: year[index]) { _ in handleInput(for: .year(index)) }
                                    }
                                    Text("/")
                                    ForEach(0..<2, id: \.self) { index in
                                        SingleDigitField(text: $month[index])
                                            .focused($focusedField, equals: .month(index))
                                            .onChange(of: month[index]) { _ in handleInput(for: .month(index)) }
                                    }
                                    Text("/")
                                    ForEach(0..<2, id: \.self) { index in
                                        SingleDigitField(text: $day[index])
                                            .focused($focusedField, equals: .day(index))
                                            .onChange(of: day[index]) { _ in handleInput(for: .day(index)) }
                                    }
                                }
                            }
                            .padding(.horizontal)
                            .padding(.top, 50)
                            
                            Spacer()
                        }
                        .ignoresSafeArea(.keyboard)
                        
                        
                        VStack {
                            Spacer()
                            SignUpReusableButton(title: "다음", isEnabled: isButtonEnabled) {
                                handleNextButtonTap()
                            }
                            .disabled(!isButtonEnabled)
                            .padding(.bottom, keyboardManager.keyboardHeight > 0 ? 10 : UIScreen.main.bounds.height / 4) // 키보드 위 10pt
                            .animation(.easeOut(duration: 0.3), value: keyboardManager.keyboardHeight)
                            
                        }
                    }
                    
                }
                .navigationBarTitleDisplayMode(.inline)
                .navigationBarBackButtonHidden(true)
                .navigationDestination(isPresented: $navigateToNextView) {
                    SignUpBirthDayView()
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
        
        isButtonEnabled = true
    }
    
    private func isValidDate(year: Int, month: Int, day: Int) -> Bool {
        let currentYear = Calendar.current.component(.year, from: Date())
        guard year >= 1900, year <= currentYear else { return false }
        guard month >= 1, month <= 12 else { return false }
        
        let daysInMonth = Calendar.current.range(of: .day, in: .month, for: DateComponents(year: year, month: month).date!)?.count ?? 0
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
    
    var body: some View {
        TextField("", text: $text)
            .frame(width: 40, height: 40)
            .multilineTextAlignment(.center)
            .keyboardType(.numberPad)
            .background(Color(.systemGray6))
            .cornerRadius(5)
    }
}

