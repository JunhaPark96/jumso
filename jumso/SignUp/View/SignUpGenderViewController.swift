import UIKit

class SignUpGenderViewController: SignUpBaseViewController {

    @IBOutlet weak var genderMaleButton: UIButton!
    @IBOutlet weak var genderFemaleButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupButtons()
        updateProgress(currentSignUpStep: 3)
    }
    
    func setupButtons() {
        // 초기 버튼 상태. 선택되지 않음
        genderMaleButton.isSelected = false
        genderFemaleButton.isSelected = false
        
        genderMaleButton.layer.cornerRadius = 4
        genderMaleButton.layer.masksToBounds = true
        genderFemaleButton.layer.cornerRadius = 4
        genderFemaleButton.layer.masksToBounds = true
        
        genderMaleButton.addTarget(self, action: #selector(genderButtonTapped(_:)), for: .touchUpInside)
        genderFemaleButton.addTarget(self, action: #selector(genderButtonTapped(_:)), for: .touchUpInside)
    }
    
    @objc func genderButtonTapped(_ sender: UIButton) {
        if sender == genderMaleButton {
            genderMaleButton.isSelected = true
            genderFemaleButton.isSelected = false
        } else if sender == genderFemaleButton {
            genderFemaleButton.isSelected = true
            genderMaleButton.isSelected = false
        }
        
        updateButtonStyles()
    }
    
    func updateButtonStyles() {
        if genderMaleButton.isSelected {
            genderMaleButton.backgroundColor = .jumso
            genderMaleButton.setTitleColor(.white, for: .normal)
        } else {
            genderMaleButton.backgroundColor = .clear
            genderMaleButton.setTitleColor(.black, for: .normal)
        }
        
        if genderFemaleButton.isSelected {
            genderFemaleButton.backgroundColor = .jumso
            genderFemaleButton.setTitleColor(.white, for: .normal)
        } else {
            genderFemaleButton.backgroundColor = .clear
            genderFemaleButton.setTitleColor(.black, for: .normal)
        }
    }
    

    @IBAction func SignUpGenderDidTap(_ sender: Any) {
        let storyboard = UIStoryboard(name: "SignUp", bundle: nil)
        
        let signUpDistanceViewController = storyboard.instantiateViewController(withIdentifier: "SignUpDistanceVC") as! SignUpDistanceViewController
        
        self.navigationController?.pushViewController(signUpDistanceViewController, animated: true)
    }
    
}
