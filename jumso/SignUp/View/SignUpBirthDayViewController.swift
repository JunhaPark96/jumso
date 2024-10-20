import UIKit

class SignUpBirthDayViewController: SignUpBaseViewController {
    
    
    @IBOutlet weak var Y1TextField: UITextField!
    @IBOutlet weak var Y2TextField: UITextField!
    @IBOutlet weak var Y3TextField: UITextField!
    @IBOutlet weak var Y4TextField: UITextField!
    
    @IBOutlet weak var M1TextField: UITextField!
    @IBOutlet weak var M2TextField: UITextField!
    
    @IBOutlet weak var D1TextField: UITextField!
    @IBOutlet weak var D2TextField: UITextField!
    
    @IBOutlet weak var SignUpBirthDayButton: UIButton!
//    @IBOutlet weak var buttonBottomConstraint: NSLayoutConstraint!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTextFields()
        SignUpBirthDayButton.isEnabled = false
        updateProgress(currentSignUpStep: 2)
    }
    
    func setupTextFields() {
        let allTextFields = [Y1TextField, Y2TextField, Y3TextField, Y4TextField, M1TextField, M2TextField, D1TextField, D2TextField]
        
        // 모든 텍스트 필드에 delegate와 기본 설정을 적용
        for textField in allTextFields {
            textField?.delegate = self
            textField?.keyboardType = .numberPad
            textField?.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
        }
    }
    
    @objc func textFieldDidChange(_ textField: UITextField) {
        moveToNextTextField(from: textField) // 다음 텍스트 필드로 이동
        validateTextFields() // 모든 텍스트 필드가 입력되었는지 확인하여 버튼 활성화
    }
    
    func moveToNextTextField(from textField: UITextField) {
        switch textField {
        case Y1TextField: Y2TextField.becomeFirstResponder()
        case Y2TextField: Y3TextField.becomeFirstResponder()
        case Y3TextField: Y4TextField.becomeFirstResponder()
        case Y4TextField: M1TextField.becomeFirstResponder()
        case M1TextField: M2TextField.becomeFirstResponder()
        case M2TextField: D1TextField.becomeFirstResponder()
        case D1TextField: D2TextField.becomeFirstResponder()
        case D2TextField: D2TextField.resignFirstResponder() // 마지막 필드일 경우 키보드 내림
        default: break
        }
    }
    
    func validateTextFields() {
        let allTextFields = [Y1TextField, Y2TextField, Y3TextField, Y4TextField, M1TextField, M2TextField, D1TextField, D2TextField]
        let allFilled = allTextFields.allSatisfy { $0?.text?.isEmpty == false }
        if allFilled, isValidDate() {
            SignUpBirthDayButton.isEnabled = true
        } else {
            SignUpBirthDayButton.isEnabled = false
        }
    }
    
    // 유효한 생년월일인지 확인
    func isValidDate() -> Bool {
        guard
            let year = getYear(),
            let month = getMonth(),
            let day = getDay()
        else {
            return false
        }
        
        // 연도 범위 체크 (1900~현재년도)
        let currentYear = Calendar.current.component(.year, from: Date())
        if year < 1900 || year > currentYear {
            return false
        }
        
        // 월 범위 체크 (1~12)
        if month < 1 || month > 12 {
            return false
        }
        
        // 일 범위 체크 (각 달의 일수에 맞게)
        let validDaysInMonth = daysInMonth(month: month, year: year)
        if day < 1 || day > validDaysInMonth {
            return false
        }
        
        return true
    }
    
    func getYear() -> Int? {
        guard
            let y1 = Y1TextField.text, let y2 = Y2TextField.text,
            let y3 = Y3TextField.text, let y4 = Y4TextField.text
        else { return nil }
        return Int("\(y1)\(y2)\(y3)\(y4)")
    }
    
    func getMonth() -> Int? {
        guard let m1 = M1TextField.text, let m2 = M2TextField.text else { return nil }
        return Int("\(m1)\(m2)")
    }
    
    func getDay() -> Int? {
        guard let d1 = D1TextField.text, let d2 = D2TextField.text else { return nil }
        return Int("\(d1)\(d2)")
    }
    
    // 해당 월의 일수를 반환
    func daysInMonth(month: Int, year: Int) -> Int {
        var dateComponents = DateComponents()
        dateComponents.year = year
        dateComponents.month = month
        let calendar = Calendar.current
        let date = calendar.date(from: dateComponents)!
        let range = calendar.range(of: .day, in: .month, for: date)!
        return range.count
    }
    
    @IBAction func SignUpBirthDayDidTap(_ sender: Any) {
        let storyboard = UIStoryboard(name: "SignUp", bundle: nil)
        let signUpGenderViewController = storyboard.instantiateViewController(withIdentifier: "SignUpGenderVC") as! SignUpGenderViewController
        self.navigationController?.pushViewController(signUpGenderViewController, animated: true)
    }
    
}

extension SignUpBirthDayViewController: UITextFieldDelegate {
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        // 현재 텍스트와 새로운 텍스트를 결합하여 글자 수 계산
        let currentText = textField.text ?? ""
        let prospectiveText = (currentText as NSString).replacingCharacters(in: range, with: string)
        
        // 숫자만 입력되게 설정
        let allowedCharacters = CharacterSet.decimalDigits
        let characterSet = CharacterSet(charactersIn: string)
        if !allowedCharacters.isSuperset(of: characterSet) {
            return false
        }
        
        // 글자 수 제한 (한 글자씩)
        return prospectiveText.count <= 1
    }
    
}
