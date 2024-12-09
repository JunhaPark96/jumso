//
//import UIKit
//
//class RegisterViewController: UIViewController, UISearchBarDelegate {
//    
//    let registerViewTitle = "내 회사 찾기"
//    var viewModel = RegisterViewModel()
//    
//    @IBOutlet weak var findCompanyLabel: UILabel!
//    @IBOutlet weak var findCompanySearchBar: UISearchBar!
//    @IBOutlet weak var companiesTableView: UITableView!
//    
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        
//        findCompanyLabel.text = registerViewTitle
//        
//        companiesTableView.delegate = self
//        companiesTableView.dataSource = self
//        
//        companiesTableView.register(UINib(nibName: "CompaniesCell", bundle: nil), forCellReuseIdentifier: "CompaniesCell")
//        
//        findCompanySearchBar.delegate = self
//        
//        // 검색바 UI
//        configureSearchBarUI()
//        
//        // ViewModel과 View를 연결
//        setupBindings()
//        
//        viewModel.loadCompaniesData(filename: "companyMock")
//    }
//   
//    // ViewModel과 View를 연결
//    private func setupBindings() {
//        viewModel.onCompaniesUpdated = { [weak self] in // 순환참조로 인해 메모리 해제 불능을 방지
//            self?.companiesTableView.reloadData() // weak 참조를 사용하였으므로 self가 nil이 될 수 있으므로 옵셔널 처리
//        }
//    }
//    
//    private func configureSearchBarUI() {
//        findCompanySearchBar.searchTextField.layer.cornerRadius = 12
//        findCompanySearchBar.searchTextField.clipsToBounds = true
//        
//        if let textFieldInsideSearchBar = findCompanySearchBar.value(forKey: "searchField") as? UITextField {
//            if let leftView = textFieldInsideSearchBar.leftView as? UIImageView {
//                leftView.image = UIImage(systemName: "magnifyingglass")
//                leftView.tintColor = UIColor.orange
//            }
//        }
//    }
//    
//    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
//        viewModel.searchCompanies(with: searchText)
//    }
//    
//    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
//        searchBar.text = ""
//        searchBar.resignFirstResponder() // 키보드 내리기
//        viewModel.searchCompanies(with: "") // 전체 리스트 복귀
//    }
//    
//    
//}
//
//extension RegisterViewController: UITableViewDelegate, UITableViewDataSource {
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return viewModel.filteredCompanies.count
//    }
//    
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//
//        guard let cell = tableView.dequeueReusableCell(withIdentifier: "CompaniesCell", for: indexPath) as? CompaniesCell else {
//            return UITableViewCell()
//        }
//                
//        // 셀의 companyNameLabel에 텍스트 설정
//        let company = viewModel.filteredCompanies[indexPath.row]
//        cell.companyNameLabel.text = company.name
//        
//        return cell
//    }
//    
//    
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        let selectedCompany = viewModel.filteredCompanies[indexPath.row]
//        
//        let emailAuthenticationViewController = UIStoryboard(name: "SignUp", bundle: nil).instantiateViewController(withIdentifier: "EmailAuthenticationVC") as! EmailAuthenticationViewController
//        
//        emailAuthenticationViewController.companyEmailDomains = selectedCompany.emails
//        print("RegisterViewController - 전달된 회사는: \(String(describing: selectedCompany))")
//        print("RegisterViewController - 전달된 회사도메인은: \(String(describing: selectedCompany.emails))")
//    
//        self.navigationController?.pushViewController(emailAuthenticationViewController, animated: true)
//        
//    }
//    
//    
//}
