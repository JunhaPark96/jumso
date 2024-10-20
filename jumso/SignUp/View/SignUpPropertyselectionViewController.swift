import UIKit

class SignUpPropertySelectionViewController: UIViewController {
    
    var selectedPropertyIds: Set<Int> = [] // Long -> Int로 변경
    var onSelectionDone: ((Set<Int>) -> Void)?
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.register(UINib(nibName: "CompaniesCell", bundle: nil), forCellReuseIdentifier: "CompaniesCell")
    }
    
    @IBAction func doneButtonTapped(_ sender: UIButton) {
        // 선택 완료 후, 선택된 특성을 클로저로 전달
        onSelectionDone?(selectedPropertyIds)
        self.dismiss(animated: true, completion: nil)
    }
}

extension SignUpPropertySelectionViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10 // 예시로 특성 10개
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // PropertyCell 대신 CompaniesCell을 사용
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "CompaniesCell", for: indexPath) as? CompaniesCell else {
            return UITableViewCell()
        }
        
        // 특성 데이터를 설정
        cell.companyNameLabel.text = "특성 \(indexPath.row + 1)"
        
        // 이미 선택된 특성은 체크 표시
        if selectedPropertyIds.contains(indexPath.row) {
            cell.accessoryType = .checkmark
        } else {
            cell.accessoryType = .none
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedId = indexPath.row
        
        if selectedPropertyIds.contains(selectedId) {
            // 이미 선택된 경우 선택 해제
            selectedPropertyIds.remove(selectedId)
        } else {
            // 선택되지 않은 경우 선택
            selectedPropertyIds.insert(selectedId)
        }
        
        // 선택 상태 변경 반영
        tableView.reloadRows(at: [indexPath], with: .automatic)
    }
}
