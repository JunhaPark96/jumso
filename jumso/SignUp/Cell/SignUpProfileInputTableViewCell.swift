import UIKit

class SignUpProfileInputTableViewCell: UITableViewCell {
    
    @IBOutlet weak var signUpProfileTextField: UITextField!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func configureTextField() {
        signUpProfileTextField.placeholder = ""
    }
}
