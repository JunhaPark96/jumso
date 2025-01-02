import UIKit

class SignUpSelectTableViewCell: UITableViewCell {
    @IBOutlet weak var SelectLabel: UILabel!
    @IBOutlet weak var SelectImageView: UIImageView!
    
    var didTapImage: (() -> Void)? // 클로저로 클릭 이벤트 전달
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(imageTapped))
        SelectImageView.isUserInteractionEnabled = true
        SelectImageView.addGestureRecognizer(tapGesture)
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    @objc func imageTapped() {
        didTapImage?() // 클릭 시 클로저 호출
    }
    
}
