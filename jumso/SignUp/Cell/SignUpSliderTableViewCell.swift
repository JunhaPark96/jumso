import UIKit

class SignUpSliderTableViewCell: UITableViewCell {
    
    @IBOutlet weak var SliderTitleLabel: UILabel!
    @IBOutlet weak var SliderNumberLabel: UILabel!
    @IBOutlet weak var SignUpSlider: UISlider!
    @IBOutlet weak var SliderUnitLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        SignUpSlider.addTarget(self, action: #selector(sliderValueChanged(_:)), for: .valueChanged)
    }
    
    // 슬라이더 값을 설정하는 메서드
    func configureSlider(minValue: Float, maxValue: Float, currentValue: Float) {
        SignUpSlider.minimumValue = minValue
        SignUpSlider.maximumValue = maxValue
        SignUpSlider.value = currentValue
        
        // 초깃값 설정
        updateSliderValueLabel()
    }
    
    // 슬라이더 값이 변경될 때 호출되는 메서드
    @objc func sliderValueChanged(_ sender: UISlider) {
        updateSliderValueLabel()
    }
    
    // 레이블 업데이트 메서드 (나이 또는 거리 단위에 맞게 설정)
    func updateSliderValueLabel() {
        if SliderTitleLabel.text?.contains("나이") == true {
            let ageValue = Int(SignUpSlider.value)
            SliderNumberLabel.text = "\(ageValue) 살"
        } else if SliderTitleLabel.text?.contains("거리") == true {
            let distanceValue = Int(SignUpSlider.value)
            SliderNumberLabel.text = "\(distanceValue) km"
        }
    }
}
