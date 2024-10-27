import UIKit

enum PreferenceSection: String, CaseIterable {
    case basicPreferences = "기본 정보"
    case additionalPreferences = "추가 정보"
    case propertySelection = "특성 선택"
    case companySelection = "만나기 싫은 회사 선택"
    
    enum BasicPreferencesRow: String, CaseIterable {
        case whatSexDoYouWant = "원하는 성별"
        case howOldDoYouWantMin = "원하는 나이 (최소)"
        case howOldDoYouWantMax = "원하는 나이 (최대)"
        case howFarCanYouGo = "갈 수 있는 거리"
    }
    
    enum AdditionalPreferencesRow: String, CaseIterable {
        case whatKindOfBodyTypeDoYouWant = "원하는 체형"
        case whatKindOfRelationshipStatusDoYouWant = "원하는 교제 상태"
        case whatKindOfReligionDoYouWant = "원하는 종교"
        case whatKindOfSmokeDoYouWant = "원하는 흡연 여부"
        case whatKindOfDrinkDoYouWant = "원하는 음주 여부"
    }
}


class SignUpPreferenceViewController: SignUpBaseViewController {
    
    var selectedPropertyIds: Set<Int> = []
    var selectedCompanyIds: Set<Int> = []
    // 섹션별로 원하는 정보 옵션
    let preferenceOptions: [PreferenceSection: [(label: String, options: [String])]] = [
        .basicPreferences: [
            (PreferenceSection.BasicPreferencesRow.whatSexDoYouWant.rawValue, ["남성", "여성"]),
            (PreferenceSection.BasicPreferencesRow.howOldDoYouWantMin.rawValue, []), // 슬라이더로 나이 설정
            (PreferenceSection.BasicPreferencesRow.howOldDoYouWantMax.rawValue, []), // 슬라이더로 나이 설정
            (PreferenceSection.BasicPreferencesRow.howFarCanYouGo.rawValue, []) // 슬라이더로 거리 설정
        ],
        .additionalPreferences: [
            (PreferenceSection.AdditionalPreferencesRow.whatKindOfBodyTypeDoYouWant.rawValue, ["마름", "통통", "근육질"]),
            (PreferenceSection.AdditionalPreferencesRow.whatKindOfRelationshipStatusDoYouWant.rawValue, ["미혼", "기혼", "돌싱"]),
            (PreferenceSection.AdditionalPreferencesRow.whatKindOfReligionDoYouWant.rawValue, ["무교", "기독교", "불교", "천주교"]),
            (PreferenceSection.AdditionalPreferencesRow.whatKindOfSmokeDoYouWant.rawValue, ["흡연", "비흡연"]),
            (PreferenceSection.AdditionalPreferencesRow.whatKindOfDrinkDoYouWant.rawValue, ["음주", "금주"])
        ]
    ]
    
    
    @IBOutlet weak var PreferenceTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateProgress(currentSignUpStep: 7)
        
        PreferenceTableView.delegate = self
        PreferenceTableView.dataSource = self
        
        // TableView에 사용할 셀 등록
        let signUpProfileTableViewCell = UINib(nibName: "SignUpProfileTableViewCell", bundle: nil)
        PreferenceTableView.register(signUpProfileTableViewCell, forCellReuseIdentifier: "SignUpProfileTableViewCell")
        
        let signUpSliderTableViewCell = UINib(nibName: "SignUpSliderTableViewCell", bundle: nil)
        PreferenceTableView.register(signUpSliderTableViewCell, forCellReuseIdentifier: "SignUpSliderTableViewCell")
        
        let signUpSelectTableViewCell = UINib(nibName: "SignUpSelectTableViewCell", bundle: nil)
        PreferenceTableView.register(signUpSelectTableViewCell, forCellReuseIdentifier: "SignUpSelectTableViewCell")
    }
    
    
    @IBAction func SignUpPreferenceDidTap(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        
        let loginViewController = storyboard.instantiateViewController(withIdentifier: "LoginVC") as! LoginViewController
        
        self.navigationController?.pushViewController(loginViewController, animated: true)
    }
    
}

extension SignUpPreferenceViewController: UITableViewDelegate, UITableViewDataSource {
    
    // 섹션의 개수
    func numberOfSections(in tableView: UITableView) -> Int {
        return PreferenceSection.allCases.count
    }
    
    // 각 섹션에 포함된 셀의 개수
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let preferenceSection = PreferenceSection.allCases[section]
        
