import UIKit

class SignUpDistanceViewController: SignUpBaseViewController {
    
    @IBOutlet weak var DistanceSlider: UISlider!
    @IBOutlet weak var DistanceNumberLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 슬라이더 설정
        DistanceSlider.minimumValue = 0
        DistanceSlider.maximumValue = 127
        
        // 초기 라벨 텍스트 설정
        DistanceNumberLabel.text = "\(Int(DistanceSlider.value)) km"
        
        // 슬라이더 값 변경 이벤트 추가
        DistanceSlider.addTarget(self, action: #selector(sliderValueDidChange(_:)), for: .valueChanged)
        
    }
    
    @objc func sliderValueDidChange(_ sender: UISlider) {
        // 슬라이더의 현재 값을 정수로 변환하여 라벨 업데이트
        DistanceNumberLabel.text = "\(Int(sender.value)) km"
    }
    
    
    @IBAction func SignUpDistanceDidTap(_ sender: Any) {
        
        let storyboard = UIStoryboard(name: "SignUp", bundle: nil)
        
        let signUpIntroductionViewController = storyboard.instantiateViewController(withIdentifier: "SignUpIntroductionVC") as! SignUpIntroductionViewController
        
        self.navigationController?.pushViewController(signUpIntroductionViewController, animated: true)
    }
    
    
}
