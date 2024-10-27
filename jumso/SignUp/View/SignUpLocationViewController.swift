import UIKit
import MapKit
import CoreLocation

class SignUpLocationViewController: SignUpBaseViewController, CLLocationManagerDelegate, UITextFieldDelegate {
    
    private var locationManager: CLLocationManager!
    private var geocoder = CLGeocoder()
    
    @IBOutlet weak var LocationLabel: UILabel!
    @IBOutlet weak var LocationInputTextField: UITextField!
    @IBOutlet weak var LocationMapView: MKMapView!
    @IBOutlet weak var buttonBottomConstraint: NSLayoutConstraint!
    @IBOutlet weak var MyLocationLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateProgress(currentSignUpStep: 5)
        
        
        // CLLocationManager 설정
        locationManager = CLLocationManager()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        // 위치 서비스 사용 가능 여부 확인
        
        // 텍스트 필드 델리게이트 설정
        LocationInputTextField.delegate = self
        
        locationManager = CLLocationManager()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        
        // 위치 권한 요청
        locationManager.requestWhenInUseAuthorization()
        
        LocationMapView.showsUserLocation = true
    }
    
    @IBAction func SignUpLocationDidTap(_ sender: Any) {
        let storyboard = UIStoryboard(name: "SignUp", bundle: nil)
        
        let signUpDistanceViewController = storyboard.instantiateViewController(withIdentifier: "SignUpDistanceVC") as! SignUpDistanceViewController
        
        self.navigationController?.pushViewController(signUpDistanceViewController, animated: true)
    }
    
    
    // 현재 위치를 업데이트 받는 메서드
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let userLocation = locations.first {
            let latitude = userLocation.coordinate.latitude
            let longitude = userLocation.coordinate.longitude
            print("현재 위치 - 위도: \(latitude), 경도: \(longitude)")
            
            // 지도를 현재 위치로 이동
            let region = MKCoordinateRegion(center: userLocation.coordinate, latitudinalMeters: 1000, longitudinalMeters: 1000)
            LocationMapView.setRegion(region, animated: true)
            
            // 현재 위치에 마커 추가
            let annotation = MKPointAnnotation()
            annotation.coordinate = userLocation.coordinate
            annotation.title = "현재 위치"
            LocationMapView.addAnnotation(annotation)
            
            // 현재 위치 주소 가져오기
            geocoder.reverseGeocodeLocation(userLocation) { (placemarks, error) in
                if let placemark = placemarks?.first {
                    let address = "\(placemark.locality ?? ""), \(placemark.country ?? "")"
                    self.MyLocationLabel.text = "현재 위치: \(address)"
                }
            }
        }
    }
    
    // 권한 거부 시 메시지 표시
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Error: \(error.localizedDescription)")
    }
    
    // 텍스트 필드에서 Return 키를 눌렀을 때 주소를 검색
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        
        if let address = textField.text {
            geocodeAddress(address)
        }
        
        return true
    }
    
    // 주소를 좌표로 변환하고 지도 이동
    func geocodeAddress(_ address: String) {
        geocoder.geocodeAddressString(address) { [weak self] (placemarks, error) in
            guard let strongSelf = self else { return }
            if let error = error {
                print("Geocoding error: \(error.localizedDescription)")
                return
            }
            
            if let placemark = placemarks?.first, let location = placemark.location {
                let coordinate = location.coordinate
                
                
                let latitude = coordinate.latitude
                let longitude = coordinate.longitude
                print("입력된 주소 좌표 - 위도: \(latitude), 경도: \(longitude)")
                // 지도 이동
                let region = MKCoordinateRegion(center: coordinate, latitudinalMeters: 1000, longitudinalMeters: 1000)
                strongSelf.LocationMapView.setRegion(region, animated: true)
                
                // 좌표 정보 표시
                strongSelf.LocationLabel.text = "선택된 위치: \(placemark.locality ?? ""), \(placemark.country ?? "")"
            }
        }
    }
    
    // 위치 권한 상태 변경 시 호출
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        switch manager.authorizationStatus {
        case .authorizedWhenInUse, .authorizedAlways:
            locationManager.startUpdatingLocation()
        case .denied, .restricted:
            print("위치 권한이 거부되었습니다.")
            // 사용자에게 위치 권한 설정 안내
        case .notDetermined:
            print("위치 권한 상태를 결정하지 않았습니다.")
        @unknown default:
            break
        }
    }
}
