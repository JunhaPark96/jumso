
import UIKit

class RegisterViewController: UIViewController, UISearchBarDelegate {
    
    let registerViewTitle = "내 회사 찾기"
    var shouldManageKeyboardObservers: Bool = false
    
    @IBOutlet weak var findCompanyLabel: UILabel!
    @IBOutlet weak var findCompanySearchBar: UISearchBar!
    @IBOutlet weak var companiesTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        findCompanyLabel.text = registerViewTitle
        
        companiesTableView.delegate = self
        companiesTableView.dataSource = self
        
        companiesTableView.register(UINib(nibName: "CompaniesCell", bundle: nil), forCellReuseIdentifier: "CompaniesCell")
        
//        companiesTableView.register(UINib(nibName: "ProfileCell", bundle: nil), forCellReuseIdentifier: "ProfileCell")
        findCompanySearchBar.delegate = self
        
        if shouldManageKeyboardObservers {
            setupKeyBoardDismissal()
        }
    }
    deinit {
            // 옵저버 해제
            if shouldManageKeyboardObservers {
                removeKeyboardNotificationObservers()
            }
        }
   
    
}

extension RegisterViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 50
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCell(withIdentifier: "CompaniesCell", for: indexPath)
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "CompaniesCell", for: indexPath) as? CompaniesCell else {
            return UITableViewCell()
        }
                
        // 셀의 companyNameLabel에 텍스트 설정
        cell.companyNameLabel.text = "Company's name \(indexPath.row + 1)"
        
//        cell.textLabel?.text = "Comapanies' name \(indexPath.row + 1)"
        
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let emailAuthenticationViewController = UIStoryboard(name: "SignUp", bundle: nil).instantiateViewController(withIdentifier: "EmailAuthenticationVC") as! EmailAuthenticationViewController
    
        self.navigationController?.pushViewController(emailAuthenticationViewController, animated: true)
        
    }
    
    
}
