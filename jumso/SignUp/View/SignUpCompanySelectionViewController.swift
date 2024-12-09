//import UIKit
//
//class SignUpCompanySelectionViewController: UIViewController {
//    
//    var viewModel = RegisterViewModel() // RegisterViewModel 재사용
//    var selectedCompanyIds: Set<Int> = []
//    var onSelectionDone: ((Set<Int>) -> Void)?
//
//    @IBOutlet weak var tableView: UITableView!
//    
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        
//        tableView.delegate = self
//        tableView.dataSource = self
//        tableView.register(UINib(nibName: "CompaniesCell", bundle: nil), forCellReuseIdentifier: "CompaniesCell")
//        
//        // ViewModel과 View를 연결
//        setupBindings()
//        viewModel.loadCompaniesData(filename: "companyMock")
//    }
//    
//    @IBAction func doneButtonTapped(_ sender: UIButton) {
//        // 선택 완료 후, 선택된 회사를 클로저로 전달
//        onSelectionDone?(selectedCompanyIds)
//        self.dismiss(animated: true, completion: nil)
//    }
//    
//    private func setupBindings() {
//        viewModel.onCompaniesUpdated = { [weak self] in
//            self?.tableView.reloadData()
//        }
//    }
//}
//
//extension SignUpCompanySelectionViewController: UITableViewDelegate, UITableViewDataSource {
//    
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return viewModel.filteredCompanies.count
//    }
//    
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        guard let cell = tableView.dequeueReusableCell(withIdentifier: "CompaniesCell", for: indexPath) as? CompaniesCell else {
//            return UITableViewCell()
//        }
//        
//        // 셀의 companyNameLabel에 텍스트 설정
//        let company = viewModel.filteredCompanies[indexPath.row]
//        cell.companyNameLabel.text = company.name
//        
//        // 선택된 회사 체크 표시
//        if selectedCompanyIds.contains(indexPath.row) {
//            cell.accessoryType = .checkmark
//        } else {
//            cell.accessoryType = .none
//        }
//        
//        return cell
//    }
//    
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        let selectedId = indexPath.row
//        
//        if selectedCompanyIds.contains(selectedId) {
//            // 이미 선택된 경우 선택 해제
//            selectedCompanyIds.remove(selectedId)
//        } else {
//            // 선택되지 않은 경우 선택
//            selectedCompanyIds.insert(selectedId)
//        }
//        
//        // 선택 상태 변경 반영
//        tableView.reloadRows(at: [indexPath], with: .automatic)
//    }
//}
