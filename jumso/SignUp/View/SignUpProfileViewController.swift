
import UIKit


enum ProfileSection: String, CaseIterable {
    case basicInfo = "키와 체형"
    case additionalInfo = "추가 정보"
    
    enum BasicInfoRow: String, CaseIterable {
        case height = "키를 알려주세요"
        case bodyType = "체형은 어떤가요?"
    }
    
    enum AdditionalInfoRow: String, CaseIterable {
        case maritalStatus = "결혼 상태"
        case religion = "종교"
        case smoking = "흡연 여부"
        case drinking = "음주 여부"
    }
}

class SignUpProfileViewController: UIViewController {
    
    // 섹션별로 프로필 옵션 데이터
    let profileOptions: [ProfileSection: [(label: String, options: [String])]] = [
            .basicInfo: [
                (ProfileSection.BasicInfoRow.height.rawValue, (50...300).map { "\($0) cm" }),
                (ProfileSection.BasicInfoRow.bodyType.rawValue, ["살짝 근육", "마름", "통통한편", "완전 근육"])
            ],
            .additionalInfo: [
                (ProfileSection.AdditionalInfoRow.maritalStatus.rawValue, ["미혼", "기혼", "돌싱"]),
                (ProfileSection.AdditionalInfoRow.religion.rawValue, ["무교", "기독교", "불교", "천주교", "기타"]),
                (ProfileSection.AdditionalInfoRow.smoking.rawValue, ["흡연", "비흡연"]),
                (ProfileSection.AdditionalInfoRow.drinking.rawValue, ["음주", "금주"])
            ]
        ]
    
    @IBOutlet weak var ProfileTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        ProfileTableView.delegate = self
        ProfileTableView.dataSource = self
        
        let signUpProfileTableViewCell = UINib(nibName: "SignUpProfileTableViewCell", bundle: nil)
        ProfileTableView.register(signUpProfileTableViewCell, forCellReuseIdentifier: "SignUpProfileTableViewCell")
        
    }
}

extension SignUpProfileViewController: UITableViewDelegate, UITableViewDataSource {
    
    // 섹션의 개수
    func numberOfSections(in tableView: UITableView) -> Int {
        return ProfileSection.allCases.count
    }
    
    // 각 섹션에 포함된 셀의 개수
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // 배열 범위 확인 후 안전하게 접근
        guard section >= 0 && section < ProfileSection.allCases.count else { return 0 }
        let profileSection = ProfileSection.allCases[section]
        return profileOptions[profileSection]?.count ?? 0
    }
    
    // 섹션의 셀 설정
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let profileSelectCell = tableView.dequeueReusableCell(withIdentifier: "SignUpProfileTableViewCell", for: indexPath) as? SignUpProfileTableViewCell else {
            return UITableViewCell()
        }
        
        // 배열 범위 확인 후 안전하게 접근
        guard indexPath.section >= 0 && indexPath.section < ProfileSection.allCases.count else { return UITableViewCell() }
        let profileSection = ProfileSection.allCases[indexPath.section]
        
        guard indexPath.row >= 0 && indexPath.row < (profileOptions[profileSection]?.count ?? 0),
              let option = profileOptions[profileSection]?[indexPath.row] else {
            return UITableViewCell()
        }
        
        profileSelectCell.ProfileLabel.text = option.label
        profileSelectCell.setupPopupButton(with: option.options)
        
        // 기본값 설정 (예: 첫 번째 섹션의 첫 번째 셀인 "키를 알려주세요"의 기본값을 150cm로 설정)
        if profileSection == .basicInfo && option.label == ProfileSection.BasicInfoRow.height.rawValue {
            profileSelectCell.setupPopupButton(with: option.options, defaultValue: "150 cm")
        } else {
            profileSelectCell.setupPopupButton(with: option.options)
        }
        
        return profileSelectCell
    }
    
    // 섹션별 헤더 타이틀 설정
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        // 배열 범위 확인 후 안전하게 접근
        guard section >= 0 && section < ProfileSection.allCases.count else { return nil }
        return ProfileSection.allCases[section].rawValue
    }
}
