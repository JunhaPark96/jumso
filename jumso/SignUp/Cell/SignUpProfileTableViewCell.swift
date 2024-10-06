import UIKit

class SignUpProfileTableViewCell: UITableViewCell {
    
    
    @IBOutlet weak var ProfileLabel: UILabel!
    @IBOutlet weak var ProfilePopUpButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    /// PopupButton에 데이터를 설정하는 메서드
    func setupPopupButton(with options: [String], defaultValue: String? = nil) {
            let menuItems = options.map { option in
                UIAction(title: option, handler: { _ in
                    self.ProfilePopUpButton.setTitle(option, for: .normal) // 선택된 항목 표시
                })
            }
            
            let menu = UIMenu(title: "", options: .displayInline, children: menuItems)
            ProfilePopUpButton.menu = menu
            ProfilePopUpButton.showsMenuAsPrimaryAction = true
            
            // 버튼에 텍스트와 이미지를 동시에 설정
            var config = UIButton.Configuration.plain()
            
            // 기본값 설정, 기본값이 없으면 첫 번째 옵션 설정
            config.title = defaultValue ?? options.first
            
            // 오른쪽에 선택용 화살표 이미지 추가
//            config.image = UIImage(systemName: "chevron.down")
            config.imagePlacement = .trailing
            config.imagePadding = 8
            
            // 버튼의 텍스트 색상을 검정색으로 설정
            config.baseForegroundColor = .black
            
            ProfilePopUpButton.configuration = config
        }
}
