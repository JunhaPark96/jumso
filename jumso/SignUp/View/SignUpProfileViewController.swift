
import UIKit


enum ProfileSection: String, CaseIterable {
    case basicInfo = "키와 체형"
    case jobInfo = "하는 일"
    case additionalInfo = "추가 정보"
    
    
    enum BasicInfoRow: String, CaseIterable {
        case height = "키를 알려주세요"
        case bodyType = "체형은 어떤가요?"
    }
    
    enum JobInfoRow: String, CaseIterable {
        case jobTitle = "하는 일을 알려주세요"
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
            (ProfileSection.BasicInfoRow.height.rawValue, (100...300).map { "\($0) cm" }),
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
        
        let signUpProfileInputTableViewCell = UINib(nibName: "SignUpProfileInputTableViewCell", bundle: nil)
        ProfileTableView.register(signUpProfileInputTableViewCell, forCellReuseIdentifier: "SignUpProfileInputTableViewCell")
        
    }
    @IBAction func SignUpProfileDidTap(_ sender: Any) {
        
        let storyboard = UIStoryboard(name: "SignUp", bundle: nil)
        
        let signUpLocationViewController = storyboard.instantiateViewController(withIdentifier: "SignUpLocationVC") as! SignUpLocationViewController
        
        self.navigationController?.pushViewController(signUpLocationViewController, animated: true)
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
        
        switch profileSection {
        case .basicInfo:
            return ProfileSection.BasicInfoRow.allCases.count
        case .jobInfo:
            return ProfileSection.JobInfoRow.allCases.count
        case .additionalInfo:
            return ProfileSection.AdditionalInfoRow.allCases.count
        }
    }
    
    // 섹션의 셀 설정
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let profileSection = ProfileSection.allCases[indexPath.section]
        
        switch profileSection {
        case .basicInfo:
            guard let profileSelectCell = tableView.dequeueReusableCell(withIdentifier: "SignUpProfileTableViewCell", for: indexPath) as? SignUpProfileTableViewCell else {
                return UITableViewCell()
            }
            let option = profileOptions[profileSection]![indexPath.row]
            profileSelectCell.ProfileLabel.text = option.label
            profileSelectCell.setupPopupButton(with: option.options)
            return profileSelectCell
          
        case .jobInfo:
            guard let jobInputCell = tableView.dequeueReusableCell(withIdentifier: "SignUpProfileInputTableViewCell", for: indexPath) as? SignUpProfileInputTableViewCell else {
                return UITableViewCell()
            }
            jobInputCell.configureTextField()
            return jobInputCell
            
        case .additionalInfo:
            guard let profileSelectCell = tableView.dequeueReusableCell(withIdentifier: "SignUpProfileTableViewCell", for: indexPath) as? SignUpProfileTableViewCell else {
                return UITableViewCell()
            }
            let option = profileOptions[profileSection]![indexPath.row]
            profileSelectCell.ProfileLabel.text = option.label
            profileSelectCell.setupPopupButton(with: option.options)
            return profileSelectCell
            
        }
    }
    
    // 섹션별 헤더 타이틀 설정
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        // 배열 범위 확인 후 안전하게 접근
        guard section >= 0 && section < ProfileSection.allCases.count else { return nil }
        return ProfileSection.allCases[section].rawValue
    }
}