        switch preferenceSection {
        case .basicPreferences:
            return PreferenceSection.BasicPreferencesRow.allCases.count
        case .additionalPreferences:
            return PreferenceSection.AdditionalPreferencesRow.allCases.count
        case .propertySelection, .companySelection:
            return 1 // 특성 선택과 회사 선택은 각각 하나의 셀
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let preferenceSection = PreferenceSection.allCases[indexPath.section]
        
        switch preferenceSection {
        case .basicPreferences:
            let basicRow = PreferenceSection.BasicPreferencesRow.allCases[indexPath.row]
            
            if basicRow == .howOldDoYouWantMin || basicRow == .howOldDoYouWantMax || basicRow == .howFarCanYouGo {
                // Slider 셀 설정
                guard let sliderCell = tableView.dequeueReusableCell(withIdentifier: "SignUpSliderTableViewCell", for: indexPath) as? SignUpSliderTableViewCell else {
                    return UITableViewCell()
                }
                
                // 슬라이더 셀의 범위를 설정 (예: 나이 또는 거리)
                if basicRow == .howOldDoYouWantMin {
                    sliderCell.SliderTitleLabel.text = "최소 나이"
                    sliderCell.configureSlider(minValue: 18, maxValue: 127, currentValue: 25)
                } else if basicRow == .howOldDoYouWantMax {
                    sliderCell.SliderTitleLabel.text = "최대 나이"
                    sliderCell.configureSlider(minValue: 18, maxValue: 127, currentValue: 35)
                } else if basicRow == .howFarCanYouGo {
                    sliderCell.SliderTitleLabel.text = "최대 거리"
//                    sliderCell.SliderUnitLabel.text = "km"
                    sliderCell.configureSlider(minValue: 0, maxValue: 127, currentValue: 50)
                }
                
                return sliderCell
                
            } else {
                // Popup 셀 설정
                guard let profileCell = tableView.dequeueReusableCell(withIdentifier: "SignUpProfileTableViewCell", for: indexPath) as? SignUpProfileTableViewCell else {
                    return UITableViewCell()
                }
                let option = preferenceOptions[preferenceSection]![indexPath.row]
                profileCell.ProfileLabel.text = option.label
                profileCell.setupPopupButton(with: option.options)
                return profileCell
            }
            
        case .additionalPreferences:
            // 추가 정보 섹션 설정 (모두 Popup 셀)
            guard let profileCell = tableView.dequeueReusableCell(withIdentifier: "SignUpProfileTableViewCell", for: indexPath) as? SignUpProfileTableViewCell else {
                return UITableViewCell()
            }
            let option = preferenceOptions[preferenceSection]![indexPath.row]
            profileCell.ProfileLabel.text = option.label
            profileCell.setupPopupButton(with: option.options)
            return profileCell
            
        case .propertySelection:
            // 특성 선택 섹션 설정
            guard let selectCell = tableView.dequeueReusableCell(withIdentifier: "SignUpSelectTableViewCell", for: indexPath) as? SignUpSelectTableViewCell else {
                return UITableViewCell()
            }
            selectCell.SelectLabel.text = "특성 선택"
            selectCell.didTapImage = { [weak self] in
                self?.presentPropertiesSelection()
            }
            return selectCell
            
        case .companySelection:
            // 회사 선택 섹션 설정
            guard let selectCell = tableView.dequeueReusableCell(withIdentifier: "SignUpSelectTableViewCell", for: indexPath) as? SignUpSelectTableViewCell else {
                return UITableViewCell()
            }
            selectCell.SelectLabel.text = "만나기 싫은 회사 선택"
            selectCell.didTapImage = { [weak self] in
                self?.presentCompaniesSelection()
            }
            return selectCell
        }
    }
    
    // 섹션별 헤더 타이틀 설정
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return PreferenceSection.allCases[section].rawValue
    }
    
    // 특성 선택 모달 띄우기
    func presentPropertiesSelection() {
        let storyboard = UIStoryboard(name: "SignUp", bundle: nil)
        let signUpPropertySelectionViewController = storyboard.instantiateViewController(withIdentifier: "SignUpPropertySelectionVC") as! SignUpPropertySelectionViewController
        
        signUpPropertySelectionViewController.selectedPropertyIds = selectedPropertyIds // 현재 선택된 특성 전달
        signUpPropertySelectionViewController.onSelectionDone = { [weak self] selectedIds in
            self?.selectedPropertyIds = selectedIds
            // 선택된 특성 처리
        }
        
        self.present(signUpPropertySelectionViewController, animated: true, completion: nil)
    }
    
    // 회사 선택 모달 띄우기
    func presentCompaniesSelection() {
        let storyboard = UIStoryboard(name: "SignUp", bundle: nil)
        let signUpCompanySelectionViewController = storyboard.instantiateViewController(withIdentifier: "SignUpCompanySelectionVC") as! SignUpCompanySelectionViewController
        
        signUpCompanySelectionViewController.selectedCompanyIds = selectedCompanyIds // 현재 선택된 회사 전달
        signUpCompanySelectionViewController.onSelectionDone = { [weak self] selectedIds in
            self?.selectedCompanyIds = selectedIds
            // 선택된 회사 처리
        }
        
        self.present(signUpCompanySelectionViewController, animated: true, completion: nil)
    }
    
    
    
}
