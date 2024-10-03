
import UIKit

class RegisterViewController: UIViewController, UISearchBarDelegate {
    
    let registerViewTitle = "내 회사 찾기"
    var shouldManageKeyboardObservers: Bool = false
    
    @IBOutlet weak var findCompanyLabel: UILabel!
    @IBOutlet weak var findCompanySearchBar: UISearchBar!
    @IBOutlet weak var companiesTableView: UITableView!
    
    var companies: [CompanyItem] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        findCompanyLabel.text = registerViewTitle
        
        companiesTableView.delegate = self
        companiesTableView.dataSource = self
        
        companiesTableView.register(UINib(nibName: "CompaniesCell", bundle: nil), forCellReuseIdentifier: "CompaniesCell")
        
        findCompanySearchBar.delegate = self
        
        if shouldManageKeyboardObservers {
            setupKeyBoardDismissal()
        }
        
        if let data = loadCompaniesData(filename: "companyMock") {
            decodeCompanyItems(from: data)
        }
    }
    deinit {
            // 옵저버 해제
            if shouldManageKeyboardObservers {
                removeKeyboardNotificationObservers()
            }
        }
   
    
    func loadCompaniesData(filename: String) -> Data? {
        guard let fileUrl = Bundle.main.url(forResource: filename, withExtension: "json") else {
                return nil
        }
        do {
            return try Data(contentsOf: fileUrl)
        } catch {
            print("JSON 파일을 불러오는 중 에러 발생: \(error)")
            return nil
        }
                
    }
    
    func decodeCompanyItems(from data: Data) {
        
        let decoder = JSONDecoder()
        do {
            let companyResponse = try decoder.decode(CompanyResponse.self, from: data)
            self.companies = companyResponse.data.companies
            self.companiesTableView.reloadData()
        } catch {
            print("JSON 파싱 에러 \(error)")
        }
    }
    
    
}

extension RegisterViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return companies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCell(withIdentifier: "CompaniesCell", for: indexPath)
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "CompaniesCell", for: indexPath) as? CompaniesCell else {
            return UITableViewCell()
        }
                
        // 셀의 companyNameLabel에 텍스트 설정
        let company = companies[indexPath.row]
        cell.companyNameLabel.text = company.name
        
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let emailAuthenticationViewController = UIStoryboard(name: "SignUp", bundle: nil).instantiateViewController(withIdentifier: "EmailAuthenticationVC") as! EmailAuthenticationViewController
    
        self.navigationController?.pushViewController(emailAuthenticationViewController, animated: true)
        
    }
    
    
}
